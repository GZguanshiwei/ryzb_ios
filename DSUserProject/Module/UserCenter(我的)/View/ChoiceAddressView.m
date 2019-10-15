//
//  ChoiceAddressView.m
//  JMBaseProject
//
//  Created by 潘传标 on 2019/9/7.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "ChoiceAddressView.h"
#import "AddressModel.h"
#import "ChoiceAddressListCell.h"
@interface ChoiceAddressView()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSIndexPath *selectIndexPath;
@property (weak, nonatomic) IBOutlet UIView *hasNoAddressView;
@end

@implementation ChoiceAddressView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.tableView.estimatedRowHeight = 100;
}


+(void)showWithSelectCoyponBlock:(void(^)(AddressModel *model))selectModel
{
    ChoiceAddressView *alertView =   [[self alloc] init];
    alertView.frame = [UIScreen mainScreen].bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
    alertView.confirmAlertBlock = ^(AddressModel * _Nonnull model) {
        if (selectModel) {
            selectModel(model);
        }
    };
    alertView.tableView.dataSource = alertView;
    alertView.tableView.delegate = alertView;
    [alertView.tableView registerNib:[UINib nibWithNibName:@"ChoiceAddressListCell" bundle:nil] forCellReuseIdentifier:choiceAddressListCellID];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChoiceAddressListCell *cell = [tableView dequeueReusableCellWithIdentifier:choiceAddressListCellID forIndexPath:indexPath];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!JMIsEmpty(self.selectIndexPath)) {
        if (self.selectIndexPath == indexPath) {
            ChoiceAddressListCell *lastcell = [tableView cellForRowAtIndexPath:self.selectIndexPath];
            lastcell.selectButton.selected = NO;
            self.selectIndexPath = nil;
            return;
            
        }
        ChoiceAddressListCell *lastcell = [tableView cellForRowAtIndexPath:self.selectIndexPath];
        lastcell.selectButton.selected = NO;
        ChoiceAddressListCell *currentell = [tableView cellForRowAtIndexPath:indexPath];
        currentell.selectButton.selected = YES;
        self.selectIndexPath = indexPath;
        
        
    }else
    {
        
        ChoiceAddressListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.selectButton.selected = YES;
        self.selectIndexPath = indexPath;
        
    }
    
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ChoiceAddressView" owner:nil options:nil] lastObject];
    }
    return self;
}
- (IBAction)cancleButtonClick:(id)sender {
    [self removeFromSuperview];
}

- (IBAction)sureButtonClick:(id)sender {
    
    if (self.confirmAlertBlock) {
        self.confirmAlertBlock([AddressModel new]);
    }
    [self removeFromSuperview];
}
#pragma mark - 添加收货地址
- (IBAction)addAddressBlock:(id)sender {
    [self removeFromSuperview];
    
}
@end
