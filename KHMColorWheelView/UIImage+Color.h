//
//  UIImage+Color.h
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)
/*! 获取图片上点的Color*/
- (UIColor *)colorAtPoint:(CGPoint)point;
/*! 获取图片上某个像素点的Color(更为精确)*/
- (UIColor *)colorAtPixel:(CGPoint)point;
/*! 判断图片是否带透明通道*/
- (BOOL)hasAlphaChannel;
/*! 生成纯色图1*1*/
+ (UIImage *)imageWithColor:(UIColor *)color;
/*! 生成灰度图*/
+ (UIImage*)covertToGrayImageFromImage:(UIImage*)sourceImage;

@end
