//
//  ViewController.m
//  YFPageView
//
//  Created by YF on 16/10/21.
//  Copyright © 2016年 YF. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"YFPageViewController";
    self.titleViewBackgroundColor = [UIColor lightGrayColor];
    self.titleButtonColorSeletced = [UIColor yellowColor];
    self.titleButtonColorNormal = [UIColor blackColor];
    self.lineColor = [UIColor purpleColor];
    self.headerTitleHeight = 35;
    self.titleArray = @[@"发",@"大道",@"大道",@"冯规范",@"腾飞公司"];
    
    
    
    ///必须调用startLayout方法,重新布局
    [self startLayout];
}








@end
