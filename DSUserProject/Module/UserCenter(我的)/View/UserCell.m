//
//  UserCell.m
//  JMBaseProject
//
//  Created by ios on 2018/12/25.
//  Copyright © 2018 liuny. All rights reserved.
//

#import "UserCell.h"

@interface UserCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *goImage;

@end

@implementation UserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark - Public
- (void)setCellData:(NSDictionary *)cellDataDic {               //设置cell的内容
    NSString *iconImageName = [cellDataDic valueForKey:@"image"];
    [self.iconImage setImage:[UIImage imageNamed:iconImageName]];
    NSString *title = [cellDataDic valueForKey:@"title"];
    self.titleLabel.text = title;
}

@end
