//
//  ProductDetailsPageViewController.m
//  JMBaseProject
//
//  Created by ios on 2019/9/12.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "GoodDetailPageViewController.h"
#import "GoodDepictViewController.h"
#import "ProtectionViewController.h"

@interface GoodDetailPageViewController ()

@property (strong, nonatomic) NSMutableArray *titleArray;

@end

@implementation GoodDetailPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initControl];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initControl];
    }
    return self;
}

- (void)initControl {
    //设置样式为带下划线样式
    self.menuViewStyle = WMMenuViewStyleLine;
    //选中样式
    self.titleColorSelected = [UIColor colorWithHexString:@"#333333"];
    self.titleSizeSelected = 13.0;
    //未选中颜色
    self.titleColorNormal = [UIColor colorWithHexString:@"#BBBBBB"];
    self.titleSizeNormal = 13.0;
    
    //下划线高度
    self.progressHeight = 2.0;
    self.progressWidth = 50.0;
    self.progressColor = [UIColor colorWithHexString:@"#46C899"];
}

#pragma mark -dataSource
//设置分栏的高度
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    return CGRectMake(0, 0, self.view.width, 45);
}

//设置页面（除去分栏）的frame
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    return CGRectMake(0, 45, self.view.width, self.view.height - 45.0);
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titleArray.count;
}

- (NSString *)menuView:(WMMenuView *)menu titleAtIndex:(NSInteger)index{
    return self.titleArray[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    return [self ListVC:index];
}

-(UIViewController *)ListVC:(NSInteger)type {
    UIViewController *vc = [[UIViewController alloc] init];
    if (type == 0) {
        vc.view.backgroundColor = [UIColor redColor];
        //商品详情
        GoodDepictViewController *detailsVC = [[GoodDepictViewController alloc] initWithStoryboardName:@"Mine"];
        detailsVC.goodDetail = self.goodDetail;
        return detailsVC;
    } else {
        vc.view.backgroundColor = [UIColor yellowColor];
        //规格/服务保障
        ProtectionViewController *protectionVC = [[ProtectionViewController alloc] initWithStoryboardName:@"Mine"];
        protectionVC.goodDetail = self.goodDetail;
        protectionVC.type = type;
        return protectionVC;
    }
    return vc;
}

#pragma mark -懒加载
- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
        [_titleArray addObject:@"商品详情"];
        [_titleArray addObject:@"规格参数"];
        [_titleArray addObject:@"服务保障"];
    }
    return _titleArray;
}

@end
