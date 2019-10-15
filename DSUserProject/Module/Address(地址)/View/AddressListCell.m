//
//  AddressListCell.m
//  JMBaseProject
//
//  Created by Liuny on 2019/1/4.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "AddressListCell.h"

@interface AddressListCell()
@property (weak, nonatomic) IBOutlet UIButton *selectFlagButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end


@implementation AddressListCell

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
    self.selectFlagButton.selected = self.cellData.isDefault;
}

@end
