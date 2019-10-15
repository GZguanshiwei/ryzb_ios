//
//  MyCouponListViewController.m
//  JMBaseProject
//
//  Created by 抽筋的灯 on 2019/9/10.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "MyCouponListViewController.h"
#import "MyCouponListCell.h"
#import "MyCouponDetailController.h"
#import "MyCouponModel.h"

@interface MyCouponListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableData;
@property (strong, nonatomic) JMRefreshTool *refreshTool;

@end

@implementation MyCouponListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initData {
    [self requestMyCouponList];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCouponListCell * cell = [tableView dequeueReusableCellWithIdentifier:myCouponListCellID forIndexPath:indexPath];
    if (self.type == 0) {
        [cell.typeButton setTitle:@"立即使用" forState:UIControlStateNormal];
        [cell.typeButton setBackgroundImage:[UIImage imageNamed:@"wdyhq_btn_use"] forState:UIControlStateNormal];
        cell.typeButton.userInteractionEnabled = YES;
    }else{
        [cell.typeButton setTitle:@"" forState:UIControlStateNormal];
        [cell.typeButton setBackgroundImage:[UIImage imageNamed:@"wdyhq_tag_ysx"] forState:UIControlStateNormal];
        cell.typeButton.userInteractionEnabled = NO;
    }
    cell.cellData = self.tableData[indexPath.row];
    cell.buttonActionBlock = ^(NSInteger index) {
        switch (index) {
            case 0:
                [self checkCoupondsDetail:indexPath.row];
                break;
            case 1:
                [self goToUseVc:indexPath.row];
                break;
            default:
                break;
        }
    };
    return cell;
}

#pragma mark - 立即使用
-(void)goToUseVc:(NSInteger)index{
    MyCouponModel *couponData = self.tableData[index];
    switch (couponData.type.integerValue) {
        case 0://0商家使用1直播间使用2全部可用
            [self goHomeWithType:@"1"];
            break;
        case 1:
            if(couponData.roomId.length > 0){
                [self enterLive:couponData.roomId];
            }else{
                [self goHomeWithType:@"0"];
            }
            break;
        case 2:
            [self goHomeWithType:@"0"];
            break;
        default:
            break;
    }
}

-(void)enterLive:(NSString *)roomId{
    [[JMProjectManager sharedJMProjectManager] enterRoom:roomId];
}

-(void)goHomeWithType:(NSString *)type{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationMarketTypeChange object:type];
    self.tabBarController.selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:NO];
}

#pragma mark - 查看详情
-(void)checkCoupondsDetail:(NSInteger)index
{
    MyCouponDetailController *detailVc = [[MyCouponDetailController alloc] initWithStoryboardName:@"Mine"];
    detailVc.couponData = self.tableData[index];
    switch (self.type) {
        case 0:
            detailVc.canUse = YES;
            break;
        case 1:
            detailVc.canUse = NO;
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:detailVc animated:YES];
}


#pragma mark - 网络
-(void)requestMyCouponList{
    if(self.refreshTool == nil){
        MJWeakSelf;
        self.refreshTool = [[JMRefreshTool alloc] initWithScrollView:self.tableView dataAnalysisBlock:^NSArray *(NSDictionary *responseData) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            NSArray *listArray = responseData[@"data"][@"list"];
            for(NSDictionary *dict in listArray){
                MyCouponModel *model = [[MyCouponModel alloc] initWithDictionary:dict];
                [array addObject:model];
            }
            if([weakSelf.refreshTool isAddData]){
                [weakSelf.tableData addObjectsFromArray:array];
            }else{
                weakSelf.tableData = array;
            }
            
            [weakSelf.tableView reloadData];
            return array;
        }];
        
        self.refreshTool.requestUrl = kUrlMyCouponList;
        NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
        if (self.type == 0) {
            [params setValue:@"0" forKey:@"status"];
        }else {
            [params setValue:@"2" forKey:@"status"];
        }
        self.refreshTool.requestParams = params;
    }
    [self.tableView.mj_header beginRefreshing];
}


@end
