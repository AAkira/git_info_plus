# git_info_plus

[![pub package](https://img.shields.io/pub/v/git_info_plus.svg)](https://pub.dev/packages/git_info_plus)

Get git information from within the Flutter application.

![screenshot-android][screenshot-android] ![screenshot-ios][screenshot-ios]

## Usage

### Dart

```dart
final String? branchName = await GitInfo.branchName;
final DateTime? lastCommitDate = await GitInfo.lastCommitDate;
final String? lastCommitHash = await GitInfo.lastCommitHash;
final String? lastCommitHashShort = await GitInfo.lastCommitHashShort;
final String? lastCommitMessage = await GitInfo.lastCommitMessage;
```

## Setup

### Android

You do not need to set this up.

#### Optional

If the git command fails or returns an empty value (e.g. detached HEAD on CI), the plugin reads these environment variables instead.
If neither is available, the value is `null` in Dart.

|Environment variable|Example|
|:-:|:-:|
|GIT_BRANCH_NAME|main|
|GIT_LAST_COMMIT_DATE|2024-01-01 12:00:00 +0900|
|GIT_LAST_COMMIT_HASH|ff4aa27c2d8e0a1b5f3c9d7e6a4b2c1d0e9f8a7b|
|GIT_LAST_COMMIT_HASH_SHORT|ff4aa27|
|GIT_LAST_COMMIT_MESSAGE|Initial commit.|

The date uses the same format as `git log --format=%ai`.
Quotes and backslashes in the values are escaped automatically.

### iOS

This plugin supports both Swift Package Manager and CocoaPods.
You do not need to change anything for either of them.

In order to use this library on IOS, you have to do some settings.

#### 1. Add values in your info.plist

|Key|Type|Value|
|:-:|:-:|:-:|
|GitBranchName|String|undefined|
|GitCommitDate|String|undefined|
|GitCommitHash|String|undefined|
|GitCommitHashShort|String|undefined|
|GitCommitMessage|String|undefined|

You can also copy and paste these lines.

```
<key>GitBranchName</key>
<string>undefined</string>
<key>GitCommitDate</key>
<string>undefined</string>
<key>GitCommitHash</key>
<string>undefined</string>
<key>GitCommitHashShort</key>
<string>undefined</string>
<key>GitCommitMessage</key>
<string>undefined</string>
```

![setup-ios-1][setup-ios-1]

#### 2. Enable Processes Info.plist File

`BuildSettings > Processes Info.plist File`  
Change to YES

![setup-ios-2][setup-ios-2]

#### 3-A. Add Run Script

`BuildPhase >`

Add new Run Script and paste these lines.

```bash
infoPlistFile="${TEMP_DIR}/Preprocessed-Info.plist"

branchName=$(git branch --show-current)
commitDate=$(git --no-pager log -1 --format=%ai)
commitHash=$(git rev-parse HEAD)
commitHashShort=$(git rev-parse --short HEAD)
commitMessage=$(git log -1 --pretty=%s)

# Xcode expands $VAR in Info.plist values after this script, so "$" has to be written as "$$".
# LC_ALL=C keeps sed from rejecting invalid UTF-8 and emptying the value.
setPlistString() {
  plutil -replace "$1" -string "$(printf '%s' "$2" | LC_ALL=C sed 's/\$/$$/g')" "$infoPlistFile"
}

setPlistString GitBranchName "$branchName"
setPlistString GitCommitDate "$commitDate"
setPlistString GitCommitHash "$commitHash"
setPlistString GitCommitHashShort "$commitHashShort"
setPlistString GitCommitMessage "$commitMessage"
```

![setup-ios-3][setup-ios-3]

`BuildSettings > User Script Sandboxing` (`ENABLE_USER_SCRIPT_SANDBOXING`) must be NO.
The sandbox blocks the script from accessing the git repository and the plist.

#### 3-B. Add Input Files.

`${TEMP_DIR}/Preprocessed-Info.plist`


[screenshot-android]: https://raw.githubusercontent.com/AAkira/git_info_plus/master/arts/screenshot-android.png
[screenshot-ios]: https://raw.githubusercontent.com/AAkira/git_info_plus/master/arts/screenshot-ios.png
[setup-ios-1]: https://raw.githubusercontent.com/AAkira/git_info_plus/master/arts/setup-ios-1.jpg
[setup-ios-2]: https://raw.githubusercontent.com/AAkira/git_info_plus/master/arts/setup-ios-2.jpg
[setup-ios-3]: https://raw.githubusercontent.com/AAkira/git_info_plus/master/arts/setup-ios-3.jpg
