//
//  OffShelfViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/19.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "OffShelfViewController.h"
#import "ResaleCell.h"
#import "MoreOperationView.h"
#import "EditResaleGoodViewController.h"
#import "GoodDetailViewController.h"

@interface OffShelfViewController ()<UITableViewDataSource,UITableViewDelegate,ResaleCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tableData;
@property (strong, nonatomic) JMRefreshTool *refreshTool;
@end

@implementation OffShelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 195.0;
}

-(void)initData{
    self.title = @"已下架的";
    
    [self requestOffShelfList];
}

#pragma mark - UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ResaleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ResaleCell"];
    cell.delegate = self;
    cell.cellData = self.tableData[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodDetailViewController *detailVC = [[GoodDetailViewController alloc] initWithStoryboardName:@"GoodDetail"];
    detailVC.showWuHuo = YES;
    GoodModel *good = self.tableData[indexPath.row];
    detailVC.goodId = good.goodId;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - ResaleCellDelegate
-(void)didShare:(NSInteger)index{
    //do nothing
}

-(void)didCustomerService:(NSInteger)index{
    JMLoginUserModel *loginUser = [JMProjectManager sharedJMProjectManager].loginUser;
    //联系客服
    QYSource *source = [[QYSource alloc] init];
    source.title = loginUser.nickName;
    source.urlString = loginUser.headUrl;
    QiYuCustomServiceController *sessionViewController = [[QiYuCustomServiceController alloc] init];
    sessionViewController.sessionTitle = @"客服";
    sessionViewController.source = source;
    [self.navigationController pushViewController:sessionViewController animated:YES];
//    RCDCustomerServiceViewController *customerVC = [[RCDCustomerServiceViewController alloc] initCustomerService];
//    [self.navigationController pushViewController:customerVC animated:YES];

}

-(void)didBuy:(NSInteger)index{
    //do nothing
}

-(void)didMoreOperation:(NSInteger)index{
    MoreOperationView *moreOperationView = [[MoreOperationView alloc] initWithXib];
    [moreOperationView showViewWithDoneBlock:^(NSDictionary *params) {
        NSInteger buttonIndex = [params getJsonValue:@"ButtonIndex"].integerValue;
        switch (buttonIndex) {
            case 0:
                //查看原宝贝
                [self goGoodDetailVC:index];
                break;
            case 1:
                //修改
                [self goEidtGoodVC:index];
                break;
            case 2:
                //删除
                [self deleteOpreation:index];
                break;
            default:
                break;
        }
    }];
}

#pragma mark - 跳转
- (void)goGoodDetailVC:(NSInteger)index {
    GoodDetailViewController *detailVC = [[GoodDetailViewController alloc] initWithStoryboardName:@"GoodDetail"];
    GoodModel *good = self.tableData[index];
    detailVC.goodId = good.goodId;
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(void)deleteOpreation:(NSInteger)index{
    ScreenCenterTipView *tipView = [[ScreenCenterTipView alloc] initWithXib];
    tipView.message = @"确定要删除该商品？";
    tipView.buttonTitles = @[@"取消",@"确定"];
    [tipView showViewWithDoneBlock:^(NSDictionary * _Nonnull params) {
        NSInteger buttonIndex = [params getJsonValue:@"ButtonIndex"].integerValue;
        if(buttonIndex == 1){
            [self requestDeleteAtIndex:index];
        }
    }];
}

-(void)goEidtGoodVC:(NSInteger)index{
    EditResaleGoodViewController *editVC = [[EditResaleGoodViewController alloc] initWithStoryboardName:@"ShopCart"];
    editVC.good = self.tableData[index];
    [self.navigationController pushViewController:editVC animated:YES];
}

#pragma mark - 网络
-(void)requestOffShelfList{
    if(self.refreshTool == nil){
        JMWeak(self);
        self.refreshTool = [[JMRefreshTool alloc] initWithScrollView:self.tableView dataAnalysisBlock:^NSArray *(NSDictionary *responseData) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            NSDictionary *dataDic = responseData[@"data"];
            NSArray *listArray = dataDic[@"list"];
            for(NSDictionary *dic in listArray){
                GoodModel *model = [[GoodModel alloc] initWithDictionary:dic];
                [array addObject:model];
            }
            if([weakself.refreshTool isAddData] == YES){
                [weakself.tableData addObjectsFromArray:array];
            }else{
                weakself.tableData = array;
            }
            [weakself.tableView reloadData];
            return array;
        }];
        self.refreshTool.requestUrl = kUrlMyResaleList;
        NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
        [params setJsonValue:@"2" key:@"type"];
        self.refreshTool.requestParams = params;
    }
    [self.tableView.mj_header beginRefreshing];
}

-(void)requestDeleteAtIndex:(NSInteger)index{
    //删除
    GoodModel *good = self.tableData[index];
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:good.goodId key:@"goodsId"];
    [[JMRequestManager sharedManager] POST:kUrlDeleteResaleGood parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            [JMProgressHelper toastInWindowWithMessage:response.responseObject[@"desc"]];
            [self.tableData removeObjectAtIndex:index];
            [self.tableView reloadData];
        }
    }];
}
@end
