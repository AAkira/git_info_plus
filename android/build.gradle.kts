group = "io.github.aakira.git_info_plus"
version = "1.0-SNAPSHOT"

buildscript {
    val kotlinVersion = "2.4.20"
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath("com.android.tools.build:gradle:9.3.1")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlinVersion")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

plugins {
    id("com.android.library")
}

android {
    namespace = "io.github.aakira.git_info_plus"

    compileSdk = 36

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    buildFeatures {
        buildConfig = true
    }

    sourceSets {
        getByName("main") {
            java.srcDirs("src/main/kotlin")
        }
    }

    defaultConfig {
        minSdk = 24

        buildConfigField("String", "GIT_BRANCH_NAME", toJavaLiteral(getBranchName()))
        buildConfigField("String", "GIT_LAST_COMMIT_DATE", toJavaLiteral(getLastCommitDate()))
        buildConfigField("String", "GIT_LAST_COMMIT_HASH", toJavaLiteral(getHash()))
        buildConfigField("String", "GIT_LAST_COMMIT_HASH_SHORT", toJavaLiteral(getHashShort()))
        buildConfigField("String", "GIT_LAST_COMMIT_MESSAGE", toJavaLiteral(getCommitMessage()))
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

fun getBranchName(): String? =
    execCommand(listOf("git", "branch", "--show-current")) ?: envValue("GIT_BRANCH_NAME")

// Versions before 0.1.0 embedded the env value as is, so users had to pass it quoted.
fun getLastCommitDate(): String? =
    execCommand(listOf("git", "--no-pager", "log", "-1", "--format=%ai"))
        ?: envValue("GIT_LAST_COMMIT_DATE")
            ?.removeSurrounding("\"")
            ?.trim()
            ?.takeIf { it.isNotBlank() }

fun getHash(): String? =
    execCommand(listOf("git", "rev-parse", "HEAD")) ?: envValue("GIT_LAST_COMMIT_HASH")

fun getHashShort(): String? =
    execCommand(listOf("git", "rev-parse", "--short", "HEAD"))
        ?: envValue("GIT_LAST_COMMIT_HASH_SHORT")

fun getCommitMessage(): String? =
    execCommand(listOf("git", "log", "-1", "--pretty=%s"))
        ?: envValue("GIT_LAST_COMMIT_MESSAGE")

fun envValue(name: String): String? = System.getenv(name)?.trim()?.takeIf { it.isNotEmpty() }

// projectDir is not used because a pub cache copy of this plugin is not inside the app's repository.
// rootProject.projectDir is the app's android directory when this plugin is built as a dependency.
fun execCommand(command: List<String>): String? =
    try {
        val output = providers.exec {
            workingDir = rootProject.projectDir
            commandLine(command)
            isIgnoreExitValue = true
        }
        if (output.result.get().exitValue == 0) {
            output.standardOutput.asText.get().trim().takeIf { it.isNotEmpty() }
        } else {
            null
        }
    } catch (e: Exception) {
        null
    }

// Control characters are written as octal escapes because javac translates \uXXXX before lexing,
// so \u000a would end the string literal.
fun toJavaLiteral(value: String?): String {
    if (value == null) return "null"
    val escaped = buildString {
        for (c in value) {
            when {
                c == '\\' -> append("\\\\")
                c == '"' -> append("\\\"")
                c == '\n' -> append("\\n")
                c == '\r' -> append("\\r")
                c == '\t' -> append("\\t")
                c < ' ' -> append("\\%03o".format(c.code))
                else -> append(c)
            }
        }
    }
    return "\"$escaped\""
}
