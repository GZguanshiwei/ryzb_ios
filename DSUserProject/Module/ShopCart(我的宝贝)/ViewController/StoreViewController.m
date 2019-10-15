//
//  StoreViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/19.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "StoreViewController.h"
#import "StoreCell.h"
#import "StoreHeader.h"
#import "StoreInvalidCell.h"
#import "MakeOrderViewController.h"
#import "GoodDetailViewController.h"

@interface StoreViewController ()<UITableViewDataSource,UITableViewDelegate,StoreCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *storeArray;
@property (strong, nonatomic) NSMutableArray *storeInvaildArray;

@property (strong, nonatomic) JMRefreshTool *refreshTool;
@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    UINib *header = [UINib nibWithNibName:@"StoreHeader" bundle:nil];
    [self.tableView registerNib:header forHeaderFooterViewReuseIdentifier:@"StoreHeader"];
}

-(void)initData{
    self.storeInvaildArray = [[NSMutableArray alloc] init];
    [self requestCollectionList];
}

#pragma mark - UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rtn = 0;
    switch (section) {
        case 0:
            rtn = self.storeArray.count;
            break;
        case 1:
            rtn = self.storeInvaildArray.count;
            break;
        default:
            break;
    }
    return rtn;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger rtn = 1;
    if(self.storeInvaildArray.count > 0){
        rtn = 2;
    }
    return rtn;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            StoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreCell"];
            cell.delegate = self;
            cell.storeGood = self.storeArray[indexPath.row];
            cell.indexPath = indexPath;
            return cell;
        }
            break;
        case 1:
        {
            StoreInvalidCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreInvalidCell"];
            cell.delegate = self;
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat rtn = 0;
    switch (indexPath.section) {
        case 0:
            rtn = 195.0;
            break;
        case 1:
            rtn = 127.0;
            break;
        default:
            break;
    }
    return rtn;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat rtn = 0;
    switch (section) {
        case 0:
            rtn = 0;
            break;
        case 1:
            rtn = 44.0;
            break;
        default:
            break;
    }
    return rtn;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    StoreHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"StoreHeader"];
    return header;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodDetailViewController *detailVC = [[GoodDetailViewController alloc] initWithStoryboardName:@"GoodDetail"];
    GoodModel *good;
    switch (indexPath.section) {
        case 0:
            good = self.storeArray[indexPath.row];
            break;
        case 1://失效
            good = self.storeInvaildArray[indexPath.row];
            break;
        default:
            break;
    }
    detailVC.goodId = good.goodId;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - StoreCellDelegate
-(void)didBuy:(NSIndexPath *)indexPath{
    MakeOrderViewController *makeOrderVC = [[MakeOrderViewController alloc] initWithStoryboardName:@"GoodDetail"];
    makeOrderVC.good = self.storeArray[indexPath.row];
    [self.navigationController pushViewController:makeOrderVC animated:YES];
}

-(void)didCancelStore:(NSIndexPath *)indexPath{
    ScreenCenterTipView *tipView = [[ScreenCenterTipView alloc] initWithXib];
    tipView.message = @"确定要取消收藏该商品？";
    tipView.buttonTitles = @[@"取消",@"确定"];
    [tipView showViewWithDoneBlock:^(NSDictionary * _Nonnull params) {
        NSInteger buttonIndex = [params getJsonValue:@"ButtonIndex"].integerValue;
        if(buttonIndex == 1){
            [self requestCollectionAtIndex:indexPath];
        }
    }];
}

-(void)didCustomerService:(NSIndexPath *)indexPath{
    [self goCustomerServiceVC];
}

#pragma mark - 跳转
-(void)goCustomerServiceVC{
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

#pragma mark - 网络
-(void)requestCollectionList{
    if(self.refreshTool == nil){
        JMWeak(self);
        self.refreshTool = [[JMRefreshTool alloc] initWithScrollView:self.tableView dataAnalysisBlock:^NSArray *(NSDictionary *responseData) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            NSDictionary *dataDic = responseData[@"data"];
            NSArray *listArray = dataDic[@"list"];
            for(NSDictionary *dic in listArray){
                GoodModel *model = [[GoodModel alloc] initWithCollectionDictionary:dic];
                [array addObject:model];
            }
            if([weakself.refreshTool isAddData] == YES){
                [weakself.storeArray addObjectsFromArray:array];
            }else{
                weakself.storeArray = array;
            }
            [weakself.tableView reloadData];
            return array;
        }];
        self.refreshTool.requestUrl = kUrlCollectionList;
        NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
        self.refreshTool.requestParams = params;
    }
    [self.tableView.mj_header beginRefreshing];
}

-(void)requestCollectionAtIndex:(NSIndexPath *)indexPath{
    //收藏、取消收藏
    GoodModel *good;
    switch (indexPath.section) {
        case 0:
            good = self.storeArray[indexPath.row];
            break;
        case 1://失效
            good = self.storeInvaildArray[indexPath.row];
            break;
        default:
            break;
    }
    if(good){
        NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
        [params setJsonValue:good.goodId key:@"goodsId"];
        [[JMRequestManager sharedManager] POST:kUrlCollectionGood parameters:params completion:^(JMBaseResponse *response) {
            if(response.error){
                [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
            }else{
                [JMProgressHelper toastInWindowWithMessage:response.responseObject[@"desc"]];
                switch (indexPath.section) {
                    case 0:
                        [self.storeArray removeObjectAtIndex:indexPath.row];
                        break;
                    case 1:
                        [self.storeInvaildArray removeObjectAtIndex:indexPath.row];
                        break;
                    default:
                        break;
                }
                [self.tableView reloadData];
            }
        }];
    }
}
@end
