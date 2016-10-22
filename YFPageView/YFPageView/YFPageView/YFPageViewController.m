//
//  YFPageViewController.m
//  YFPageView
//
//  Created by YF on 16/10/21.
//  Copyright © 2016年 YF. All rights reserved.
//

#define RandomColor [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1]

#import "YFPageViewController.h"
#import "HeaderTitleView.h"
#import "UIView+Size.h"


@interface YFPageViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,HeaderTitleViewDelegate>
/**
 *  pageViewController保存控制器的容器
 */
@property (nonatomic, strong) UIPageViewController * pageViewController;
/**
 *  分类标题视图
 */
@property (nonatomic, strong) HeaderTitleView * headTitleView;
/**
 *  将要滑动到的控制器
 */
@property (nonatomic, strong) UIViewController * pendingViewController;


@end

@implementation YFPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headerTitleHeight = 40;
}

- (void)startLayout
{
    self.headTitleView = [[HeaderTitleView alloc] initWithFrame:CGRectMake(0, 64, yfWidth, self.headerTitleHeight) titleArray:self.titleArray];
    self.headTitleView.delegate = self;
    self.headTitleView.titleButtonColorNormal = self.titleButtonColorNormal;
    self.headTitleView.titleButtonColorSeletced = self.titleButtonColorSeletced;
    self.headTitleView.lineColor = self.lineColor;
    self.headTitleView.buttonfont = self.buttonfont;
    [self.view addSubview:self.headTitleView];
    self.pageViewController.view.frame = CGRectMake(0, 64 + self.headTitleView.yf_height, yfWidth, self.view.yf_height - self.headTitleView.yf_height);
}

#pragma mark -- HeaderTitleViewDelegate
- (void)seletcedTitle:(NSInteger)index
{
    //如果不需要一直左右滑动,可以在这里修改direction参数
    [self.pageViewController setViewControllers:@[self.vcArray[index]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

#pragma mark -- UIPageViewControllerDataSource
//往右滑(返回)
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    //如果到第一个,不作处理
    NSInteger index = [self.vcArray indexOfObject:viewController];
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    return self.vcArray[index - 1];
}
//往左滑(下一个)
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    //如果超出数组则不作处理
    NSInteger index = [self.vcArray indexOfObject:viewController];
    if (index ==  self.vcArray.count - 1 || index == NSNotFound) {
        return nil;
    }
    return self.vcArray[index + 1];
}
#pragma mark -- UIPageViewControllerDelegate
//即将开始动画代理
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    //pendingViewControllers 数组存放的是将要移动到的ViewController
    self.pendingViewController = pendingViewControllers[0];
}

//动画完成代理
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    //previousViewControllers 该数组里面存放的是滑动之前的viewController
    if (completed) {
        [self.headTitleView moveSeletcedButton:[self.vcArray indexOfObject:self.pendingViewController]];
    }
}
#pragma mark -- 懒加载
- (UIPageViewController *)pageViewController{
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{UIPageViewControllerOptionSpineLocationKey : @0}];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        [_pageViewController setViewControllers:@[self.vcArray[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        [self addChildViewController:_pageViewController];
        [self.view addSubview:_pageViewController.view];
    }
    return _pageViewController;
}

- (NSMutableArray *)vcArray
{
    if (!_vcArray) {
        _vcArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.titleArray.count; i ++) {
            UIViewController * VC= [[UIViewController alloc] init];
            VC.view.backgroundColor = RandomColor;
            [_vcArray addObject:VC];
        }
    }
    return _vcArray;
}


- (NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [[NSArray alloc] init];
        _titleArray = @[@"这是默认",@"的标题",@"需要自己设置"];
    }
    return  _titleArray;
}


#pragma mark -- set方法
//- (void)setTitleButtonColorNormal:(UIColor *)titleButtonColorNormal
//{
//    _titleButtonColorNormal = titleButtonColorNormal;
//}
//
//- (void)setTitleButtonColorSeletced:(UIColor *)titleButtonColorSeletced
//{
//    _titleButtonColorSeletced = titleButtonColorSeletced;
//    self.headTitleView.titleButtonColorSeletced = titleButtonColorSeletced;
//}
//
//- (void)setLineColor:(UIColor *)lineColor
//{
//    _lineColor = lineColor;
//    self.headTitleView.lineColor = lineColor;
//}
//
//- (void)setTitleViewBackgroundColor:(UIColor *)titleViewBackgroundColor
//{
//    _titleViewBackgroundColor = titleViewBackgroundColor;
//    self.headTitleView.titleViewBackgroundColor = titleViewBackgroundColor;
//}
//
//- (void)setButtonfont:(UIFont *)buttonfont
//{
//    _buttonfont = buttonfont;
//    self.headTitleView.buttonfont = buttonfont;
//}

#pragma mark -- get方法
#pragma mark -- set方法

- (UIFont *)buttonfont
{
    if (!_buttonfont) {
        _buttonfont = [UIFont systemFontOfSize:15];
    }
    return _buttonfont;
}

- (UIColor *)titleButtonColorNormal
{
    if (!_titleButtonColorNormal) {
        _titleButtonColorNormal = [UIColor lightGrayColor];
    }
    return _titleButtonColorNormal;
}

- (UIColor *)titleButtonColorSeletced
{
    if (!_titleButtonColorSeletced) {
        _titleButtonColorSeletced = [UIColor redColor];
    }
    return _titleButtonColorSeletced;
}

- (UIColor *)lineColor
{
    if (!_lineColor) {
        _lineColor = [UIColor redColor];
    }
    return _lineColor;
}
- (UIColor *)titleViewBackgroundColor
{
    if (!_titleViewBackgroundColor) {
        _titleViewBackgroundColor = [UIColor whiteColor];
    }
    return _titleViewBackgroundColor;
}

@end
