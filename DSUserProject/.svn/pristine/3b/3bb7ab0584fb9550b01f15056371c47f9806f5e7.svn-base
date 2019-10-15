//
//  ScreenCenterTipView.m
//  JMBaseProject
//
//  Created by ios on 2018/12/28.
//  Copyright © 2018 liuny. All rights reserved.
//

#import "ScreenCenterTipView.h"

@interface ScreenCenterTipView()

@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;

@end

@implementation ScreenCenterTipView

-(void)initControl{
    [super initControl];
    self.mainView.layer.cornerRadius = 7.0;
    self.mainView.layer.masksToBounds = YES;
}

-(void)initData{
    self.titleLabel.text = self.message;
    switch (self.buttonTitles.count) {
        case 0:
            break;
        case 1:
            self.rightButton.tag = 0;
            self.leftButton.hidden = YES;
            [self.rightButton setTitle:self.buttonTitles.firstObject forState:UIControlStateNormal];
            break;
        case 2:
            self.leftButton.tag = 0;
            self.rightButton.tag = 1;
            [self.leftButton setTitle:self.buttonTitles.firstObject forState:UIControlStateNormal];
            [self.rightButton setTitle:self.buttonTitles.lastObject forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

#pragma mark - Actions
- (IBAction)buttonAction:(id)sender {
    if(self.buttonClickBlock){
        UIButton *button = (UIButton *)sender;
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setJsonValue:button.currentTitle key:@"Title"];
        NSString *buttonTag = [NSString stringWithFormat:@"%d",(int)button.tag];
        [params setJsonValue:buttonTag key:@"ButtonIndex"];
        self.buttonClickBlock(params);
    }
    [self hideView];
}

@end
