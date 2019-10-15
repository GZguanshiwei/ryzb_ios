//
//  TypeView.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/26.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "TypeView.h"

@implementation TypeView

#pragma mark - Actions

- (IBAction)typeActions:(id)sender {
    if(self.buttonClickBlock){
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        UIButton *button = (UIButton *)sender;
        [params setJsonValue:[NSString stringWithFormat:@"%d",(int)button.tag] key:@"ButtonIndex"];
        self.buttonClickBlock(params);
    }
    [self hideWithAnmation:YES];
}

@end
