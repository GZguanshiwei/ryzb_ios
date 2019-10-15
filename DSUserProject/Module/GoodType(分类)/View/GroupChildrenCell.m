//
//  GroupChildrenCell.m
//  JMBaseProject
//
//  Created by Liuny on 2019/1/3.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "GroupChildrenCell.h"

@interface GroupChildrenCell()
@property (weak, nonatomic) IBOutlet UIImageView *groupCoverImageView;
@property (weak, nonatomic) IBOutlet UILabel *groupTitleLabel;

@end

@implementation GroupChildrenCell

-(void)awakeFromNib{
    [super awakeFromNib];
    [self initControl];
}

-(void)initControl{
    self.groupCoverImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.groupCoverImageView.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
}

-(void)setCellData:(GroupModel *)cellData{
    _cellData = cellData;
    [self.groupCoverImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:self.cellData.groupCoverImage]];
    self.groupTitleLabel.text = self.cellData.groupName;
}

-(void)testCellData{
    int index = arc4random()%4;
    NSString *imageName = [NSString stringWithFormat:@"Good%d",index];
    self.groupCoverImageView.image = [UIImage imageNamed:imageName];
}

@end
