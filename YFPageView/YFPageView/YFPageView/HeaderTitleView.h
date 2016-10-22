//
//  HeaderTitleView.h
//  YFPageView
//
//  Created by YF on 16/10/22.
//  Copyright © 2016年 YF. All rights reserved.
//



#import <UIKit/UIKit.h>

@interface HeaderButton : UIButton

@end


@protocol HeaderTitleViewDelegate <NSObject>
/**
 *  选中了某个title
 */
- (void)seletcedTitle:(NSInteger)index;

@end

@interface HeaderTitleView : UIView


@property (nonatomic, assign) id <HeaderTitleViewDelegate> delegate;
/**标题按钮普通颜色*/
@property (nonatomic, strong) UIColor * titleButtonColorNormal;
/**标题按钮选中颜色*/
@property (nonatomic, strong) UIColor * titleButtonColorSeletced;
/**按钮下的滑动条颜色*/
@property (nonatomic, strong) UIColor * lineColor;
/**标题view背景色 */
@property (nonatomic, strong) UIColor * titleViewBackgroundColor;
/**标题按钮字体大小 */
@property (nonatomic, assign) UIFont* buttonfont;

/**
 *  初始化创建标题分类视图
 *
 *  @param frame      <#frame description#>
 *  @param titleArray 标题数组
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray;


/**
 *  移动当前的选中title
 *
 *  @param index 选中的index
 */
- (void)moveSeletcedButton:(NSInteger)index;

@end
