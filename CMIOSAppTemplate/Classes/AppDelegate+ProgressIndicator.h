#import "AppDelegate.h"

@interface AppDelegate (ProgressIndicator)

+(void)simpleProgressShow:(NSString*)caption;
+(ATMHud*)simpleProgressShowOnWebView:(NSString*)caption webView:(UIView*)webview;
+(void)simpleProgressHide;
+(void)initLoadingProgress;
+(void)showLoadingProgress;
+(void)hideLoadingProgress;
+(void)updateProgress:(float)progress;
-(void)showLoadingProgressInternal;
-(void)hideLoadingProgressInternal;
@end
