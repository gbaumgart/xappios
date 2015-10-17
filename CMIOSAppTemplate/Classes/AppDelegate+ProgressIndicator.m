//
//  ApplicationDelegate+ProgressIndicator.m
//  BuzzOffBase
//
//  Created by mc007 on 24/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//
#import "AppDelegate.h"
#import "AppDelegate+ProgressIndicator.h"
#import "MBProgressHUD.h"
#import "ATMHud.h"
#import "ATMHudDelegate.h"
#import "ATMHudView.h"

@implementation AppDelegate (ProgressIndicator)
//+(NSString*)getUrlForObject:(id)object dataCollection:(DataCollection*)dataCollection;
+(ATMHud*)simpleProgressShowOnWebView:(NSString*)caption webView:(UIView*)webview {
    AppDelegate *del = [AppDelegate sharedInstance];
    
//    UIViewController *cController = del.viewController;
    UIView *baseView = webview;
    
    if(del.simpleHud!=nil)
    {
        NSLog(@"destroy loader");
        [del.simpleHud hide];
        [del.simpleHud release];
        del.simpleHud = nil;
    }
    
    if(del.simpleHud==nil){

        NSLog(@"create loader");
        del.simpleHud= [[ATMHud alloc] initWithDelegate:self];
        [baseView addSubview:del.simpleHud.view];
        
        if(caption==nil){
            [del.simpleHud setCaption:@"Loading"];
        }else {
            [del.simpleHud setCaption:caption];
        }
        
        [del.simpleHud setActivity:YES];
        [del.simpleHud show];
        return del.simpleHud;
//        [del.simpleHud hideAfter:14];
    }
    
}
+(void)simpleProgressShow:(NSString*)caption{
    AppDelegate *del = [AppDelegate sharedInstance];

    UIViewController *cController = del.viewController;
    UIView *baseView = cController.view;

    if(del.simpleHud!=nil)
    {
        [del.simpleHud hide];
        [del.simpleHud release];
        del.simpleHud = nil;
    }
    
    if(del.simpleHud==nil){

        del.simpleHud= [[ATMHud alloc] initWithDelegate:self];
        [baseView addSubview:del.simpleHud.view];

        if(caption==nil){
            [del.simpleHud setCaption:@"Loading"];
        }else {
            [del.simpleHud setCaption:caption];
        }

        [del.simpleHud setActivity:YES];
        [del.simpleHud show];
        [del.simpleHud hideAfter:5];
    }

}
+(void)simpleProgressHide{

    
    AppDelegate *del = [AppDelegate sharedInstance];
    
    if(del.simpleHud!=nil)
    {
        [del.simpleHud hide];
        [del.simpleHud release];
        del.simpleHud = nil;
    }
    
    
}



+(void)showLoadingProgress
{
    AppDelegate *delegate = [AppDelegate sharedInstance];
    [delegate performSelector:@selector(showLoadingProgressInternal) onThread:[NSThread mainThread] withObject:nil waitUntilDone:FALSE];
    [delegate performSelector:@selector(hideLoadingProgressInternal) withObject:nil afterDelay:0.5];
    /*
    TTNavigator *navi = [TTNavigator navigator];
    if(delegate.HUD==nil)
    {
        TTActivityLabel* label = [[TTActivityLabel alloc] initWithStyle:TTActivityLabelStyleBlackBezel];
        
        label.text = @"Loading";
        [label sizeToFit];
        
        CGRect r = label.frame;
        CGRect h = delegate.HUD.frame;
        
        delegate.HUD = [[MBProgressHUD alloc] initWithWindow:navi.window];
        delegate.HUD.yOffset = -70;
        label.frame = CGRectMake(0, delegate.HUD.bottom+10, delegate.HUD.width, label.height);
        delegate.HUD.customView = label;
        delegate.HUD.delegate = delegate;
        delegate.HUD.mode = MBProgressHUDModeCustomView;
        label.progress = 0.0;
        //delegate.HUD.removeFromSuperViewOnHide = true;
    }
    
    if(navi!=nil && navi.visibleViewController!=nil)
    {
        [navi.visibleViewController.view addSubview:delegate.HUD];
    }
    
    [delegate.HUD show:TRUE];*/
    
}

@end
