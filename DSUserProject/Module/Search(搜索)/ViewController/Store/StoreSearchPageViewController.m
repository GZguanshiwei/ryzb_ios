//
//  StoreSearchPageViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/7/4.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "StoreSearchPageViewController.h"
#import "StoreSearchResultViewController.h"
#import "ResaleSearchResultViewController.h"

@interface StoreSearchPageViewController ()
@property(nonatomic, strong) NSMutableArray *titlesArray;

@property(nonatomic, strong) NSString *searchKey;
@end

@implementation StoreSearchPageViewController

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

-(void)startSearchWithKeyword:(NSString *)keyword{
    if(keyword.length > 0){
        self.searchKey = keyword;
        UIViewController *currVC = self.currentViewController;
        if([currVC isKindOfClass:[StoreSearchResultViewController class]]){
            StoreSearchResultViewController *resultVC = (StoreSearchResultViewController *)currVC;
            resultVC.searchKey = self.searchKey;
        }else if([currVC isKindOfClass:[ResaleSearchResultViewController class]]){
            ResaleSearchResultViewController *resultVC = (ResaleSearchResultViewController *)currVC;
            resultVC.searchKey = self.searchKey;
        }
    }
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

- (void)pageController:(WMPageController *)pageController willEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{
    if([viewController isKindOfClass:[StoreSearchResultViewController class]]){
        StoreSearchResultViewController *resultVC = (StoreSearchResultViewController *)viewController;
        resultVC.searchKey = self.searchKey;
    }else if([viewController isKindOfClass:[ResaleSearchResultViewController class]]){
        ResaleSearchResultViewController *resultVC = (ResaleSearchResultViewController *)viewController;
        resultVC.searchKey = self.searchKey;
    }
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    switch (index) {
        case 0:
            return [self storeVC];
            break;
        case 1:
            return [self resaleVC];
            break;
        default:
            break;
    }
    return nil;
}

-(UIViewController *)storeVC{
    StoreSearchResultViewController *storeVC = [[StoreSearchResultViewController alloc] initWithStoryboardName:@"Search"];
//    storeVC.searchKey = self.searchKey;
    return storeVC;
}

-(UIViewController *)resaleVC{
    ResaleSearchResultViewController *resaleVC = [[ResaleSearchResultViewController alloc] initWithStoryboardName:@"Search"];
//    resaleVC.searchKey = self.searchKey;
    return resaleVC;
}

@end
