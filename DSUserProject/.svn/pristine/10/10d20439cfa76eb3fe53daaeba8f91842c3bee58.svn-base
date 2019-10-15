//
//  IntegralMallListViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/9/16.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "IntegralMallListViewController.h"
#import "BuyCouponDetailController.h"
#import "IntegralGoodDetailViewController.h"
#import "IntegraMallListCell.h"

@interface IntegralMallListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) NSMutableArray *collectionData;
@property (strong, nonatomic) NSMutableArray *allData;
@property (strong, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayOut;
@property (weak, nonatomic) IBOutlet UIView *optionView;
@property (strong, nonatomic) JMRefreshTool *refreshTool;
@end

@implementation IntegralMallListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    CGFloat wideth = (kScreenWidth - 45)* 0.5;
    self.flowLayOut.itemSize = CGSizeMake(wideth, 260);
    self.flowLayOut.minimumLineSpacing = 0;
    self.flowLayOut.minimumInteritemSpacing = 0;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationTextChange:) name:UITextFieldTextDidChangeNotification object:self.searchTextField];
}

-(void)initData{
    [self requestMallList];
}

- (UIReturnKeyType)textViewControllerLastReturnKeyType:(JMTextViewController *)textViewController{
    return UIReturnKeySearch;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IntegraMallListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:integraMallListCellID forIndexPath:indexPath];
    cell.cellData = self.collectionData[indexPath.row];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    IntegralGoodModel *good = self.collectionData[indexPath.row];
    switch (good.type.intValue) {
        case 0:
        {
            //商品
            IntegralGoodDetailViewController *detailVC = [[IntegralGoodDetailViewController alloc] initWithStoryboardName:@"Mine"];
            detailVC.good = good;
            [self.navigationController pushViewController:detailVC animated:YES];
            break;
        }
        case 1:
        {
            //优惠券
            BuyCouponDetailController *detailVc = [[BuyCouponDetailController alloc] initWithStoryboardName:@"Mine"];
            detailVc.good = good;
            [self.navigationController pushViewController:detailVc animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark - Actions
- (IBAction)optionButtonAction:(id)sender {
    self.optionView.hidden = !self.optionView.hidden;
}

/**
 商品
 */
- (IBAction)goodButtonAction:(id)sender {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (IntegralGoodModel *good in self.allData) {
        if (good.type.integerValue == 0) {
            [array addObject:good];
        }
    }
    self.collectionData = array;
    [self.collectionView reloadData];
    self.optionView.hidden = !self.optionView.hidden;
}

/**
 优惠券
 */
- (IBAction)buyCouponButtonAction:(id)sender {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (IntegralGoodModel *good in self.allData) {
        if (good.type.integerValue == 1) {
            [array addObject:good];
        }
    }
    self.collectionData = array;
    [self.collectionView reloadData];
    self.optionView.hidden = !self.optionView.hidden;
}

#pragma mark -- UITextFieldDelegate
/**
 搜索按钮点击后执行
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [super textFieldShouldReturn:textField];
    //回收键盘
    [textField resignFirstResponder];
    if (textField.text.length > 0) {
        [self requestMallList];
    }
    
    return YES;
}

/**
 搜索输入框监听
 */
- (void)notificationTextChange:(NSNotification *)notification{
    if (self.searchTextField.text.length == 0) {
        [self requestMallList];
    }
}

#pragma mark - 网络
-(void)requestMallList{
    if(self.refreshTool == nil){
        JMWeak(self);
        self.refreshTool = [[JMRefreshTool alloc] initWithScrollView:self.collectionView dataAnalysisBlock:^NSArray *(NSDictionary *responseData) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            NSArray *listArray = responseData[@"data"][@"list"];
            for(NSDictionary *dic in listArray){
                IntegralGoodModel *good = [[IntegralGoodModel alloc] initWithDictionary:dic];
                [array addObject:good];
            }
            
            if([weakself.refreshTool isAddData]){
                [weakself.collectionData addObjectsFromArray:array];
            }else{
                weakself.collectionData = array;
            }
            weakself.allData = weakself.collectionData;
            [weakself.collectionView reloadData];
            return array;
        }];
        self.refreshTool.requestUrl = kUrlIntegralShop;
    }
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.searchTextField.text key:@"keyword"];
    self.refreshTool.requestParams = params;
    [self.collectionView.mj_header beginRefreshing];
}

@end
