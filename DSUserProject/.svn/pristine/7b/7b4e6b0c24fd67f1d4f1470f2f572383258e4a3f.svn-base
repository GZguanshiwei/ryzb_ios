//
//  DailyTasksCell.m
//  JMBaseProject
//
//  Created by 抽筋的灯 on 2019/9/17.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "DailyTasksCell.h"

@interface DailyTasksCell ()
@property (strong, nonatomic) IBOutlet UIImageView *coverImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *valueLabel;
@property (strong, nonatomic) IBOutlet UIButton *completeButton;

@end

@implementation DailyTasksCell

- (void)setCellData:(DailyTasksModel *)cellData {
    _cellData = cellData;
    [self.coverImageView sd_setImageWithURL:[JMCommonMethod imageUrlWithPath:cellData.coverUrl]];
    self.titleLabel.text = cellData.name;
    self.valueLabel.text = [NSString stringWithFormat:@"+%@分",cellData.value];
    
    if (JMIsEmpty(cellData.completed)) {
        [self.completeButton setTitle:@"去完成" forState:UIControlStateNormal];
        self.completeButton.enabled = YES;
    }else {
        [self.completeButton setTitle:@"已完成" forState:UIControlStateNormal];
        self.completeButton.enabled = NO;
    }
}

#pragma mark - Action
/**
 去完成按钮点击事件
 */
- (IBAction)completeButtonAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(completeButtondDid:)]) {
        [self.delegate completeButtondDid:self.index];
    }
}

@end
