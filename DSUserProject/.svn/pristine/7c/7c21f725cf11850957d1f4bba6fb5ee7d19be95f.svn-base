//
//  LiveShowGiftView.m
//  JMBaseProject
//
//  Created by 利是封 on 2019/9/21.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "LiveShowGiftView.h"
@interface LiveShowGiftView()
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) NSTimer *timer;

@end
@implementation LiveShowGiftView
-(instancetype)initWithXib{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"ReceiveGiftView" owner:nil options:nil];
    self = [nibView objectAtIndex:2];
    if(self){
    
    }
    return self;
}

- (void)setGift:(TCMsgModel *)gift{
    _gift = gift;
    self.logoImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"live_tag_small_%@",gift.liveGrade]];
    self.nickNameLabel.text = gift.userName;
    NSDictionary * dic = [self dictionaryWithJsonString:gift.userMsg];
    self.titleLabel.text = [NSString stringWithFormat:@"送出了%@",[dic getJsonValue:@"name"]];
    NSString * url = [dic getJsonValue:@"image"];
    [self.bgImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:url]];
}

-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
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
