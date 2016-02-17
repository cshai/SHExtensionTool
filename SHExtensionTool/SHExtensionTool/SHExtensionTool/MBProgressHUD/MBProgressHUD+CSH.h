//
//  MBProgressHUD+CSH.h
//  东田教育
//
//  Created by Sam on 15/12/8.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (CSH)


// 显示一个只有文字的消息，1秒后自动隐藏
+ (void)showOnlyText:(NSString *)text toView:(UIView *)view;
+ (void)showOnlyText:(NSString *)text;

// 显示一个带成功图片的消息，1秒后自动隐藏
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showSuccess:(NSString *)success;


// 显示一个带失败图片的消息，1秒后自动隐藏
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (void)showError:(NSString *)error;


// 显示一个带加载动画的消息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
+ (MBProgressHUD *)showMessage:(NSString *)message;


//隐藏一个消息
+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;


@end
