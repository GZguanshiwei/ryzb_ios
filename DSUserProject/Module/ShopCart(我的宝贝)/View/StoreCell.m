//
//  StoreCell.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/19.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "StoreCell.h"

@interface StoreCell ()


@end

@implementation StoreCell

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
    
    self.tagView.layer.cornerRadius = 2.0;
    self.tagView.layer.borderColor = [UIColor colorWithHexString:@"#FF701C"].CGColor;
    self.tagView.layer.borderWidth = 0.8;
    
    self.coverImageView.layer.cornerRadius = 4.0;
    self.coverImageView.layer.masksToBounds = YES;
}

-(void)setStoreGood:(GoodModel *)storeGood{
    _storeGood = storeGood;
    [self.coverImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:self.storeGood.coverImage]];
    self.titleLabel.text = self.storeGood.title;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",self.storeGood.price];
    self.timeLabel.text = [NSString stringWithFormat:@"收藏于%@",self.storeGood.time];
}

#pragma mark - Actions

- (IBAction)buyAction:(id)sender {
    //立即购买
    if(self.delegate && [self.delegate respondsToSelector:@selector(didBuy:)]){
        [self.delegate didBuy:self.indexPath];
    }
}

- (IBAction)serviceAction:(id)sender {
    //联系客服
    if(self.delegate && [self.delegate respondsToSelector:@selector(didCustomerService:)]){
        [self.delegate didCustomerService:self.indexPath];
    }
}

- (IBAction)cancelStoreAction:(id)sender {
    //取消收藏
    if(self.delegate && [self.delegate respondsToSelector:@selector(didCancelStore:)]){
        [self.delegate didCancelStore:self.indexPath];
    }
}



@end
