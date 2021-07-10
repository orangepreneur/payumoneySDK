#import "PayumoneyProUnofficialPlugin.h"
#if __has_include(<payumoney_pro_unofficial/payumoney_pro_unofficial-Swift.h>)
#import <payumoney_pro_unofficial/payumoney_pro_unofficial-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "payumoney_pro_unofficial-Swift.h"
#endif

@implementation PayumoneyProUnofficialPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPayumoneyProUnofficialPlugin registerWithRegistrar:registrar];
}
@end
