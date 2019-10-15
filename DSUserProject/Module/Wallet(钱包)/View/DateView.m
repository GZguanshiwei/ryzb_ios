//
//  DateView.m
//  JMBaseProject
//
//  Created by Liuny on 2019/6/26.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "DateView.h"

@interface DateView ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation DateView

-(void)initControl{
    [super initControl];
    self.datePicker.maximumDate = [NSDate date];
}

#pragma mark - Actions
- (IBAction)okAction:(id)sender {
    if(self.buttonClickBlock){
        NSDate *date = self.datePicker.date;
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:date forKey:@"Date"];
        self.buttonClickBlock(params);
    }
    [self hideWithAnmation:YES];
}

- (IBAction)cancelAction:(id)sender {
    [self hideWithAnmation:YES];
}
@end
