## 0.1.0

* Update flutter version.
  - 3.50.1
* Support Swift Package Manager.
  - CocoaPods is still supported.
* Update libraries.
  - Gradle 9.5.0
  - Android Gradle plugin 9.3.1
  - Kotlin 2.4.20
  - compileSdk 36
  - JDK 17
* Raise the minimum versions.
  - Dart 3.14.0
  - Flutter 3.50.0
  - Android minSdk 24
  - iOS 15.0
* Run git commands from the root project directory in Android.
* Escape quotes and backslashes in git values in Android.
* Fall back to environment variables when git returns an empty value in Android.
  - Quotes around `GIT_LAST_COMMIT_DATE` are optional.
* Return null instead of the string "null" when a value is missing in Android.
* Return null instead of crashing when the date is missing in Dart.
* Return null instead of crashing when a key is missing in iOS.
* Return null instead of an empty string in iOS.
  - The branch name on detached HEAD is now null (previously "HEAD").
* Fix the iOS Run Script to handle commit messages containing spaces, quotes, backslashes and `$`.
  - Use `git branch --show-current` for the branch name.

## 0.0.6

* Update flutter version.
  - 3.19.4

## 0.0.5

* Update libraries.
  - Gradle
  - Kotlin
  - Gradle plugin
  - JDK version
 
## 0.0.4

* Read environment valus if git command is null in Android.

## 0.0.3

* Fix hash short command in iOS.
* Modify git branch name command.

## 0.0.2

Fix gradle working directory in Android module.

## 0.0.1

Release git_info_plus 0.0.1🎉
