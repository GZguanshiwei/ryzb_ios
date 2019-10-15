//
//  ResaleSuccessTipView.m
//  JMBaseProject
//
//  Created by Liuny on 2019/7/3.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "ResaleSuccessTipView.h"

@implementation ResaleSuccessTipView


- (IBAction)infoAction:(id)sender {
    if(self.buttonClickBlock){
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setJsonValue:@"0" key:@"ButtonIndex"];
        self.buttonClickBlock(params);
    }
    [self hideView];
}

- (IBAction)shareAction:(id)sender {
    if(self.buttonClickBlock){
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setJsonValue:@"1" key:@"ButtonIndex"];
        self.buttonClickBlock(params);
    }
    [self hideView];
}

- (IBAction)cancelAction:(id)sender {
    [self hideView];
}
@end
