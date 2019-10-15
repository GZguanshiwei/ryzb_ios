//
//  GoodCouponSelectView.m
//  JMBaseProject
//
//  Created by Liuny on 2019/9/18.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "GoodCouponSelectView.h"
#import "CouponListCell.h"
#import "MyCouponModel.h"

@interface GoodCouponSelectView ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *canUseButton;
@property (weak, nonatomic) IBOutlet UIButton *notUseButton;
@property (weak, nonatomic) IBOutlet UIImageView *selectFlagView;
@property (strong, nonatomic) NSMutableArray *tableData;
@property (strong, nonatomic) NSMutableArray *noUseData;
@property (strong, nonatomic) NSMutableArray *canUseData;
@property (strong, nonatomic) NSMutableArray *selectData;

@property (assign, nonatomic) NSInteger type;//0:可用 1:不可用
@end

@implementation GoodCouponSelectView

-(void)initData{
    [self requestCouponList];
}

-(void)initControl{
    [super initControl];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 110.0;
    UINib *nib = [UINib nibWithNibName:@"CouponListCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"CouponListCell"];
}

-(void)setType:(NSInteger)type{
    _type = type;
    CGFloat centerX;
    switch (self.type) {
        case 0:
            self.canUseButton.selected = YES;
            self.notUseButton.selected = NO;
            centerX = self.canUseButton.centerX;
            self.tableData = self.canUseData;
            break;
        case 1:
            self.canUseButton.selected = NO;
            self.notUseButton.selected = YES;
            centerX = self.notUseButton.centerX;
            self.tableData = self.noUseData;
            break;
        default:
            centerX = self.canUseButton.centerX;
            break;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.selectFlagView.centerX = centerX;
    }];
    [self.tableView reloadData];
}

#pragma mark - UITalbeView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CouponListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CouponListCell"];
    cell.cellData = self.tableData[indexPath.row];
    cell.canUse = self.type == 0?YES:NO;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.type == 0){
        MyCouponModel *model = self.tableData[indexPath.row];
        model.isSelect = !model.isSelect;
        [self updateSelectCoupon:model];
    }
}

-(void)updateSelectCoupon:(MyCouponModel *)coupon{
    if(coupon.isSelect == NO){
        [self.selectData removeObject:coupon];
    }else{
        //添加到选中
        if(self.selectData == nil){
            self.selectData = [[NSMutableArray alloc] init];
        }
        
        BOOL hasNoAddUse = NO;
        for(MyCouponModel *model in self.selectData){
            if(model.canAddUse == NO){
                hasNoAddUse = YES;
                break;
            }
        }
        if(hasNoAddUse == YES){
            [JMProgressHelper toastInWindowWithMessage:@"您已经选了不可叠加使用的优惠券"];
            coupon.isSelect = NO;
        }else{
            if(coupon.canAddUse == NO && self.selectData.count > 0){
                ScreenCenterTipView *tipView = [[ScreenCenterTipView alloc] initWithXib];
                tipView.message = @"该优惠劵不可叠加使用，确定使用该券？";
                tipView.buttonTitles = @[@"暂不使用",@"使用"];
                [tipView showViewWithDoneBlock:^(NSDictionary * _Nonnull params) {
                    NSInteger index = [params getJsonValue:@"ButtonIndex"].integerValue;
                    if(index == 1){
                        //使用
                        for(MyCouponModel *coupon in self.selectData){
                            coupon.isSelect = NO;
                        }
                        [self.selectData removeAllObjects];
                        [self.selectData addObject:coupon];
                    }else{
                        //不使用
                        coupon.isSelect = NO;
                    }
                }];
            }else{
                [self.selectData addObject:coupon];
            }
        }
    }
    [self.tableView reloadData];
}


#pragma mark - Actions
- (IBAction)cancelAction:(id)sender {
    [self hideWithAnmation:YES];
}

- (IBAction)okAction:(id)sender {
    if(self.buttonClickBlock){
        NSMutableArray *array = [[NSMutableArray alloc] init];
        CGFloat money = 0;
        for(MyCouponModel *model in self.selectData){
            [array addObject:model.couponId];
            money += model.deductionPrice.doubleValue;
        }
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        if(array.count > 0){
            [params setJsonValue:[array componentsJoinedByString:@","] key:@"ids"];
        }
        [params setJsonValue:[NSString stringWithFormat:@"%.2f",money] key:@"money"];
        self.buttonClickBlock(params);
    }
    [self hideWithAnmation:YES];
}

- (IBAction)typeAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    self.type = button.tag;
}

#pragma mark - 网络
-(void)requestCouponList{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.goodId key:@"goodsId"];
    switch (self.goodType.integerValue) {
        case 0:
            [params setJsonValue:@"0" key:@"state"];
            break;
        case 1:
            [params setJsonValue:self.roomId key:@"roomId"];
            [params setJsonValue:@"1" key:@"state"];
            break;
        default:
            break;
    }
    
    [[JMRequestManager sharedManager] POST:kUrlGoodCouponList parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            NSDictionary *dataDic = response.responseObject[@"data"];
            NSArray *tureArray = dataDic[@"true"];
            NSArray *falseArray = dataDic[@"false"];
            
            NSMutableArray *canUseArray = [[NSMutableArray alloc] init];
            for(NSDictionary *dic in tureArray){
                MyCouponModel *model = [[MyCouponModel alloc] initWithDictionary:dic];
                [canUseArray addObject:model];
            }
            self.canUseData = canUseArray;
            NSString *title = [NSString stringWithFormat:@"可用优惠券(%d)",(int)self.canUseData.count];
            [self.canUseButton setTitle:title forState:UIControlStateNormal];
            
            NSMutableArray *noUseArray = [[NSMutableArray alloc] init];
            for(NSDictionary *dic in falseArray){
                MyCouponModel *model = [[MyCouponModel alloc] initWithDictionary:dic];
                [noUseArray addObject:model];
            }
            self.noUseData = noUseArray;
            self.type = 0;
        }
    }];
}
@end
