//
//  ResaleTipView.m
//  JMBaseProject
//
//  Created by Liuny on 2019/7/3.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "ResaleTipView.h"

@interface ResaleTipView ()
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *liRunTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *liRunLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end


@implementation ResaleTipView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)initData{
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",self.good.resalePrice];
    self.liRunTipLabel.text = [NSString stringWithFormat:@"建议利润：￥%@ -￥%@ = ",self.good.resalePrice,self.good.price];
    float liRun = self.good.resalePrice.doubleValue - self.good.price.doubleValue;
    self.liRunLabel.text = [NSString stringWithFormat:@"￥%.2f",liRun];
    self.contentTextView.text = self.good.title;
}

- (IBAction)cancelAction:(id)sender {
    [self hideView];
}
- (IBAction)resaleAction:(id)sender {
    if(self.buttonClickBlock){
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setJsonValue:@"1" key:@"ButtonIndex"];
        [params setJsonValue:self.contentTextView.text key:@"Content"];
        self.buttonClickBlock(params);
    }
    [self hideView];
}
- (IBAction)infoAction:(id)sender {
    if(self.buttonClickBlock){
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setJsonValue:@"0" key:@"ButtonIndex"];
        self.buttonClickBlock(params);
    }
    [self hideView];
}

@end
