//
//  JMCommitButton.m
//  JMBaseProject
//
//  Created by Liuny on 2019/1/9.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "JMCommitButton.h"

@implementation JMCommitButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self initControl];
    }
    return self;
}

-(void)initControl{
    self.layer.cornerRadius = 5.0;
    self.layer.masksToBounds = YES;
    self.backgroundColor = kColorMain;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
}

@end
