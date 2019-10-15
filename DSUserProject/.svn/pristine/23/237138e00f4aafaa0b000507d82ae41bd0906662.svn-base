//
//  AfterSaleCell.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/27.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "AfterSaleCell.h"

@interface AfterSaleCell ()
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPayLabel;
@end

@implementation AfterSaleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initControl];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initControl{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.coverImageView.layer.cornerRadius = 4.0;
    self.coverImageView.layer.masksToBounds = YES;
}

-(void)setCellData:(AfterSaleModel *)cellData{
    _cellData = cellData;
    [self.coverImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:self.cellData.good.coverImage]];
    self.titleLabel.text = self.cellData.good.title;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",self.cellData.good.price];
    self.totalPayLabel.text = [NSString stringWithFormat:@"￥%@",self.cellData.money];
    [self refreshType];
    [self refreshState];
}

-(void)refreshType{
    NSString *type = @"";
    switch (self.cellData.type.integerValue) {
        case 0:
            type = @"仅退款";
            break;
        case 1:
            type = @"退货退款，已收货";
            break;
        case 2:
            type = @"退货退款，未收到货";
            break;
        default:
            break;
    }
    self.typeLabel.text = type;
}

-(void)refreshState{
    NSString *stateTip = @"";
    switch (self.cellData.state) {
        case AfterSaleState_InAudit:
            stateTip = @"申请审核中";
            break;
        case AfterSaleState_AuditSuccess:
            if(self.cellData.logisticsNo.length == 0){
                stateTip = @"申请成功";
            }else{
                stateTip = @"待商家收货";
            }
            break;
        case AfterSaleState_AuditFail:
            stateTip = @"被拒绝";
            break;
        case AfterSaleState_Close:
            stateTip = @"关闭申请";
            break;
        case AfterSaleState_Complete:
            if(self.cellData.type.integerValue == 0){
                stateTip = @"退款成功";
            }else{
                stateTip = @"退货退款成功";
            }
            break;
        default:
            break;
    }
    self.statusLabel.text = stateTip;
}

- (IBAction)buttonAction:(id)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(clickOperationButton:title:)]){
        UIButton *button = (UIButton *)sender;
        [self.delegate clickOperationButton:self.index title:[button currentTitle]];
    }
}

@end
