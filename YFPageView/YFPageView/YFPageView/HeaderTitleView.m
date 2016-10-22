//
//  HeaderTitleView.m
//  YFPageView
//
//  Created by YF on 16/10/22.
//  Copyright © 2016年 YF. All rights reserved.
//



#import "HeaderTitleView.h"
#import "UIView+Size.h"


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
    [self addSubview:self.lineView];
    HeaderButton * firstButton = self.subviews[0];
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
    CGFloat btnW = yfWidth / self.titleArray.count;
    for (int i = 0; i < self.titleArray.count; i ++) {
        HeaderButton * button = [HeaderButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(btnW * i, 0, btnW, self.yf_height);
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        button.tag = 300 + i;
        [button setTitleColor:self.titleButtonColorNormal forState:UIControlStateNormal];
        [button setTitleColor:self.titleButtonColorSeletced forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonSeletced:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = self.buttonfont;
        [self addSubview:button];
    }
}

- (void)buttonSeletced:(UIButton *)button
{
    self.lastSeletcedButton.selected = NO;
    button.selected = !button.selected;
    self.lastSeletcedButton = button;
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.yf_width = button.titleLabel.yf_width + 10;
        self.lineView.yf_centerX = button.yf_centerX;
    }];
    if ([self.delegate respondsToSelector:@selector(seletcedTitle:)]) {
        [self.delegate seletcedTitle:button.tag - 300];
    }
}

- (void)moveSeletcedButton:(NSInteger)index
{
    [self buttonSeletced:self.subviews[index]];
}

#pragma mark -- set方法
- (void)setTitleButtonColorNormal:(UIColor *)titleButtonColorNormal
{
    _titleButtonColorNormal = titleButtonColorNormal;
    for (UIView * view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [(UIButton *)view setTitleColor:titleButtonColorNormal forState:UIControlStateNormal];
        }
    }
}

- (void)setTitleButtonColorSeletced:(UIColor *)titleButtonColorSeletced
{
    _titleButtonColorSeletced = titleButtonColorSeletced;
    for (UIView * view in self.subviews) {
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
}

- (void)setButtonfont:(UIFont *)buttonfont
{
    _buttonfont = buttonfont;
    for (UIView * view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [(UIButton *)view titleLabel].font = buttonfont;
        }
    }
}



@end
