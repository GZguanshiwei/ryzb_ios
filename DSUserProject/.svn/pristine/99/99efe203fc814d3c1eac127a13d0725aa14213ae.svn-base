//
//  MyCouponPageViewController.m
//  JMBaseProject
//
//  Created by 抽筋的灯 on 2019/9/10.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "MyCouponPageViewController.h"
#import "MyCouponListViewController.h"

@interface MyCouponPageViewController ()
@property(nonatomic, strong) NSMutableArray *titlesArray;
@end

@implementation MyCouponPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self initControl];
    }
    return self;
}

-(void)initControl{
    //带下划线
    self.menuViewStyle = WMMenuViewStyleLine;
    //选中颜色
    self.titleColorSelected = [UIColor colorWithHexString:@"#333333"];
    //非选中颜色
    self.titleColorNormal = [UIColor colorWithHexString:@"#BBBBBB"];
    
    self.titleSizeSelected = 14.0;
    self.titleSizeNormal = 14.0;
    self.titleFontName = @"PingFangSC-Semibold";
    
    self.progressWidth = 54;
    self.progressHeight = 4.0;
    self.progressColor = [UIColor colorWithHexString:@"#47C89B"];
}

-(void)initData{
    self.titlesArray = [@[@"未使用",@"已失效"] mutableCopy];
    [self reloadData];
}

#pragma mark - data source
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    CGFloat height = 46;
    return CGRectMake(20, 0, kScreenWidth - 40, height);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat originY = 46.0;
    return CGRectMake(0, originY, self.view.mj_w, self.view.mj_h - originY);
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = 50;
    return width;
}

-(NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.titlesArray.count;
}

- (NSString *)menuView:(WMMenuView *)menu titleAtIndex:(NSInteger)index{
    return self.titlesArray[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    UIViewController *rtn = [[UIViewController alloc] init];
    rtn = [self listVCWithType:index];
    return rtn;
}

-(UIViewController *)listVCWithType:(NSInteger)type{
    MyCouponListViewController *listVC = [[MyCouponListViewController alloc] initWithStoryboardName:@"Mine"];
    listVC.type = type;
    return listVC;
}


@end
