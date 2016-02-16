//
//  UIButton+SHExtension.m
//  家校互通家长端
//
//  Created by Sam on 16/1/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIButton+SHExtension.h"
#import <objc/runtime.h>
#import "RSSwizzle.h"

static char key_ext_imageStyle;
static char key_ext_imageSize[2];
static char key_ext_titleLabelSize[2];
static char key_ext_spacing;
static char key_ext_imageEdgeInsets[4];
static char key_ext_titleLabelEdgeInsets[4];

static char key_layoutSubviews;

@implementation UIButton (SHExtension)


+ (void)load {
    RSSwizzleInstanceMethod(self,
                            @selector(layoutSubviews),
                            RSSWReturnType(void),
                            RSSWArguments(),
                            RSSWReplacement(
                                            {
                                                RSSWCallOriginal();
                                                [self sh_ext_layoutSubviews];
                                            }), RSSwizzleModeOncePerClassAndSuperclasses, &key_layoutSubviews);
}

- (void)setExt_imageStyle:(UIButtonExtensionImageStyle)ext_imageStyle
{
    objc_setAssociatedObject(self, &key_ext_imageStyle, @(ext_imageStyle), OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self layoutSubviews];
}

- (void)setExt_imageSize:(CGSize)ext_imageSize
{
    objc_setAssociatedObject(self, &key_ext_imageSize[0], @(ext_imageSize.width), OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &key_ext_imageSize[1], @(ext_imageSize.height), OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self layoutSubviews];
}

- (void)setExt_titleLabelSize:(CGSize)ext_titleLabelSize
{
    objc_setAssociatedObject(self, &key_ext_titleLabelSize[0], @(ext_titleLabelSize.width), OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &key_ext_titleLabelSize[1], @(ext_titleLabelSize.height), OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self layoutSubviews];
}

- (void)setExt_spacing:(CGFloat)ext_spacing
{
    objc_setAssociatedObject(self, &key_ext_spacing, @(ext_spacing), OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self layoutSubviews];
}

- (void)setExt_imageEdgeInsets:(UIEdgeInsets)ext_imageEdgeInsets
{
    objc_setAssociatedObject(self, &key_ext_imageEdgeInsets[0], @(ext_imageEdgeInsets.top), OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &key_ext_imageEdgeInsets[1], @(ext_imageEdgeInsets.left), OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &key_ext_imageEdgeInsets[2], @(ext_imageEdgeInsets.bottom), OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &key_ext_imageEdgeInsets[3], @(ext_imageEdgeInsets.right), OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self layoutSubviews];
}

- (void)setExt_titleLabelEdgeInsets:(UIEdgeInsets)ext_titleLabelEdgeInsets
{
    objc_setAssociatedObject(self, &key_ext_titleLabelEdgeInsets[0], @(ext_titleLabelEdgeInsets.top), OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &key_ext_titleLabelEdgeInsets[1], @(ext_titleLabelEdgeInsets.left), OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &key_ext_titleLabelEdgeInsets[2], @(ext_titleLabelEdgeInsets.bottom), OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &key_ext_titleLabelEdgeInsets[3], @(ext_titleLabelEdgeInsets.right), OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self layoutSubviews];
}


- (UIButtonExtensionImageStyle) ext_imageStyle{
    return [objc_getAssociatedObject(self, &key_ext_imageStyle) integerValue];
}

- (CGSize)ext_imageSize
{
    CGSize size;
    size.width = [objc_getAssociatedObject(self, &key_ext_imageSize[0]) floatValue];
    size.height = [objc_getAssociatedObject(self, &key_ext_imageSize[1]) floatValue];
    return size;
    
}

- (CGSize)ext_titleLabelSize
{
    CGSize size;
    size.width = [objc_getAssociatedObject(self, &key_ext_titleLabelSize[0]) floatValue];
    size.height = [objc_getAssociatedObject(self, &key_ext_titleLabelSize[1]) floatValue];
    return size;
}

- (CGFloat)ext_spacing
{
    NSNumber *spacing = objc_getAssociatedObject(self, &key_ext_spacing);
    if (spacing) {
        return [spacing floatValue];
    }
    return 8.0;
}

- (UIEdgeInsets)ext_imageEdgeInsets
{
    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
    edgeInsets.top = [objc_getAssociatedObject(self, &key_ext_imageEdgeInsets[0]) floatValue];
    edgeInsets.left = [objc_getAssociatedObject(self, &key_ext_imageEdgeInsets[1]) floatValue];
    edgeInsets.bottom = [objc_getAssociatedObject(self, &key_ext_imageEdgeInsets[2]) floatValue];
    edgeInsets.right = [objc_getAssociatedObject(self, &key_ext_imageEdgeInsets[3]) floatValue];
    return edgeInsets;
}

- (UIEdgeInsets)ext_titleLabelEdgeInsets
{
    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
    edgeInsets.top = [objc_getAssociatedObject(self, &key_ext_titleLabelEdgeInsets[0]) floatValue];
    edgeInsets.left = [objc_getAssociatedObject(self, &key_ext_titleLabelEdgeInsets[1]) floatValue];
    edgeInsets.bottom = [objc_getAssociatedObject(self, &key_ext_titleLabelEdgeInsets[2]) floatValue];
    edgeInsets.right = [objc_getAssociatedObject(self, &key_ext_titleLabelEdgeInsets[3]) floatValue];
    return edgeInsets;
}


#define isZeroWithCGFloat(f)     (f < 0.1 && f > -0.1)
#define isZeroWithCGSize(size)   (isZeroWithCGFloat(size.width) && isZeroWithCGFloat(size.height))
#define isZeroWithUIEdgeInsets(insets)   (isZeroWithCGFloat(insets.top) && isZeroWithCGFloat(insets.left) && isZeroWithCGFloat(insets.bottom) && isZeroWithCGFloat(insets.right))

#define kStringDisplayHeightByWidth(text,width,font)           [text boundingRectWithSize:CGSizeMake((width), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :(font)} context:nil].size.height

#define kStringDisplayWidthByHeight(text,height,font)          [text boundingRectWithSize:CGSizeMake(MAXFLOAT, (height)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :(font)} context:nil].size.width

- (void)sh_ext_layoutSubviews
{
    if (!self.imageView) return;
    CGFloat totalHeight = self.frame.size.height;
    CGFloat totalWidth = self.frame.size.width;
    CGSize imageSize = isZeroWithCGSize (self.ext_imageSize) ? self.imageView.frame.size : self.ext_imageSize;
    CGSize defualt_titleSize;
    defualt_titleSize.height = self.titleLabel.frame.size.height;
    defualt_titleSize.width = kStringDisplayWidthByHeight(self.currentTitle,defualt_titleSize.height, self.titleLabel.font);
    CGSize titleSize = isZeroWithCGSize (self.ext_titleLabelSize) ? defualt_titleSize: self.ext_titleLabelSize;
    CGFloat spacing = self.ext_spacing;
    UIEdgeInsets imageEdgeInsets = self.ext_imageEdgeInsets;
    UIEdgeInsets titleEdgeInsets = self.ext_titleLabelEdgeInsets;
    
    switch (self.ext_imageStyle) {
        case UIButtonExtensionImageStyleCustomLeft:
        {
            CGRect imageFrame;
            imageFrame.origin.x = (totalWidth - titleSize.width - spacing - imageSize.width) / 2 ;
            imageFrame.origin.y = (totalHeight - imageSize.height) / 2 ;
            imageFrame.size = imageSize;
            imageFrame.origin.x += imageEdgeInsets.left;
            imageFrame.origin.y += imageEdgeInsets.top;
            self.imageView.frame = imageFrame;
            
            CGRect titleFrame;
            titleFrame.origin.x = CGRectGetMaxX(imageFrame) + spacing;
            titleFrame.origin.y = (totalHeight - titleSize.height) /2;
            titleFrame.size = titleSize;
            titleFrame.origin.x += titleEdgeInsets.left;
            titleFrame.origin.y += titleEdgeInsets.top;
            self.titleLabel.frame = titleFrame;
            
        }break;
        case UIButtonExtensionImageStyleCustomRight:
        {
            CGRect titleFrame;
            titleFrame.origin.x = (totalWidth - titleSize.width - spacing - imageSize.width) / 2 ;
            titleFrame.origin.y = (totalHeight - titleSize.height) /2;
            titleFrame.size = titleSize;
            titleFrame.origin.x += titleEdgeInsets.left;
            titleFrame.origin.y += titleEdgeInsets.top;
            self.titleLabel.frame = titleFrame;
            
            CGRect imageFrame;
            imageFrame.origin.x = CGRectGetMaxX(titleFrame) + spacing;
            imageFrame.origin.y = (totalHeight - imageSize.height) / 2 ;
            imageFrame.size = imageSize;
            imageFrame.origin.x += imageEdgeInsets.left;
            imageFrame.origin.y += imageEdgeInsets.top;
            self.imageView.frame = imageFrame;
            
        }break;
        case UIButtonExtensionImageStyleCustomTop:
        {
            CGRect imageFrame;
            imageFrame.origin.x = (totalWidth - imageSize.width) / 2 ;
            imageFrame.origin.y = (totalHeight - imageSize.height - titleSize.height - self.ext_spacing) / 2;
            imageFrame.size = imageSize;
            imageFrame.origin.x += imageEdgeInsets.left;
            imageFrame.origin.y += imageEdgeInsets.top;
            self.imageView.frame = imageFrame;
            
            CGRect titleFrame;
            titleFrame.origin.x = (totalWidth - titleSize.width) / 2 ;
            titleFrame.origin.y = CGRectGetMaxY(imageFrame) + spacing;
            titleFrame.size = titleSize;
            titleFrame.origin.x += titleEdgeInsets.left;
            titleFrame.origin.y += titleEdgeInsets.top;
            self.titleLabel.frame = titleFrame;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
        }break;
        case UIButtonExtensionImageStyleCustomBottom:
        {
            CGRect titleFrame;
            titleFrame.origin.x = (totalWidth - titleSize.width) / 2 ;
            titleFrame.origin.y = (totalHeight - imageSize.height - titleSize.height - self.ext_spacing) / 2;
            titleFrame.size = titleSize;
            titleFrame.origin.x += titleEdgeInsets.left;
            titleFrame.origin.y += titleEdgeInsets.top;
            self.titleLabel.frame = titleFrame;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            CGRect imageFrame;
            imageFrame.origin.x = (totalWidth - imageSize.width) / 2 ;
            imageFrame.origin.y = CGRectGetMaxY(titleFrame) + spacing;
            imageFrame.size = imageSize;
            imageFrame.origin.x += imageEdgeInsets.left;
            imageFrame.origin.y += imageEdgeInsets.top;
            self.imageView.frame = imageFrame;
            
        }break;
        default:
            break;
    }
}


@end
