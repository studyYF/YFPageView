//
//  HeaderTitleView.m
//  YFPageView
//
//  Created by YF on 16/10/22.
//  Copyright © 2016年 YF. All rights reserved.
//



#import "HeaderTitleView.h"
#import "UIView+Size.h"
#import <UIKit/UIKit.h>

static CGFloat const margin = 30;


@interface HeaderButton ()

@end

@implementation HeaderButton

- (void)setHighlighted:(BOOL)highlighted
{
    //重写该方法,则当按钮已经被选中后,再点击该按钮不会有高亮的状态
}

@end

@interface HeaderTitleView ()
/**
 *  放按钮的scrollView,当按钮过多后,可以调整scrollView的contentSize
 */
@property (nonatomic, strong) UIScrollView * scrollView;
/**
 *  上次选中的按钮
 */
@property (nonatomic, strong) UIButton * lastSeletcedButton;
/**
 *  滑动条View
 */
@property (nonatomic, strong) UIView * lineView;
/**
 *  标题分类数组
 */
@property (nonatomic, strong) NSArray * titleArray;



@end


@implementation HeaderTitleView


- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray
{
    if (self = [super initWithFrame:frame]) {
        self.titleArray = titleArray;
        [self configButton];
        [self configLineView];
    }
    return self;
}

//创建下划线
- (void)configLineView
{
    self.backgroundColor = self.titleViewBackgroundColor;
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.yf_height - 2, 0, 2)];
    self.lineView.backgroundColor = self.lineColor;
    [self.scrollView addSubview:self.lineView];
    HeaderButton * firstButton = self.scrollView.subviews[0];
    firstButton.selected = YES;
    self.lastSeletcedButton = firstButton;
    //让第一个button计算里面label的尺寸,不然获取到的label的宽度是0
    [firstButton.titleLabel sizeToFit];
    self.lineView.yf_width = firstButton.titleLabel.yf_width + 10;
    self.lineView.yf_centerX = firstButton.yf_centerX;
    
}

//创建标题按钮
- (void)configButton
{
//    CGFloat btnW = yfWidth / self.titleArray.count;
    CGFloat lastButtonMaxX = 0;
    for (int i = 0; i < self.titleArray.count; i ++) {
        CGFloat btnW = [self.titleArray[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, self.yf_height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.width + 10;
        HeaderButton * button = [HeaderButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(margin + lastButtonMaxX, 0 , btnW, self.yf_height);
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        button.tag = 300 + i;
        [button setTitleColor:self.titleButtonColorNormal forState:UIControlStateNormal];
        [button setTitleColor:self.titleButtonColorSeletced forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonSeletced:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = self.buttonfont;
        lastButtonMaxX = CGRectGetMaxX(button.frame);
        [self.scrollView addSubview:button];
    }
    self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(self.scrollView.subviews[self.titleArray.count - 1].frame) + margin, self.yf_height);
}

- (void)buttonSeletced:(UIButton *)button
{
    self.lastSeletcedButton.selected = NO;
    button.selected = !button.selected;
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.yf_width = button.titleLabel.yf_width + 10;
        self.lineView.yf_centerX = button.yf_centerX;
    }];
    if ([self.delegate respondsToSelector:@selector(seletcedTitle:direction:)]) {
        [self.delegate seletcedTitle:button.tag - 300 direction:self.lastSeletcedButton.tag - button.tag > 0 ? UIPageViewControllerNavigationDirectionReverse : UIPageViewControllerNavigationDirectionForward];
    }
    self.lastSeletcedButton = button;
    [self scrollScrollViewWithSeletcedButton:button];
}

//移动选中按钮
- (void)moveSeletcedButton:(NSInteger)index
{
    UIButton * button = self.scrollView.subviews[index];
    [self buttonSeletced:button];
    [self scrollScrollViewWithSeletcedButton:button];
}
#pragma mark -- 调整scrollView的contentOffset
- (void)scrollScrollViewWithSeletcedButton:(UIButton *)button
{
    //判断按钮是否在屏幕之外,如果不在则需要调整scrollView的contentOffset
    //右边界
    CGFloat reduceValue = CGRectGetMaxX(button.frame) + margin - yfWidth - self.scrollView.contentOffset.x;
    if (reduceValue > 0)  {
        [self.scrollView setContentOffset:CGPointMake(reduceValue + self.scrollView.contentOffset.x, 0) animated:YES];
    } else {
        //左边界
        CGFloat leftValue = CGRectGetMinX(button.frame) - margin - self.scrollView.contentOffset.x;
        if (leftValue < 0) {
            [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + leftValue, 0) animated:YES];
        }
    }
}

#pragma mark -- set方法
- (void)setTitleButtonColorNormal:(UIColor *)titleButtonColorNormal
{
    _titleButtonColorNormal = titleButtonColorNormal;
    for (UIView * view in self.scrollView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [(UIButton *)view setTitleColor:titleButtonColorNormal forState:UIControlStateNormal];
        }
    }
}

- (void)setTitleButtonColorSeletced:(UIColor *)titleButtonColorSeletced
{
    _titleButtonColorSeletced = titleButtonColorSeletced;
    for (UIView * view in self.scrollView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [(UIButton *)view setTitleColor:titleButtonColorSeletced forState:UIControlStateSelected];
        }
    }
}

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    self.lineView.backgroundColor = lineColor;
}

- (void)setTitleViewBackgroundColor:(UIColor *)titleViewBackgroundColor
{
    _titleViewBackgroundColor = titleViewBackgroundColor;
    self.backgroundColor = titleViewBackgroundColor;
    self.scrollView.backgroundColor = titleViewBackgroundColor;
}

- (void)setButtonfont:(UIFont *)buttonfont
{
    _buttonfont = buttonfont;
    for (UIView * view in self.scrollView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [(UIButton *)view titleLabel].font = buttonfont;
        }
    }
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.backgroundColor = self.backgroundColor;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}


@end
