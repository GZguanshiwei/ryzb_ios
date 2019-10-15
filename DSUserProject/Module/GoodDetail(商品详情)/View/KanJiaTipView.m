//
//  KanJiaTipView.m
//  JMBaseProject
//
//  Created by Liuny on 2019/9/17.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "KanJiaTipView.h"

@interface KanJiaTipView ()
@property (weak, nonatomic) IBOutlet UILabel *centerLabel;

@end

@implementation KanJiaTipView


-(void)initData{
    NSString *showString = [NSString stringWithFormat:@"你已经砍了%@元",self.downMoney];
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:showString];
    [attriStr addAttribute:NSForegroundColorAttributeName value:kColorMain range:NSMakeRange(5, self.downMoney.length)];
    self.centerLabel.attributedText = attriStr;
}

- (IBAction)shareAction:(id)sender {
    if(self.buttonClickBlock){
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        self.buttonClickBlock(params);
    }
    [self hideView];
}

@end
