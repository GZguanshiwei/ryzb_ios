//
//  ShopPageViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/19.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "ShopPageViewController.h"
#import "StoreViewController.h"
#import "ResaleViewController.h"

@interface ShopPageViewController ()
@property(nonatomic, strong) NSMutableArray *titlesArray;
@end

@implementation ShopPageViewController

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
    self.titleColorNormal = [UIColor colorWithHexString:@"#333333"];
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
        [_titlesArray addObject:@"我收藏的"];
        [_titlesArray addObject:@"我转售的"];
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
    CGFloat width = kScreenWidth/2.0;
    return width;
}

-(NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.titlesArray.count;
}

- (NSString *)menuView:(WMMenuView *)menu titleAtIndex:(NSInteger)index{
    return self.titlesArray[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    UIViewController *rtn;
    switch (index) {
        case 0:
            rtn = [self storeVC];
            break;
        case 1:
            rtn = [self resaleVC];
            break;
        default:
            break;
    }
    return rtn;
}

#pragma mark - vc
-(UIViewController *)storeVC{
    StoreViewController *storeVC = [[StoreViewController alloc] initWithStoryboardName:@"ShopCart"];
    return storeVC;
}

-(UIViewController *)resaleVC{
    ResaleViewController *resaleVC = [[ResaleViewController alloc] initWithStoryboardName:@"ShopCart"];
    return resaleVC;
}
@end
