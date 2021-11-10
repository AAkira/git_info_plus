# git_info_plus

[![pub package](https://img.shields.io/pub/v/git_info_plus.svg)](https://pub.dev/packages/git_info_plus)

Get git information from within the Flutter application.

![screenshot-android][screenshot-android] ![screenshot-ios][screenshot-ios]

## Usage

### Dart

```dart
final String branchName = await GitInfo.branchName;
final DateTime lastCommitDate = await GitInfo.lastCommitDate;
final String lastCommitHash = await GitInfo.lastCommitHash;
final String lastCommitHashShort = await GitInfo.lastCommitHashShort;
final String lastCommitMessage = await GitInfo.lastCommitMessage;
```

## Setup

### Android

You do not need to set this up.

### iOS

In order to use this library on IOS, you have to do some settings.

#### 1. Add values in your info.plist

|Key|Type|Value|
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

#### 3. Add Run Script

`BuildPhase >`

Add new Run Script and paste these lines.

```bash
plistBuddy="/usr/libexec/PlistBuddy"
infoPlistFile="${TEMP_DIR}/Preprocessed-Info.plist"

branchName=$(git rev-parse --abbrev-ref HEAD)
commitDate=$(git --no-pager log -1 --format="%ai")
commitHash=$(git rev-parse --short HEAD)
commitHashShort=$(git rev-parse HEAD)
commitMessage=$(git log -1 --pretty=%s)

$plistBuddy -c "Set :GitBranchName $branchName" $infoPlistFile
$plistBuddy -c "Set :GitCommitDate $commitDate" $infoPlistFile
$plistBuddy -c "Set :GitCommitHash $commitHash" $infoPlistFile
$plistBuddy -c "Set :GitCommitHashShort $commitHashShort" $infoPlistFile
$plistBuddy -c "Set :GitCommitMessage $commitMessage" $infoPlistFile
```

![setup-ios-3][setup-ios-3]

#### 4. Add Input Files.

`${TEMP_DIR}/Preprocessed-Info.plist`


[screenshot-android]: /arts/screenshot-android.png
[screenshot-ios]: /arts/screenshot-ios.png
[setup-ios-1]: /arts/setup-ios-1.jpg
[setup-ios-2]: /arts/setup-ios-2.jpg
[setup-ios-3]: /arts/setup-ios-3.jpg
