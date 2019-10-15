//
//  PlayVideoViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2018/12/22.
//  Copyright © 2018 liuny. All rights reserved.
//

#import "PlayVideoViewController.h"
#import <ZFPlayer.h>
#import <ZFPlayerControlView.h>
#import <ZFAVPlayerManager.h>

@interface PlayVideoViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
@end

@implementation PlayVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.player.viewControllerDisappear = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.player.viewControllerDisappear = YES;
}

-(void)initControl{
    self.view.backgroundColor = [UIColor blackColor];
}

-(void)initData{
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    self.controlView = [ZFPlayerControlView new];
    self.player = [[ZFPlayerController alloc] initWithPlayerManager:playerManager containerView:self.containerView];
    self.player.controlView = self.controlView;
    
    NSString *URLString = [self.videoUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    playerManager.assetURL = [NSURL URLWithString:URLString];
    
    [self.controlView showTitle:self.videoTitle coverURLString:self.coverImageUrl fullScreenMode:ZFFullScreenModeLandscape];
    JMWeak(self);
    self.player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
        [weakself setNeedsStatusBarAppearanceUpdate];
    };
    self.player.playerDidToEnd = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset) {
        [weakself.player.currentPlayerManager replay];
    };
}

#pragma mark - UINavigation
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.player.isFullScreen) {
        return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)prefersStatusBarHidden {
    return self.player.isStatusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.player.isFullScreen) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldAutorotate {
    return self.player.shouldAutorotate;
}

#pragma mark - Actions
- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
