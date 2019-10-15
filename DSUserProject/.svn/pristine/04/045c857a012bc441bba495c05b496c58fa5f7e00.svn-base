//
//  SmallPlayView.m
//  JMBaseProject
//
//  Created by Liuny on 2019/9/19.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "LiveSmallPlayView.h"

@interface LiveSmallPlayView ()
@property (weak, nonatomic) IBOutlet UIView *playView;

@end

@implementation LiveSmallPlayView

-(instancetype)initWithXib{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    self = nibView.firstObject;
    if(self){
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)tapAction{
    [[JMProjectManager sharedJMProjectManager] liveLargePlay:self.roomId];
}

-(void)setVideoView:(UIView *)videoView{
    _videoView = videoView;
    [self insertSubview:_videoView atIndex:0];
    [_videoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (IBAction)closeAction:(id)sender {
    [[JMProjectManager sharedJMProjectManager] exitRoom:self.roomId];
}

@end
