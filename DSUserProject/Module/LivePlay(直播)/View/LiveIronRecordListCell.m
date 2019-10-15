//
//  LiveIronRecordListCell.m
//  JMBaseProject
//
//  Created by 潘传标 on 2019/9/4.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "LiveIronRecordListCell.h"

@interface LiveIronRecordListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation LiveIronRecordListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(LiveLevelRecordModel *)cellData{
    _cellData = cellData;
    NSString *imageName = [self.cellData iconImageName];
    self.iconImageView.image = [UIImage imageNamed:imageName];
    self.titleLabel.text = self.cellData.title;
    self.timeLabel.text = self.cellData.time;
    self.valueLabel.text = [NSString stringWithFormat:@"+%@分",self.cellData.value];
}

-(void)setUcLevelData:(LevelRecordModel *)ucLevelData{
    _ucLevelData = ucLevelData;
    [self.iconImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:self.ucLevelData.image]];
    self.titleLabel.text = self.ucLevelData.title;
    self.timeLabel.text = self.ucLevelData.time;
    if([self.ucLevelData.value hasPrefix:@"-"]){
        self.valueLabel.text = [NSString stringWithFormat:@"%@分",self.ucLevelData.value];
    }else{
        self.valueLabel.text = [NSString stringWithFormat:@"+%@分",self.ucLevelData.value];
    }
}

@end
