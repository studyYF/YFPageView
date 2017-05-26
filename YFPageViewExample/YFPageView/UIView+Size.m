//
//  UIView+Size.m
//  BaiSiBuDeJie
//
//  Created by YF on 16/10/18.
//  Copyright © 2016年 YF. All rights reserved.
//

#import "UIView+Size.h"
#import <UIKit/UIKit.h>

@implementation UIView (Size)
-(void)setYf_x:(CGFloat)yf_x
{
    CGRect frame = self.frame;
    frame.origin.x = yf_x;
    self.frame = frame;
}
-(void)setYf_y:(CGFloat)yf_y
{
    CGRect frame = self.frame;
    frame.origin.y = yf_y;
    self.frame = frame;
}
-(void)setYf_width:(CGFloat)yf_width
{
    CGRect frame = self.frame;
    frame.size.width = yf_width;
    self.frame = frame;
}
-(void)setYf_height:(CGFloat)yf_height
{
    CGRect frame = self.frame;
    frame.size.height = yf_height;
    self.frame = frame;
}
-(void)setYf_size:(CGSize)yf_size
{
    CGRect frame = self.frame;
    frame.size = yf_size;
    self.frame = frame;
}
-(void)setYf_origin:(CGPoint)yf_origin
{
    CGRect frame = self.frame;
    frame.origin = yf_origin;
    self.frame = frame;
}

-(CGFloat)yf_x
{
    return self.frame.origin.x;
}
-(CGFloat)yf_y
{
    return self.frame.origin.y;
}
-(CGFloat)yf_width
{
    return self.frame.size.width;
}
-(CGFloat)yf_height
{
    return self.frame.size.height;
}
-(CGSize)yf_size
{
    return self.frame.size;
}
-(CGPoint)yf_origin
{
    return self.frame.origin;
}

- (void)setYf_centerX:(CGFloat)yf_centerX
{
    CGPoint center = self.center;
    center.x = yf_centerX;
    self.center = center;
}

- (CGFloat)yf_centerX
{
    return self.center.x;
}

- (void)setYf_centerY:(CGFloat)yf_centerY
{
    CGPoint center = self.center;
    center.y = yf_centerY;
    self.center = center;
}

- (CGFloat)yf_centerY
{
    return self.center.y;
}
@end
