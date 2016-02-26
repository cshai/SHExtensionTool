//
//  UIButton+SHExtension.h
//  家校互通家长端
//
//  Created by Sam on 16/1/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIButtonExtensionImageStyle) {
    UIButtonExtensionImageStyleDefault                  = 0,
    UIButtonExtensionImageStyleCustomLeft               = 1,
    UIButtonExtensionImageStyleCustomRight              = 2,
    UIButtonExtensionImageStyleCustomBottom             = 3,
    UIButtonExtensionImageStyleCustomTop                = 4,
};

@interface UIButton (SHExtension)

//image的位置
@property (nonatomic,assign) UIButtonExtensionImageStyle ext_imageStyle;

//image的大小
@property (nonatomic,assign) CGSize ext_imageSize;

//title label大小
@property (nonatomic,assign) CGSize ext_titleLabelSize;

//image与title之间的距离
@property (nonatomic,assign) CGFloat ext_spacing;

//对image的top，与left进行调整，bottom，right暂时无效
@property (nonatomic,assign) UIEdgeInsets ext_imageEdgeInsets;
//对title的top，与left进行调整，bottom，right暂时无效
@property (nonatomic,assign) UIEdgeInsets ext_titleLabelEdgeInsets;

//设置背景
- (void)setBackgroundWithImage:(UIImage *)image edgeInsets:(UIEdgeInsets)edgeInset forState:(UIControlState)state;

@end
