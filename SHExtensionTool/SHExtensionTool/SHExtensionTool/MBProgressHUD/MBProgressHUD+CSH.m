//
//  MBProgressHUD+CSH.m
//  东田教育
//
//  Created by Sam on 15/12/8.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MBProgressHUD+CSH.h"


static __weak UIView *kHuDMainView;

@implementation MBProgressHUD (CSH)

#pragma mark 显示信息
+ (void)showWithIcon:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 2秒之后再消失
    [hud hide:YES afterDelay:0.8];
}


+ (void)showOnlyText:(NSString *)text toView:(UIView *)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    // 2秒之后再消失
    [hud hide:YES afterDelay:0.8];
}



#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self showWithIcon:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self showWithIcon:success icon:@"success.png" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    // hud.dimBackground = YES;
    return hud;
}

+ (void)hideHUDForView:(UIView *)view
{
    [self hideHUDForView:view animated:YES];
}

+ (void)showSuccess:(NSString *)success
{
    [self refreshMainView];
    [self showSuccess:success toView:kHuDMainView];
}

+ (void)showError:(NSString *)error
{
    [self refreshMainView];
    
    [self showError:error toView:kHuDMainView];
}

+ (void)showOnlyText:(NSString *)text
{
    [self refreshMainView];
    
    [self showOnlyText:text toView:kHuDMainView];
}


+ (MBProgressHUD *)showMessage:(NSString *)message
{
   [self refreshMainView];
    return [self showMessage:message toView:kHuDMainView];
}

+ (void)hideHUD
{
    [self refreshMainView];
    [self hideHUDForView:kHuDMainView];
}


+ (void) refreshMainView
{
    if (kHuDMainView != nil)
    {
        [self hideHUDForView:kHuDMainView];
        kHuDMainView = nil;
    }
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        if (!window.isKeyWindow)continue;
        kHuDMainView = window;
        break;
    }
}

@end
