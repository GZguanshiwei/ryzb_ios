//
//  AttentionLiveCell.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/17.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "AttentionLiveCell.h"

@interface AttentionLiveCell ()
@property (weak, nonatomic) IBOutlet UIImageView *stateIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *onlinePeopleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *liveCoverImageView;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@end

@implementation AttentionLiveCell

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
    self.headImageView.layer.cornerRadius = self.headImageView.mj_h/2.0;
    self.headImageView.layer.masksToBounds = YES;
    self.mainView.layer.cornerRadius = 7.0;
    self.mainView.layer.masksToBounds = YES;
}

-(void)setCellData:(LiveRoomModel *)cellData{
    _cellData = cellData;
    [self.headImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:self.cellData.anchorHead]];
    self.nameLabel.text = self.cellData.anchorName;
    self.titleLabel.text = self.cellData.name;
    [self.liveCoverImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:self.cellData.coverImage]];
    switch (self.cellData.state.integerValue) {
        case 0:
            self.stateLabel.text = @"直播中";
            self.stateIconImageView.image = [UIImage imageNamed:@"home_a06"];
            self.onlinePeopleLabel.text = self.cellData.onlinePeople;
            break;
        case 1:
        case 2:
            self.stateLabel.text = @"离线中";
            self.stateIconImageView.image = [UIImage imageNamed:@"home_a07"];
            self.onlinePeopleLabel.text = self.cellData.onlinePeople;
            break;
        default:
            break;
    }
}

#pragma mark - Actions
- (IBAction)cancelAttentionAction:(id)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(didCancelAttention:)]){
        [self.delegate didCancelAttention:self.index];
    }
}
@end
