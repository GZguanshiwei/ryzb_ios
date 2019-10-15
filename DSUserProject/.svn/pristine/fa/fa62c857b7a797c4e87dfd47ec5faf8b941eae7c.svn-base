//
//  MoreOperationView.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/20.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "MoreOperationView.h"

@implementation MoreOperationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)buttonAction:(id)sender {
    if(self.buttonClickBlock){
        UIButton *button = (UIButton *)sender;
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setJsonValue:[NSString stringWithFormat:@"%d",(int)button.tag] key:@"ButtonIndex"];
        self.buttonClickBlock(params);
    }
    [self hideWithAnmation:NO];
}

- (IBAction)cancelAction:(id)sender {
    [self hideWithAnmation:YES];
}
@end
