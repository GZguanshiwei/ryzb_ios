//
//  AddressAlertViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/9/16.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "AddressAlertViewController.h"
#import "AddressListCell.h"
#import "AddressAddOrEditViewController.h"

@interface AddressAlertViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tableData;
@property (strong, nonatomic) AddressModel *selectAddress;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeightConstraint;
@end

@implementation AddressAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    self.view.backgroundColor = [UIColor clearColor];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 105;
}

-(void)initData{
    [self requestAddressList];
}

#pragma mark - UINavigation
-(BOOL)navUIBaseViewControllerIsNeedNavBar:(JMNavUIBaseViewController *)navUIBaseViewController{
    return NO;
}

#pragma mark - UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddressListCell"];
    cell.cellData = self.tableData[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.selectAddress){
        self.selectAddress.isSelect = NO;
    }
    AddressModel *address = self.tableData[indexPath.row];
    self.selectAddress = address;
    self.selectAddress.isSelect = YES;
    [self.tableView reloadData];
}


#pragma mark - Actions
- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)okAction:(id)sender {
    if(self.selectBlock){
        if(self.selectAddress){
            self.selectBlock(self.selectAddress);
        }else{
            [JMProgressHelper toastInWindowWithMessage:@"请选择收货地址"];
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addAction:(id)sender {
    [self goAddAddressVC];
}

-(void)goAddAddressVC{
    AddressAddOrEditViewController *addAddressVC = [[AddressAddOrEditViewController alloc] initWithStoryboardName:@"Address"];
    BOOL isDefault = NO;
    if(self.tableData.count == 0){
        isDefault = YES;
    }
    addAddressVC.isDefaultAdd = isDefault;
    [self.navigationController pushViewController:addAddressVC animated:YES];
}
#pragma mark - 网络
-(void)requestAddressList{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [self showLoading];
    [[JMRequestManager sharedManager] POST:kUrlAddressList parameters:params completion:^(JMBaseResponse *response) {
        [self dismissLoading];
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            NSArray *dataArray = response.responseObject[@"data"];
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for(NSDictionary *dic in dataArray){
                AddressModel *model = [[AddressModel alloc] initWithDictionary:dic];
                [array addObject:model];
            }
            self.tableData = array;
            [self.tableView reloadData];
            if(self.tableData.count == 0){
                self.tableView.hidden = YES;
                self.contentHeightConstraint.constant = 200;
            }else{
                self.tableView.hidden = NO;
                self.contentHeightConstraint.constant = 300;
            }
        }
    }];
}
@end
