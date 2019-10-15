//
//  SweepViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/2/14.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "SweepViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface SweepViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *sweepLineImageView;
@property (strong, nonatomic) IBOutlet UIView *sweepView;

@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@end

@implementation SweepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self startAnimation];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    //设置有效扫描区域
    CGRect intertRect = [self.preview metadataOutputRectOfInterestForRect:self.sweepView.frame];
    self.output.rectOfInterest = intertRect;
    self.preview.frame = self.view.bounds;
}


-(void)initControl{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActiveNotification)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
}

-(void)initData{
    [[JMPermissionHelper sharedInstance] accessCamera:^(BOOL granted) {
        [self setupCamera];
    }];
}

-(void)applicationDidBecomeActiveNotification{
    [self startAnimation];
}

-(void)setupCamera{
    //获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    if (!input) {
        return;
    }
    //创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    self.output = output;
    //初始化链接对象
    self.session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [self.session addInput:input];
    [self.session addOutput:output];
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=self.view.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    self.preview = layer;
    //开始捕获
    [self.session startRunning];
}

-(void)setFlashLightOn:(BOOL)isOn{
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        // 判断是否有闪光灯
        if ([device hasTorch]) {
            // 请求独占访问硬件设备
            [device lockForConfiguration:nil];
            if(isOn == YES){
                //手电筒开
                [device setTorchMode:AVCaptureTorchModeOn];
            }else{
                //手电筒关
                [device setTorchMode:AVCaptureTorchModeOff];
            }
            // 请求解除独占访问硬件设备
            [device unlockForConfiguration];
        }
    }
}

-(void)startAnimation{
    CGFloat centerY = self.sweepLineImageView.centerY;
    CGFloat toCenterY;
    if(centerY > self.sweepView.size.height/2.0){
        toCenterY = 5;
    }else{
        toCenterY = self.sweepView.size.height-5;
    }
    
    [UIView animateWithDuration:3 animations:^{
        self.sweepLineImageView.centerY = toCenterY;
    } completion:^(BOOL finished) {
        if(finished){//必须写上，stopAnimation方法才有效
            [self startAnimation];
        }
    }];
}

-(void)stopAnimation{
    //会结束动画，使finished变量返回Null
    [self.sweepLineImageView.layer removeAllAnimations];
}

#pragma mark - UINavigation
-(BOOL)navUIBaseViewControllerIsNeedNavBar:(JMNavUIBaseViewController *)navUIBaseViewController{
    return NO;
}


#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    NSString *stringValue;
    if ([metadataObjects count] >0){
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        
        [self.session stopRunning];
        [self stopAnimation];
        NSLog(@"%@",stringValue);
        if (stringValue.length > 0) {
            if(self.finishBlock){
                self.finishBlock(stringValue);
            }
        }
    }
}


#pragma mark - Actions
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)flashLightAction:(id)sender {
    //开灯、关灯
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    [self setFlashLightOn:button.isSelected];
}


@end
