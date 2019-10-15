//
//  MarketLiveCell.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/15.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "MarketLiveCell.h"

@interface MarketLiveCell ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *stateIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *msgHeadImageView;
@property (weak, nonatomic) IBOutlet UILabel *msgTextLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressAndOnlinePeopleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *liveCoverImageView;


@end

@implementation MarketLiveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initControl];
}

-(void)initControl{
    self.headImageView.layer.cornerRadius = self.headImageView.mj_h/2.0;
    self.headImageView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = 7.0;
    self.backView.layer.masksToBounds = YES;
    ViewRadius(self.msgHeadImageView, self.msgHeadImageView.mj_h/2.0);
}


-(void)setCellData:(LiveRoomModel *)cellData{
    _cellData = cellData;
    switch (self.cellData.state.integerValue) {
        case 0:
            self.stateLabel.text = @"直播中";
            self.stateIconImageView.image = [UIImage imageNamed:@"home_a06"];
            //在线人数
            self.addressAndOnlinePeopleLabel.text = [NSString stringWithFormat:@"%@ 丨  %@",self.cellData.onlinePeople,self.cellData.city];
            break;
        case 1:
        case 2:
            self.stateLabel.text = @"离线中";
            self.stateIconImageView.image = [UIImage imageNamed:@"home_a07"];
            //在线人数
            self.addressAndOnlinePeopleLabel.text = self.cellData.city;
            break;
        default:
            break;
    }
    [self.liveCoverImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:self.cellData.bigCoverImage]];
    self.titleLabel.text = self.cellData.name;
    [self.headImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:self.cellData.anchorHead]];
    self.nameLabel.text = self.cellData.anchorName;
    
    [self.msgHeadImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:self.cellData.msgHead]];
    self.msgTextLabel.text = self.cellData.msgText;
}

@end
