//
//  YFPageViewController.m
//  YFPageView
//
//  Created by YF on 16/10/21.
//  Copyright © 2016年 YF. All rights reserved.
//

#define RandomColor [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1]

#import "YFPageViewController.h"
#import "UIView+Size.h"


@interface YFPageViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,HeaderTitleViewDelegate>
/**
 *  pageViewController保存控制器的容器
 */
@property (nonatomic, strong) UIPageViewController * pageViewController;

/**
 *  将要滑动到的控制器
 */
@property (nonatomic, strong) UIViewController * pendingViewController;


@end

@implementation YFPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //设置默认的属性值
    _headerTitleHeight = 40;
    _titleButtonColorSeletced = [UIColor redColor];
    _lineColor = [UIColor redColor];
    _titleViewBackgroundColor = [UIColor whiteColor];
    _titleButtonColorNormal = [UIColor lightGrayColor];
    _buttonfont = [UIFont systemFontOfSize:15];

}

//根据设置的titleView的样式创建控件
- (void)startLayout
{
    self.pageViewController.view.frame = CGRectMake(0, 64 + self.headTitleView.yf_height, yfWidth, self.view.yf_height - self.headTitleView.yf_height);
}

#pragma mark -- HeaderTitleViewDelegate
- (void)seletcedTitle:(NSInteger)index direction:(UIPageViewControllerNavigationDirection)direction
{
    //如果不需要一直左右滑动,可以在这里修改direction参数
    [self.pageViewController setViewControllers:@[self.vcArray[index]] direction:direction animated:YES completion:nil];
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

- (UIView *)headTitleView
{
    if (!_headTitleView) {
        _headTitleView = [[HeaderTitleView alloc] initWithFrame:CGRectMake(0, 64, yfWidth, self.headerTitleHeight) titleArray:self.titleArray];
        _headTitleView.delegate = self;
        _headTitleView.titleButtonColorNormal = self.titleButtonColorNormal;
        _headTitleView.titleButtonColorSeletced = self.titleButtonColorSeletced;
        _headTitleView.lineColor = self.lineColor;
        _headTitleView.buttonfont = self.buttonfont;
        [self.view addSubview:_headTitleView];
    }
    return _headTitleView;
}





@end
