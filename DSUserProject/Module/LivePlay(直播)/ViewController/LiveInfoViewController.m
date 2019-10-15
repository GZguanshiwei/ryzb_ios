//
//  LiveInfoViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/28.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "LiveInfoViewController.h"

@interface LiveInfoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *roomDescLabel;

@property (weak, nonatomic) IBOutlet UIImageView *anchorHeadImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameAndAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *anchorDescLabel;
@end

@implementation LiveInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    self.view.backgroundColor = [UIColor clearColor];
    
    self.anchorHeadImageView.layer.cornerRadius = self.anchorHeadImageView.mj_h/2.0;
    self.anchorHeadImageView.layer.masksToBounds = YES;
}

-(void)initData{
    
}

-(void)setRoomDetail:(RoomDetailModel *)roomDetail{
    _roomDetail = roomDetail;
    self.nameLabel.text = self.roomDetail.name;
    self.roomDescLabel.text =  [JMCommonMethod getTelephoneNumWith:self.roomDetail.roomDesc];
    self.anchorDescLabel.text = [JMCommonMethod getTelephoneNumWith:self.roomDetail.creatorDesc] ;
    self.nameAndAddressLabel.text = [NSString stringWithFormat:@"%@  丨  %@",self.roomDetail.creatorName,self.roomDetail.address];
    [self.anchorHeadImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:self.roomDetail.creatorHead]];
}

#pragma mark - Actions
- (IBAction)buyMethodAction:(id)sender {
    //购买攻略
    HtmlViewController *htmlVC = [[HtmlViewController alloc] init];
    htmlVC.type = Html_Buy;
    [self.navigationController pushViewController:htmlVC animated:YES];
}
@end
