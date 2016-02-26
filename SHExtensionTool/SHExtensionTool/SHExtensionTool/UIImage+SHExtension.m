//
//  UIImage+SHExtension.m
//
//  Created by apple on 15/10/14.
//  Copyright © 2015年 renpan. All rights reserved.
//

#import "UIImage+SHExtension.h"

@implementation UIImage (SHExtension)

- (UIImage*)scaleImageToSize:(CGSize)size resizingInsets:(UIEdgeInsets)insets resizingMode:(UIImageResizingMode)mode
{
    UIImage *image = [self resizableImageWithCapInsets:insets resizingMode:mode];
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return scaledImage;
}


- (UIImage*)scaleImageWithScale:(CGFloat)scale resizingInsets:(UIEdgeInsets)insets resizingMode:(UIImageResizingMode)mode
{
    CGSize size = CGSizeMake(self.size.width * scale, self.size.height * scale);
    return [self scaleImageToSize:size resizingInsets:insets resizingMode:mode];
}

//保存一张图片到指定文件目录
- (NSString *) saveImageToFileWithQuality:(CGFloat) quality dir: (NSString *)dir name:(NSString* )name
{
    NSString *dirpath = [NSHomeDirectory() stringByAppendingPathComponent:dir];
    [[NSFileManager defaultManager] createDirectoryAtPath:dirpath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *path = [dirpath stringByAppendingPathComponent:name];
    BOOL result = [UIImageJPEGRepresentation(self, quality) writeToFile:path atomically:YES];
    if (result) {
        return path;
    }
    return nil;
}

@end
