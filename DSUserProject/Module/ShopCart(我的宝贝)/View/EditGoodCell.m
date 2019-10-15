//
//  EditGoodCell.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/21.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "EditGoodCell.h"

@implementation EditGoodCell

-(void)awakeFromNib{
    [super awakeFromNib];
    [self initControl];
}

-(void)initControl{
    self.imageView.layer.cornerRadius = 5.0;
    self.imageView.layer.masksToBounds = YES;
}

#pragma mark - Actions
- (IBAction)deleteAction:(id)sender {
    if(self.deleteBlock){
        self.deleteBlock();
    }
}

@end
