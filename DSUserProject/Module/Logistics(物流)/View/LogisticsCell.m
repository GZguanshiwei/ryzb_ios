//
//  LogisticsCell.m
//  JMBaseProject
//
//  Created by Liuny on 2019/7/16.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "LogisticsCell.h"

@interface LogisticsCell ()
@property (weak, nonatomic) IBOutlet UIView *upLineView;
@property (weak, nonatomic) IBOutlet UIView *downLineView;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end

@implementation LogisticsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(LogisticsModel *)cellData{
    _cellData = cellData;
    self.downLineView.hidden = NO;
    self.upLineView.hidden = NO;
    self.tipLabel.text = @"运";
    if(self.cellData.isLastOne){
        self.downLineView.hidden = YES;
        self.tipLabel.text = @"下";
    }
    if(self.cellData.isFirstOne){
        self.upLineView.hidden = YES;
        if(self.cellData.state.integerValue == 3){
            self.tipLabel.text = @"收";
        }
    }
    self.contentLabel.text = self.cellData.content;
    self.dateLabel.text = [self.cellData showDate];
    self.timeLabel.text = [self.cellData showTime];
}

@end
