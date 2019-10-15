//
//  GroupCell.m
//  JMBaseProject
//
//  Created by Liuny on 2019/1/3.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "GroupCell.h"

@interface GroupCell()
@property (weak, nonatomic) IBOutlet UIImageView *selectFlagView;
@property (weak, nonatomic) IBOutlet UILabel *groupTitleLabel;

@end

@implementation GroupCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(GroupModel *)cellData{
    _cellData = cellData;
    if(self.cellData.isSelect){
        self.selectFlagView.hidden = NO;
        self.groupTitleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
        self.groupTitleLabel.textColor = kColorMain;
        self.contentView.backgroundColor = [UIColor whiteColor];
    }else{
        self.selectFlagView.hidden = YES;
        self.groupTitleLabel.textColor = [UIColor colorWithHexString:@"#444444"];
        self.groupTitleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
    }
    self.groupTitleLabel.text = self.cellData.groupName;
}

@end
