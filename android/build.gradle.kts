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

        buildConfigField("String", "GIT_BRANCH_NAME", "\"${getBranchName()}\"")
        buildConfigField("String", "GIT_LAST_COMMIT_DATE", "${getLastCommitDate()}")
        buildConfigField("String", "GIT_LAST_COMMIT_HASH", "\"${getHash()}\"")
        buildConfigField("String", "GIT_LAST_COMMIT_HASH_SHORT", "\"${getHashShort()}\"")
        buildConfigField("String", "GIT_LAST_COMMIT_MESSAGE", "\"${getCommitMessage()}\"")
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

fun getBranchName(): String? =
    execCommand(listOf("git", "branch", "--show-current")) ?: System.getenv("GIT_BRANCH_NAME")

// Git emits the double quotes itself because the value is embedded in BuildConfig as a raw Java literal.
fun getLastCommitDate(): String? =
    execCommand(listOf("git", "--no-pager", "log", "-1", "--format=\"%ai\""))
        ?: System.getenv("GIT_LAST_COMMIT_DATE")

fun getHash(): String? =
    execCommand(listOf("git", "rev-parse", "HEAD")) ?: System.getenv("GIT_LAST_COMMIT_HASH")

fun getHashShort(): String? =
    execCommand(listOf("git", "rev-parse", "--short", "HEAD"))
        ?: System.getenv("GIT_LAST_COMMIT_HASH_SHORT")

fun getCommitMessage(): String? =
    execCommand(listOf("git", "log", "-1", "--pretty=%s"))
        ?: System.getenv("GIT_LAST_COMMIT_MESSAGE")

// projectDir is not used because a pub cache copy of this plugin is not inside the app's repository.
// rootProject.projectDir is the app's android directory when this plugin is built as a dependency.
fun execCommand(command: List<String>): String? =
    try {
        val output = providers.exec {
            workingDir = rootProject.projectDir
            commandLine(command)
            isIgnoreExitValue = true
        }
        if (output.result.get().exitValue == 0) output.standardOutput.asText.get().trim() else null
    } catch (e: Exception) {
        null
    }
