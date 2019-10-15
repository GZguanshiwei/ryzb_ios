//
//  AddressManagerCell.m
//  JMBaseProject
//
//  Created by Liuny on 2019/1/5.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "AddressManagerCell.h"

@interface AddressManagerCell() 
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *isDefaultButton;

@end

@implementation AddressManagerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(AddressModel *)cellData{
    _cellData = cellData;
    self.nameLabel.text = [NSString stringWithFormat:@"收货人:%@",self.cellData.name];
    self.phoneLabel.text = self.cellData.phone;
    self.addressLabel.text = [NSString stringWithFormat:@"收货地址:%@",[self.cellData allAddress]];
    self.isDefaultButton.selected = self.cellData.isDefault;
}

#pragma mark - Actions

- (IBAction)defaultAction:(id)sender {
    //设置默认
    if(self.delegate && [self.delegate respondsToSelector:@selector(addressDidChangeDefault:)]){
        [self.delegate addressDidChangeDefault:self.index];
    }
}

- (IBAction)deleteAction:(id)sender {
    //删除
    if(self.delegate && [self.delegate respondsToSelector:@selector(addressDidDelete:)]){
        [self.delegate addressDidDelete:self.index];
    }
}

- (IBAction)editAction:(id)sender {
    //编辑
    if(self.delegate && [self.delegate respondsToSelector:@selector(addressDidEdit:)]){
        [self.delegate addressDidEdit:self.index];
    }
}

@end
