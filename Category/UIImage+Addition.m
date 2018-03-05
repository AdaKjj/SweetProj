//
//  UIImage+Addition.m
//  TeamTalk
//
//  Created by Michael Scofield on 2015-01-30.
//  Copyright (c) 2015 Michael Hu. All rights reserved.
//

#import "UIImage+Addition.h"

@implementation UIImage (Addition)
+ (UIImage*)maskImage:(UIImage*)originImage toPath:(UIBezierPath*)path
{
    UIGraphicsBeginImageContextWithOptions(originImage.size, NO, 0);
    [path addClip];
    [originImage drawAtPoint:CGPointZero];
    UIImage* img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (CGImageRef)CopyImageAndAddAlphaChannel:(CGImageRef)sourceImage
{
    CGImageRef retVal = NULL;
    
    size_t width = CGImageGetWidth(sourceImage);
    size_t height = CGImageGetHeight(sourceImage);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef offscreenContext = CGBitmapContextCreate(NULL, width, height,
                                                          8, 0, colorSpace,
                                                          kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little);
    
    if (offscreenContext != NULL)
    {
        CGContextDrawImage(offscreenContext, CGRectMake(0, 0, width, height), sourceImage);
        retVal = CGBitmapContextCreateImage(offscreenContext);
        CGContextRelease(offscreenContext);
    }
    
    CGColorSpaceRelease(colorSpace);
    
    return retVal;
}


+ (UIImage*)maskImage:(UIImage *)image withMask:(UIImage *)maskImage
{
    CGImageRef maskRef = maskImage.CGImage;
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, true);
    
    CGImageRef sourceImage = [image CGImage];
    CGImageRef imageWithAlpha = sourceImage;
    if (CGImageGetAlphaInfo(sourceImage) == kCGImageAlphaNone) {
        imageWithAlpha = [[self class] CopyImageAndAddAlphaChannel:sourceImage];
    }
    
    CGImageRef masked = CGImageCreateWithMask(imageWithAlpha, mask);
    CGImageRelease(mask);
    if (sourceImage != imageWithAlpha) {
        CGImageRelease(imageWithAlpha);
    }
    
    UIImage* retImage = [UIImage imageWithCGImage:masked];
    CGImageRelease(masked);
    
    return retImage;
    
}

#pragma mark - 等比縮放image

- (UIImage *)scaleImageToSize:(CGSize)size {
    if (self.size.width > size.width) {
        UIGraphicsBeginImageContext(size);
        [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    }
    else {
        return self;
    }
}

- (UIImage *)fixOrientation
{
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    
    return img;
}

@end

@implementation UIImage (Draw)

+ (UIImage *)ellipseImageOfSize:(CGSize)imageSize color:(UIColor *)imageColor
{
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, imageColor.CGColor);
    
    CGContextSetShouldAntialias(context, YES);
    
    CGContextFillEllipseInRect(context, CGRectMake(0, 0, imageSize.width, imageSize.height));
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImage;
}

+ (UIImage *)rectImageOfSize:(CGSize)imageSize color:(UIColor *)imageColor
{
    return [UIImage rectImageOfSize:imageSize color:imageColor scale:0];
}

+ (UIImage *)rectImageOfSize:(CGSize)imageSize color:(UIColor *)imageColor scale:(CGFloat)scale
{
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, imageColor.CGColor);
    
    CGContextFillRect(context, CGRectMake(0, 0, imageSize.width, imageSize.height));
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImage;
}

+ (UIImage *)rectImageOfSize:(CGSize)imageSize
             backgroundColor:(UIColor *)backgroundColor
             bottomLineColor:(UIColor *)bottomLineColor
                   lineWidth:(CGFloat)lineWidth

{
    return [UIImage rectImageOfSize:imageSize
                    backgroundColor:backgroundColor
                    bottomLineColor:bottomLineColor
                          lineWidth:lineWidth
                              scale:0];
}


+ (UIImage *)rectImageOfSize:(CGSize)imageSize
             backgroundColor:(UIColor *)backgroundColor
             bottomLineColor:(UIColor *)bottomLineColor
                   lineWidth:(CGFloat)lineWidth
                       scale:(CGFloat)scale
{
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, lineWidth);
    
    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
    CGContextSetStrokeColorWithColor(context, bottomLineColor.CGColor);
    
    CGContextFillRect(context, CGRectMake(0, 0, imageSize.width, imageSize.height));
    
    CGContextMoveToPoint(context, 0, imageSize.height-lineWidth/2);
    CGContextAddLineToPoint(context, imageSize.width, imageSize.height-lineWidth/2);
    CGContextStrokePath(context);
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImage;
}


+ (UIImage *)rectImageOfSize:(CGSize)imageSize
             backgroundColor:(UIColor *)backgroundColor
               leftLineColor:(UIColor *)leftLineColor
{
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 2);
    
    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
    CGContextSetStrokeColorWithColor(context, leftLineColor.CGColor);
    
    CGContextFillRect(context, CGRectMake(0, 0, imageSize.width, imageSize.height));
    
    CGContextMoveToPoint(context, 2, 0);
    CGContextAddLineToPoint(context, 2, imageSize.height);
    CGContextStrokePath(context);
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImage;
}

+ (UIImage *)roundedRectImageOfSize:(CGSize)imageSize
                    backgroundColor:(UIColor *)backgroundColor
                        borderWidth:(CGFloat)borderWidth
                        borderColor:(UIColor *)borderColor
                       cornerRadius:(CGFloat)cornerRadius
{
    return [UIImage roundedRectImageOfSize:imageSize
                           backgroundColor:backgroundColor
                               borderWidth:borderWidth
                               borderColor:borderColor
                              cornerRadius:cornerRadius
                                     scale:0];
}


+ (UIImage *)roundedRectImageOfSize:(CGSize)imageSize
                    backgroundColor:(UIColor *)backgroundColor
                        borderWidth:(CGFloat)borderWidth
                        borderColor:(UIColor *)borderColor
                       cornerRadius:(CGFloat)cornerRadius
                              scale:(CGFloat)scale
{
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetShouldAntialias(context, YES);
    CGContextSetLineWidth(context, borderWidth);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
    
    // 重要：给图片加圆角边，一定要留出边线宽度，否则因为边线被截取，看不出来外测圆角，
    CGRect drawRect = CGRectInset(CGRectMake(0, 0, imageSize.width, imageSize.height),borderWidth/2.0,borderWidth/2.0);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:drawRect cornerRadius:cornerRadius];
    CGContextAddPath(context, path.CGPath);
    CGContextDrawPath(context, kCGPathEOFillStroke);
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}

+ (UIImage *)stretchableImageOfName:(NSString *)imageName
{
    return [[UIImage imageNamed:imageName] stretchableImageWithLeftCapWidth:4 topCapHeight:4];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <=0 || size.height <=0) {
        return nil;
    }
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size,NO, 0);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end


@implementation UIImage (Pixellate)

/*
 全图模糊  马赛克效果
 */
+ (UIImage*)pixellateImage:(UIImage*)image{
    
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    
    //创建filter 滤镜 马赛克效果
    CIFilter *fileter = [CIFilter filterWithName:@"CIPixellate"];
    [fileter setValue:ciImage forKey:kCIInputImageKey];
    [fileter setDefaults];
    [fileter setValue:@(20) forKey:kCIInputScaleKey];
    
    //导出图片
    CIImage *outPutImage = [fileter valueForKey:kCIOutputImageKey];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef cgImage = [context createCGImage:outPutImage fromRect:[ciImage extent]];
    //UIImage *showImage = [UIImage imageWithCGImage:cgImage];
    
    UIImage *showImage = [UIImage imageWithCGImage:cgImage scale:image.scale orientation:image.imageOrientation];
    
    // CGImage 并不支持ARC  需要手动释放
    CGImageRelease(cgImage);
    
    return showImage;
}

+ (UIImage *)coreBlurImage:(UIImage *)image withBlurNumber:(CGFloat)blur
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage= [CIImage imageWithCGImage:image.CGImage];
    
    //设置filter
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:@(blur) forKey: @"inputRadius"];
    
    //模糊图片
    CIImage *result=[filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage=[context createCGImage:result fromRect:[result extent]];
    UIImage *blurImage=[UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    return blurImage;
}

- (void)saveToTmp:(NSString *)name
{
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:name];
    NSData *data = UIImageJPEGRepresentation(self, 1.0);
    
    [data writeToFile:filePath atomically:YES];
    NSLog(@"%@", NSTemporaryDirectory());
}

@end
