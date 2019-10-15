//
//  DetailBannerCell.m
//  JMBaseProject
//
//  Created by Liuny on 2019/7/15.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "DetailBannerCell.h"

@interface DetailBannerCell ()
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UIImageView *playImageView;

@end

@implementation DetailBannerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)updateImageUrl:(NSString *)imageUrl isShowPlay:(BOOL)showPlay{
    [self.contentImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:imageUrl]];
    self.playImageView.hidden = !showPlay;
}

@end
