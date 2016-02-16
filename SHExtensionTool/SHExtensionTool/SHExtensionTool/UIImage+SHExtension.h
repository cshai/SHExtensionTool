//
//  UIImage+SHExtension.h
//
//  Created by apple on 15/10/14.
//  Copyright © 2015年 renpan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SHExtension)

// 根据图片名字返回一张缩放过图片
+ (UIImage *)resizableImageWithName:(NSString *)imageName;


//更具Insets 缩放一张图片到指定大小
- (UIImage*)scaleImageToSize:(CGSize)size resizingInsets:(UIEdgeInsets)insets resizingMode:(UIImageResizingMode)mode;

//更具Insets 缩放一张图片按照指定比例
- (UIImage*)scaleImageWithScale:(CGFloat)scale resizingInsets:(UIEdgeInsets)insets resizingMode:(UIImageResizingMode)mode;

- (NSString *)saveImageToFileWithQuality:(CGFloat)quality dir:(NSString *)dir name:(NSString* )name;

@end
