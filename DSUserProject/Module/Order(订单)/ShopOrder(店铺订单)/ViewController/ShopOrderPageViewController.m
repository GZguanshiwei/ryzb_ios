//
//  ShopOrderPageViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/27.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "ShopOrderPageViewController.h"
#import "ShopOrderListViewController.h"

@interface ShopOrderPageViewController ()
@property(nonatomic, strong) NSMutableArray *titlesArray;
@end

@implementation ShopOrderPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self initControl];
        [self initData];
    }
    return self;
}

-(void)initControl{
    //带下划线
    self.menuViewStyle = WMMenuViewStyleLine;
    //选中颜色
    self.titleColorSelected = kColorMain;
    //非选中颜色
    self.titleColorNormal = [UIColor colorWithHexString:@"#999999"];
    self.titleSizeSelected = 14.0;
    self.titleSizeNormal = 14.0;
    self.titleFontName = @"PingFangSC-Semibold";
    
    self.progressWidth = 20.0;
    self.progressHeight = 2.0;
}

-(void)initData{
    
}

-(NSMutableArray *)titlesArray{
    if(_titlesArray == nil){
        _titlesArray = [[NSMutableArray alloc] init];
        [_titlesArray addObject:@"全部"];
        [_titlesArray addObject:@"待付款"];
        [_titlesArray addObject:@"待发货"];
        [_titlesArray addObject:@"待收货"];
        [_titlesArray addObject:@"待评价"];
        
    }
    return _titlesArray;
}

#pragma mark - data source
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    CGFloat height = 50;
    return CGRectMake(0, 0, self.view.mj_w, height);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat originY = 50.0;
    return CGRectMake(0, originY, self.view.mj_w, self.view.mj_h - originY);
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = kScreenWidth/5.0;
    return width;
}

-(NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.titlesArray.count;
}

- (NSString *)menuView:(WMMenuView *)menu titleAtIndex:(NSInteger)index{
    return self.titlesArray[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    return [self orderListVCWithType:index];
}

-(UIViewController *)orderListVCWithType:(NSInteger)type{
    ShopOrderListViewController *orderListVC = [[ShopOrderListViewController alloc] initWithStoryboardName:@"ShopOrder"];
    orderListVC.type = type;
    return orderListVC;
}
@end
