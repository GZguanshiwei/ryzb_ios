//
//  ReceiveGiftView.m
//  JMBaseProject
//
//  Created by liuny on 2018/7/13.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import "ReceiveGiftView.h"
//#import "VideoChatManager.h"
//#import "HomeViewController.h"
//#import "LivePlayerViewController.h"
//#import "VideoReceiverViewController.h"
//#import "VideoSenderViewController.h"

@interface ReceiveGiftView()

/** 发送者头像 */
@property (strong, nonatomic) IBOutlet UIImageView *sendUserHeadImageView;
@property (strong, nonatomic) IBOutlet UIView *giftView;
/** 发送者昵称 */
@property (strong, nonatomic) IBOutlet UILabel *sendUserNameLabel;
/** 礼物名称 */
@property (strong, nonatomic) IBOutlet UILabel *giftNameLabel;
/** 礼物图标 */
@property (strong, nonatomic) IBOutlet UIImageView *giftImageView;
/** 接收者头像 */
@property (strong, nonatomic) IBOutlet UIImageView *receiveHeadImageView;
/** 接收者头像宽度 */
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *receiveHeadImageViewWidthLC;
/** 数量 */
@property (strong, nonatomic) IBOutlet UILabel *numLabel;

/** 充值view */
@property (strong, nonatomic) IBOutlet UIView *rechargeView;
/** 充值用户昵称 */
@property (strong, nonatomic) IBOutlet UILabel *rechargeUserNameLabel;
/** 充值金额 */
@property (strong, nonatomic) IBOutlet UILabel *rechargeCountLabel;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, readwrite) NSInteger curComboCount;
@property (nonatomic, readwrite) BOOL isCancel;
@end

@implementation ReceiveGiftView

-(instancetype)initWithXib{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    self = nibView.firstObject;
    if(self){
        [self initControl];
        [self initData];
    }
    return self;
}

-(void)initControl{
    ViewRadius(self.receiveHeadImageView, self.receiveHeadImageView.mj_h/2);
    ViewRadius(self.giftImageView, self.giftImageView.mj_h/2);
    ViewRadius(self.sendUserHeadImageView, self.sendUserHeadImageView.mj_h/2);
}

-(void)initData{
    
}

//-(void)setGift:(ReceiveGiftModel *)gift{
//    _gift = gift;
//    UserModel *sender = self.gift.sendUser;
//    GiftModel *receiveGift = self.gift.gift;
//    UIViewController *vc = [UIWindow jm_currentViewController];
//    [self.sendUserHeadImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:sender.anchorHeadUrl] placeholderImage:[UIImage imageNamed:@"home_g03"]];
//    // 是否为充值
//    if (receiveGift.isRecharge) {
//        self.giftView.hidden = YES;
//        self.rechargeView.hidden = NO;
//        self.rechargeUserNameLabel.text = sender.anchorName;
//
//        self.rechargeCountLabel.text = [NSString stringWithFormat:@"成功充值%@A币",receiveGift.rechargeCount];
//        long len = self.rechargeCountLabel.text.length - 4;
//        NSRange range = NSMakeRange(4, len);
//        [self setTextLabel:self.rechargeCountLabel color:[UIColor colorWithHexString:@"#FFDB4C"] range:range];
//    }else{
//        self.rechargeView.hidden = YES;
//        self.giftView.hidden = NO;
//        self.sendUserNameLabel.text = sender.anchorName;
//
//        if([vc isKindOfClass:[LivePlayerViewController class]] || [vc isKindOfClass:[VideoSenderViewController class]] || [vc isKindOfClass:[VideoReceiverViewController class]]){
//            //视频聊中送礼
//            self.receiveHeadImageView.hidden = YES;
//            self.receiveHeadImageViewWidthLC.constant = 0;
//            self.giftNameLabel.text = [NSString stringWithFormat:@"送出%@",self.gift.gift.name];
//        }else if([vc isKindOfClass:[HomeViewController class]]){
//            //首页礼物
//            self.receiveHeadImageView.hidden = NO;
//            self.receiveHeadImageViewWidthLC.constant = 30;
//            [self.receiveHeadImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:self.gift.receiverUser.anchorHeadUrl] placeholderImage:[UIImage imageNamed:@"home_d02"]];
//            self.giftNameLabel.text = [NSString stringWithFormat:@"送给%@",self.gift.receiverUser.anchorName];
//        }
//        self.numLabel.text = [NSString stringWithFormat:@"x%ld",gift.giftNum];
//        [self.giftImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:receiveGift.image] placeholderImage:[UIImage imageNamed:@"home_e28"]];
//    }
//}

-(void)startComboAnim{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(combo) userInfo:nil repeats:YES];
        _curComboCount = 1;
    }
}

// 连击
-(void)combo
{
    // 当前连发数，已经显示完毕
    if (_curComboCount > _gift.giftNum) { // 停止定时器
        // 停止定时器
        [self performSelector:@selector(cancel) withObject:nil afterDelay:1];
    } else {
        // 修改label显示
        self.numLabel.text = [NSString stringWithFormat:@"x%ld",_curComboCount];
        
        //连击动画
        [UIView animateWithDuration:0.15 animations:^{
            self.transform = CGAffineTransformMakeScale(2, 2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 animations:^{
            self.transform = CGAffineTransformIdentity;
            }];
        }];
        
        // 取消定时器销毁
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(cancel) object:nil];
        
        _curComboCount++;
    }
}

- (void)cancel
{
    if (_isCancel == NO) {
        _isCancel = YES;
        
        [_timer invalidate];
        _timer = nil;
        
        if (self.dismissViewBlock) {
            self.dismissViewBlock(self);
        }
    }
}

/**
 修改部分字体颜色
 
 @param label 需要修改的label
 @param color 修改部分字体颜色
 @param range 修改部分字NSRange
 */
-(void) setTextLabel:(UILabel *)label color:(UIColor *)color range:(NSRange )range{
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:label.text];
    [textColor addAttribute:NSForegroundColorAttributeName value:color range:range];
    label.text = nil;
    [label setAttributedText:textColor];
}

@end
