//
//  NewsCell.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/19.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "NewsCell.h"

@interface NewsCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

@end

@implementation NewsCell

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
    self.coverImageView.layer.cornerRadius = 7.0;
    self.coverImageView.layer.masksToBounds = YES;
}

-(void)setCellData:(NewsModel *)cellData{
    _cellData = cellData;
    self.titleLabel.text = self.cellData.title;
    self.timeLabel.text = self.cellData.time;
    [self.coverImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:self.cellData.coverImage]];
}

@end
