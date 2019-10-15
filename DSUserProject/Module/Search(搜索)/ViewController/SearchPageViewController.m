//
//  SearchPageViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/7/2.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "SearchPageViewController.h"
#import "SearchResultViewController.h"

@interface SearchPageViewController ()
@property(nonatomic, strong) NSMutableArray *titlesArray;
@end

@implementation SearchPageViewController

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

-(void)setSearchKey:(NSString *)searchKey{
    if(searchKey.length > 0 && [searchKey isEqualToString:_searchKey] == NO){
        _searchKey = searchKey;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"StartSearch" object:self.searchKey];
    }
}

-(NSMutableArray *)titlesArray{
    if(_titlesArray == nil){
        _titlesArray = [[NSMutableArray alloc] init];
        [_titlesArray addObject:@"全部"];
        [_titlesArray addObject:@"直播"];
        
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
    
    return [self resultVCWithType:index];
}

-(UIViewController *)resultVCWithType:(NSInteger)type{
    SearchResultViewController *orderListVC = [[SearchResultViewController alloc] initWithStoryboardName:@"Search"];
    orderListVC.type = type;
    orderListVC.searchKey = self.searchKey;
    return orderListVC;
}

@end
