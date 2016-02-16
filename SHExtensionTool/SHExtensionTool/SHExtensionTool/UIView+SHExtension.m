//
//  UIView+SHExtension.m
//
//  Created by Sam on 16/1/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIView+SHExtension.h"
#import <objc/runtime.h>
#import "RSSwizzle.h"

static char key_ext_backgroundImage;
static char key_ext_backgroundImageEdgeInset[4];
static char key_ext_resizingMode;

static char key_layoutSubviews;

@implementation UIView (SHExtension)

+ (void)load {
    SEL selector = NSSelectorFromString(@"layoutSubviews");
    RSSwizzleInstanceMethod(self,
                            selector,
                            RSSWReturnType(void),
                            RSSWArguments(),
                            RSSWReplacement(
                                            {
                                                RSSWCallOriginal();
                                                if ([self ext_backgroundImage]) {
                                                    UIImage * rImage;
                                                    UIGraphicsBeginImageContext([self frame].size);
                                                    rImage = [self ext_backgroundImage];
                                                    [rImage drawInRect:[self bounds]];
                                                    rImage = UIGraphicsGetImageFromCurrentImageContext();
                                                    UIGraphicsEndImageContext();
                                                    [self setBackgroundColor:[[UIColor alloc] initWithPatternImage:rImage]];
                                                }
                                            }), RSSwizzleModeAlways, &key_layoutSubviews);

}

- (UIImage *)ext_backgroundImage
{
    return objc_getAssociatedObject(self, &key_ext_backgroundImage);
}

- (UIEdgeInsets)ext_backgroundImageEdgeInset
{
    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
    edgeInsets.top = [objc_getAssociatedObject(self, &key_ext_backgroundImageEdgeInset[0]) floatValue];
    edgeInsets.left = [objc_getAssociatedObject(self, &key_ext_backgroundImageEdgeInset[1]) floatValue];
    edgeInsets.bottom = [objc_getAssociatedObject(self, &key_ext_backgroundImageEdgeInset[2]) floatValue];
    edgeInsets.right = [objc_getAssociatedObject(self, &key_ext_backgroundImageEdgeInset[3]) floatValue];
    return edgeInsets;
}

- (UIImageResizingMode)ext_resizingMode
{
    return [objc_getAssociatedObject(self, &key_ext_resizingMode) integerValue];
}

- (void)setExt_backgroundImage:(UIImage *)ext_backgroundImage{
    objc_setAssociatedObject(self, &key_ext_backgroundImage, ext_backgroundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setExt_backgroundImageEdgeInset:(UIEdgeInsets)ext_backgroundImageEdgeInset
{
    objc_setAssociatedObject(self, &key_ext_backgroundImageEdgeInset[0], @(ext_backgroundImageEdgeInset.top), OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &key_ext_backgroundImageEdgeInset[1], @(ext_backgroundImageEdgeInset.left), OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &key_ext_backgroundImageEdgeInset[2], @(ext_backgroundImageEdgeInset.bottom), OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &key_ext_backgroundImageEdgeInset[3], @(ext_backgroundImageEdgeInset.right), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setExt_resizingMode:(UIImageResizingMode)ext_resizingMode
{
    objc_setAssociatedObject(self, &key_ext_resizingMode, @(ext_resizingMode), OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

- (void)setBackgroundWithImage:(UIImage *)image edgeInsets:(UIEdgeInsets) edgeInset resizingMode:(UIImageResizingMode)mode
{
    UIImage *rImage;
    rImage = [image resizableImageWithCapInsets:edgeInset resizingMode:mode];
    self.ext_backgroundImage = rImage;
    self.ext_resizingMode = mode;
    self.ext_backgroundImageEdgeInset = edgeInset;
    [self setNeedsLayout];
    
}

@end
