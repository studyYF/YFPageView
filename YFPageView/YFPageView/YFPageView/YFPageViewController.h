//
//  YFPageViewController.h
//  YFPageView
//
//  Created by YF on 16/10/21.
//  Copyright © 2016年 YF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFPageViewController : UIViewController
/**控制器数组 */
@property (nonatomic, strong) NSMutableArray  * vcArray;
/**分类标题数组 */
@property (nonatomic, strong) NSArray  * titleArray;
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
/**标题高度 */
@property (nonatomic, assign) CGFloat headerTitleHeight;
/**
 *  开始布局
 */
- (void)startLayout;

@end
