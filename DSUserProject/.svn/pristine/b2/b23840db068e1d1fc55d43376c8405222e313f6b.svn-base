//
//  SearchLiveCell.m
//  JMBaseProject
//
//  Created by Liuny on 2019/7/3.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "SearchLiveCell.h"

@interface SearchLiveCell ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *enterButton;
@end

@implementation SearchLiveCell

-(void)awakeFromNib{
    [super awakeFromNib];
    [self initControl];
}

-(void)initControl{
    self.coverImageView.layer.cornerRadius = 7.0;
    self.enterButton.layer.cornerRadius = 7.0;
}

-(void)setCellData:(LiveRoomModel *)cellData{
    _cellData = cellData;
    [self.coverImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:self.cellData.coverImage]];
    switch (self.cellData.state.integerValue) {
        case 0:
            self.statusLabel.text = @"直播中";
            self.statusImageView.image = [UIImage imageNamed:@"home_a06"];
            break;
        case 1:
        case 2:
            self.statusLabel.text = @"离线中";
            self.statusImageView.image = [UIImage imageNamed:@"home_a07"];
            break;
        default:
            break;
    }
    self.titleLabel.text = self.cellData.name;
    self.infoLabel.text = self.cellData.desc;
}


- (IBAction)enterAction:(id)sender {
}
@end
