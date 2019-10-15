//
//  LiveAttentionCell.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/15.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "LiveAttentionCell.h"

@interface LiveAttentionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *stateIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@end

@implementation LiveAttentionCell

-(void)awakeFromNib{
    [super awakeFromNib];
    [self initControl];
}

-(void)initControl{
    self.coverImageView.layer.cornerRadius = self.coverImageView.mj_h/2.0;
    self.coverImageView.layer.masksToBounds = YES;
    self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
}

-(void)setCellData:(LiveRoomModel *)cellData{
    _cellData = cellData;
    [self.coverImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:self.cellData.coverImage]];
    self.titleLabel.text = self.cellData.name;
    switch (self.cellData.state.integerValue) {
        case 0:
            self.stateLabel.text = @"直播中";
            self.stateIconImageView.image = [UIImage imageNamed:@"home_a06"];
            break;
        case 1:
        case 2:
            self.stateLabel.text = @"离线中";
            self.stateIconImageView.image = [UIImage imageNamed:@"home_a07"];
            break;
        default:
            break;
    }
    
}

@end
