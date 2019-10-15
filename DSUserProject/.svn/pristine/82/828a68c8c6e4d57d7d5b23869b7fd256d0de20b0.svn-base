//
//  LiveEnterRoomView.m
//  JMBaseProject
//
//  Created by 利是封 on 2019/9/21.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "LiveEnterRoomView.h"
@interface LiveEnterRoomView()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *niceNameLabel;

@property (nonatomic, strong) NSTimer *timer;
@end
@implementation LiveEnterRoomView
-(instancetype)initWithXib{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"ReceiveGiftView" owner:nil options:nil];
    self = [nibView objectAtIndex:1];
    if(self){
    }
    return self;
}


- (void)setGift:(TCMsgModel *)gift{
    _gift = gift;
    if (gift.liveGrade.intValue == 4) {
        [self.bgImageView setImage:[UIImage imageNamed:@"live_tx_zz"]];
        [self.logoImageView setImage:[UIImage imageNamed:@"live_tag_small_4"]];
    }else{
        [self.bgImageView setImage:[UIImage imageNamed:@"live_tx_boss"]];
        [self.logoImageView setImage:[UIImage imageNamed:@"live_tag_small_5"]];
    }
    self.niceNameLabel.text = gift.userName;
}


-(void)hideView{
    if (_timer == nil) {
           _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(cancel) userInfo:nil repeats:YES];
       }
}

- (void)cancel
{
        [_timer invalidate];
        _timer = nil;
        if (self.dismissViewBlock) {
            self.dismissViewBlock(self);
        }
}


@end
