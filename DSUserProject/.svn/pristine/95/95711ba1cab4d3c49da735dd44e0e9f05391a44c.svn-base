//
//  WalletChoiceCashController.m
//  JMBaseProject
//
//  Created by 潘传标 on 2019/9/7.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "WalletChoiceCashController.h"
#import "WalletChoiceCashListCell.h"
#import "AddCashAccountView.h"

@interface WalletChoiceCashController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *haveNoDataView;
@property (nonatomic, strong) NSMutableArray *tableData;

@end

@implementation WalletChoiceCashController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initControl
{
    self.title = @"提现账户";
    self.haveNoDataView.hidden = YES;
}

- (void)initData {
    [self requestMyAccountList];
}

- (UIImage *)jmNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(JMNavigationBar *)navigationBar
{
    [rightButton setTintColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    [rightButton setTitle:@"添加" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    return nil;
}

- (void)rightButtonEvent:(UIButton *)sender navigationBar:(JMNavigationBar *)navigationBar
{
    [AddCashAccountView addCashAccountWithHandle:^(NSDictionary *dataDic) {
        NSString *type = [dataDic getJsonValue:@"type"];
        NSString *account = [dataDic getJsonValue:@"account"];
        NSString *bankName = [dataDic getJsonValue:@"bankName"];
        NSString *name = [dataDic getJsonValue:@"name"];
        //添加账户
        [self requestSaveAccount:type first:account second:bankName third:name];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WalletChoiceCashListCell *cell = [tableView dequeueReusableCellWithIdentifier:walletChoiceCashListCellID forIndexPath:indexPath];
    cell.cellData = self.tableData[indexPath.row];
    JMWeak(self);
    //删除
    cell.deleteButtonBlock = ^{
        [weakself deleteCashAccountWith:indexPath.row];
    };
    //选择
    cell.selectButtonBlock = ^{
        [weakself choiceCashAccountWithIndex:indexPath.row];
    };
    return cell;
}


#pragma mark - 删除账户信息
-(void)deleteCashAccountWith:(NSInteger)index
{
    ScreenCenterTipView *tipView = [[ScreenCenterTipView alloc] initWithXib];
    tipView.message = @"是否要删除该账户？";
    tipView.buttonTitles = @[@"取消",@"确定"];
    [tipView showViewWithDoneBlock:^(NSDictionary * _Nonnull params) {
        NSInteger buttonIndex = [params getJsonValue:@"ButtonIndex"].integerValue;
        if(buttonIndex == 1){
            [self requestDeleteAccount:index];
        }
    }];
}

#pragma mark - 选择添加账户
-(void)choiceCashAccountWithIndex:(NSInteger) index
{
    WalletAccountListModel *model = self.tableData[index];
    if (self.choiceCashAccountBlock) {
        self.choiceCashAccountBlock(model);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 网络
-(void)requestMyAccountList{
    //获取我的账户列表
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [[JMRequestManager sharedManager] POST:kUrlMyAccountList parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            NSArray *accountList = response.responseObject[@"data"];
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in accountList) {
                WalletAccountListModel *model = [[WalletAccountListModel alloc] initWithDictionary:dict];
                [array addObject:model];
            }
            self.tableData = array;
            if (self.tableData.count == 0) {
                //无数据
                self.tableView.hidden = YES;
                self.haveNoDataView.hidden = NO;
            }else {
                //有数据
                self.haveNoDataView.hidden = YES;
                self.tableView.hidden = NO;
                [self.tableView reloadData];
            }
        }
    }];
}

-(void)requestSaveAccount:(NSString *)type first:(NSString *)account second:(NSString *)bankName third:(NSString *)name{
    //新增提现账户
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setValue:type forKey:@"type"];
    [params setValue:account forKey:@"account"];
    [params setValue:bankName forKey:@"bankName"];
    [params setValue:name forKey:@"name"];
    
    [[JMRequestManager sharedManager] POST:kUrlSaveAccount parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            [self requestMyAccountList];
        }
    }];
}


-(void)requestDeleteAccount:(NSInteger)index{
    //删除提现账户
    WalletAccountListModel *model = self.tableData[index];
    
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setValue:model.modelId forKey:@"extractAccountId"];
    
    [[JMRequestManager sharedManager] POST:kUrlDeleteAccount parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            [self.tableData removeObjectAtIndex:index];
            [self.tableView deleteRow:index inSection:0 withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}

@end
