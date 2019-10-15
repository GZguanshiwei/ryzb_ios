//
//  EvalutionItemCell.m
//  JMBaseProject
//
//  Created by Liuny on 2018/12/27.
//  Copyright © 2018 liuny. All rights reserved.
//

#import "EvalutionItemCell.h"

@implementation EvalutionItemCell
-(void)awakeFromNib{
    [super awakeFromNib];
    self.pictureImageView.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
    self.pictureImageView.contentMode = UIViewContentModeScaleAspectFill;
}
@end
