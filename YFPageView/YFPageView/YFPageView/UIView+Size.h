//
//  UIView+Size.h
//  BaiSiBuDeJie
//
//  Created by YF on 16/10/18.
//  Copyright © 2016年 YF. All rights reserved.
//

#define yfWidth [UIScreen mainScreen].bounds.size.width

#define yfHeight [UIScreen mainScreen].bounds.size.height

#import <UIKit/UIKit.h>

@interface UIView (Size)
@property (nonatomic, assign)CGFloat yf_x;
@property (nonatomic, assign)CGFloat yf_y;
@property (nonatomic, assign)CGFloat yf_width;
@property (nonatomic, assign)CGFloat yf_height;
@property (nonatomic, assign)CGSize yf_size;
@property (nonatomic, assign)CGPoint yf_origin;
@property (nonatomic, assign) CGFloat yf_centerX;
@property (nonatomic, assign) CGFloat yf_centerY;
@end
