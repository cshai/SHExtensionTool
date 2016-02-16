//
//  UIView+SHExtension.h
//
//  Created by Sam on 16/1/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SHExtension)

//背景图片
@property (nonatomic,strong,readonly) UIImage *ext_backgroundImage;

//背景图片的伸缩区域
@property (nonatomic,assign,readonly) UIEdgeInsets ext_backgroundImageEdgeInset;

//背景图片的拉伸模式
@property (nonatomic,assign,readonly) UIImageResizingMode ext_resizingMode;

//设置背景图片
- (void)setBackgroundWithImage:(UIImage *)image edgeInsets:(UIEdgeInsets) edgeInset resizingMode:(UIImageResizingMode)mode;

@end
