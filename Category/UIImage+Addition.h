//
//  UIImage+Addition.h
//  TeamTalk
//
//  Created by Michael Scofield on 2015-01-30.
//  Copyright (c) 2015 Michael Hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Addition)

+ (UIImage*)maskImage:(UIImage *)image withMask:(UIImage *)maskImage;

- (UIImage *)scaleImageToSize:(CGSize)size;

- (UIImage *)fixOrientation;
@end

/**
 * 类名：UIImage (Draw)
 * 功能：由代码创建图片
 * 用法：
 */
@interface UIImage (Draw)

/// 创建椭圆图片
+ (UIImage *)ellipseImageOfSize:(CGSize)imageSize color:(UIColor *)imageColor;

/// 创建矩形图片
+ (UIImage *)rectImageOfSize:(CGSize)imageSize color:(UIColor *)imageColor;

/// 创建矩形图片
+ (UIImage *)rectImageOfSize:(CGSize)imageSize color:(UIColor *)imageColor scale:(CGFloat)scale;

/// 创建矩形图片（带圆角）
+ (UIImage *)roundedRectImageOfSize:(CGSize)imageSize
                    backgroundColor:(UIColor *)backgroundColor
                        borderWidth:(CGFloat)borderWidth
                        borderColor:(UIColor *)borderColor
                       cornerRadius:(CGFloat)cornerRadius;

/// 创建矩形图片（带圆角）
+ (UIImage *)roundedRectImageOfSize:(CGSize)imageSize
                    backgroundColor:(UIColor *)backgroundColor
                        borderWidth:(CGFloat)borderWidth
                        borderColor:(UIColor *)borderColor
                       cornerRadius:(CGFloat)cornerRadius
                              scale:(CGFloat)scale;

/// 创建矩形图片（包含底边线）
+ (UIImage *)rectImageOfSize:(CGSize)imageSize
             backgroundColor:(UIColor *)backgroundColor
             bottomLineColor:(UIColor *)bottomLineColor
                   lineWidth:(CGFloat)lineWidth;

/// 创建矩形图片（包含底边线）
+ (UIImage *)rectImageOfSize:(CGSize)imageSize
             backgroundColor:(UIColor *)backgroundColor
             bottomLineColor:(UIColor *)bottomLineColor
                   lineWidth:(CGFloat)lineWidth
                       scale:(CGFloat)scale;

/// 创建矩形图片（包含左边线）
+ (UIImage *)rectImageOfSize:(CGSize)imageSize
             backgroundColor:(UIColor *)backgroundColor
               leftLineColor:(UIColor *)leftLineColor;

// not used
+ (UIImage *)stretchableImageOfName:(NSString *)imageName;

/// 根据颜色尺寸创建图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
@end



@interface UIImage (Pixellate)

+ (UIImage*)pixellateImage:(UIImage*)image;

+ (UIImage *)coreBlurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

- (void)saveToTmp:(NSString *)name;
@end

