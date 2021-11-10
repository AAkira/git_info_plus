#import "GitInfoPlusPlugin.h"
#if __has_include(<git_info_plus/git_info_plus-Swift.h>)
#import <git_info_plus/git_info_plus-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "git_info_plus-Swift.h"
#endif

@implementation GitInfoPlusPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftGitInfoPlusPlugin registerWithRegistrar:registrar];
}
@end
