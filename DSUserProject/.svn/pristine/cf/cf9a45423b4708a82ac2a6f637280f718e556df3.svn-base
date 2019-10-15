//
//  DetailItemView.m
//  JMBaseProject
//
//  Created by Liuny on 2019/7/15.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "DetailItemView.h"

@interface DetailItemView ()
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation DetailItemView

-(instancetype)initWithTip:(NSString *)tip content:(NSString *)content{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    self = nibView.firstObject;
    if(self){
        self.tipLabel.text = tip;
        self.contentLabel.text = content;
    }
    return self;
}



@end
