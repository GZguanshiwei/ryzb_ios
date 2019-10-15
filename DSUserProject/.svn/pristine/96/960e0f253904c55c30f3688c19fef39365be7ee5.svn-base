//
//  PickImageTipView.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/27.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "PickImageTipView.h"

@implementation PickImageTipView

- (IBAction)buttonAction:(id)sender {
    if(self.buttonClickBlock){
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        UIButton *button = (UIButton *)sender;
        [params setJsonValue:[NSString stringWithFormat:@"%d",(int)button.tag] key:@"ButtonIndex"];
        self.buttonClickBlock(params);
    }
    [self hideWithAnmation:YES];
}


- (IBAction)cancelAction:(id)sender {
    [self hideWithAnmation:YES];
}

@end
