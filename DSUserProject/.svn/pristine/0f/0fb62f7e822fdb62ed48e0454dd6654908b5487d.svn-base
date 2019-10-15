//
//  LiveMessageCell.m
//  JMBaseProject
//
//  Created by Liuny on 2019/7/4.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "LiveMessageCell.h"

@interface LiveMessageCell ()

/** 直播间等级图标 */
@property (strong, nonatomic) IBOutlet UIImageView *liveLevelImageView;
/** 内容label */
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contentLabelLeftLC;
/** 赞 */
@property (strong, nonatomic) IBOutlet UIView *zanView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *zanViewWidth;

@end

@implementation LiveMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setCellData:(TCMsgModel *)cellData {
    _cellData = cellData;
    self.zanView.hidden = YES;
    self.zanViewWidth.constant = 0;
    self.contentLabelLeftLC.constant = 8;
    self.liveLevelImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"live_tag_small_%@",cellData.liveGrade]];
    
    switch (cellData.msgType) {
        case TCMsgModelType_MemberEnterRoom://进入房间消息
//        case TCMsgModelType_MemberQuitRoom:
        {
            NSString *message = [NSString stringWithFormat:@"%@ %@",cellData.userName,cellData.userMsg];
            NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:message];
            [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#46C596"] range:NSMakeRange(0, message.length)];
            self.contentLabel.attributedText = attriStr;
        }
            break;
        case TCMsgModelType_NormalMsg://普通消息
        {
            NSString *message = [NSString stringWithFormat:@"%@: %@",cellData.userName,cellData.userMsg];
            
            UIColor *textColor;
            if(cellData.liveGrade.integerValue == 5){
                textColor = [UIColor colorWithHexString:@"#FDC84B"];
            }else{
                textColor = [UIColor whiteColor];
            }
            UIColor *nameColor = [UIColor colorWithHexString:@"#46C596"];
            NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:message];
            [attriStr addAttribute:NSForegroundColorAttributeName value:nameColor range:NSMakeRange(0, cellData.userName.length+1)];
            [attriStr addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(cellData.userName.length+2, cellData.userMsg.length)];
            self.contentLabel.attributedText = attriStr;
        }
            break;
        case TCMsgModelType_Focus0nMsg://关注消息
        {
            NSString *message = [NSString stringWithFormat:@"%@ %@",cellData.userName,cellData.userMsg];
            NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:message];
            [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#46C596"] range:NSMakeRange(0, cellData.userName.length)];
            self.contentLabel.attributedText = attriStr;
        }
            break;
        case TCMsgModelType_Praise://点赞消息
        {
            NSString *message = [NSString stringWithFormat:@"%@ %@",cellData.userName,cellData.userMsg];
            NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:message];
            [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#46C596"] range:NSMakeRange(0, cellData.userName.length)];
            self.contentLabel.attributedText = attriStr;
            self.zanView.hidden = NO;
            self.zanViewWidth.constant = 26;
        }
            break;
        case TCMsgModelType_Paying://支付中消息
        {
            NSString *message = [NSString stringWithFormat:@"%@ %@",cellData.userName,cellData.userMsg];
            NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:message];
            [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#FF701C"] range:NSMakeRange(0, message.length)];
            self.contentLabel.attributedText = attriStr;
        }
            break;
        case TCMsgModelType_PaySuccess://支付成功消息
        {
            NSString *message = [NSString stringWithFormat:@"%@ %@",cellData.userName,cellData.userMsg];
            NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:message];
            [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#FDBE1B"] range:NSMakeRange(0, message.length)];
            self.contentLabel.attributedText = attriStr;
        }
            break;
        case TCMsgModelType_AnchorMsg://主播消息
        {
            NSString *message = [NSString stringWithFormat:@"%@: %@",cellData.userName,cellData.userMsg];
            NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:message];
            [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff1c1c"] range:NSMakeRange(0, message.length)];
            self.contentLabel.attributedText = attriStr;
            self.liveLevelImageView.image = nil;
            self.contentLabelLeftLC.constant = 0;
        }
            break;
        case TCMsgModelType_HappyNews://喜报
        {
            NSString *message = [NSString stringWithFormat:@"%@ %@",cellData.userName,cellData.userMsg];
            NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:message];
            [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#FDBE1B"] range:NSMakeRange(0, message.length)];
            self.contentLabel.attributedText = attriStr;
        }
            break;
        default:
            break;
    }
}

@end
