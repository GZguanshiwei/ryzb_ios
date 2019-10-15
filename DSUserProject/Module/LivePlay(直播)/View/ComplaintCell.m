//
//  ComplaintCell.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/17.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "ComplaintCell.h"

@interface ComplaintCell ()
@property (weak, nonatomic) IBOutlet UIButton *selectFlagButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation ComplaintCell
-(void)updateWithTitle:(NSString *)title isSelect:(BOOL)isSelect{
    self.titleLabel.text = title;
    self.selectFlagButton.selected = isSelect;
}
@end
