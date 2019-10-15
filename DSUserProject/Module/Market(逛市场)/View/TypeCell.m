//
//  TypeCell.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/21.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "TypeCell.h"

@interface TypeCell ()
@property (weak, nonatomic) IBOutlet UIButton *tagButton;

@end

@implementation TypeCell
-(void)updateWithTitle:(NSString *)title isSelect:(BOOL)isSelect{
    [self.tagButton setTitle:title forState:UIControlStateNormal];
    self.tagButton.selected = isSelect;
}


@end
