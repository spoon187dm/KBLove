//
//  ZCZBarViewController.m
//  ZbarDemo
//
//  Created by ZhangCheng on 14-4-18.
//  Copyright (c) 2014年 ZhangCheng. All rights reserved.
//

#import "QRCodeScanViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
@interface QRCodeScanViewController ()

@end

@implementation QRCodeScanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithBlock:(void(^)(NSString*,BOOL))a{
    if (self=[super init]) {
        self.ScanResult=a;
        
    }
    
    return self;
}
-(void)createView{
    
    UIImageView*bgImageView;
    if (self.view.frame.size.height<500) {
        
        UIImage*image= [UIImage imageNamed:@"qrcode_scan_bg_Green.png"];
          bgImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, 320, self.view.frame.size.height-64-100)];
        bgImageView.contentMode=UIViewContentModeTop;
        bgImageView.clipsToBounds=YES;
      
        bgImageView.image=image;
        bgImageView.userInteractionEnabled=YES;
    }else{
        UIImage*image= [UIImage imageNamed:@"qrcode_scan_bg_Green_iphone5"];
        bgImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, 320, self.view.frame.size.height-64-100)];
        bgImageView.contentMode=UIViewContentModeTop;
        bgImageView.clipsToBounds=YES;
        
        bgImageView.image=image;
        bgImageView.userInteractionEnabled=YES;
    }
    [self.view addSubview:bgImageView];

    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 320, 320, 40)];
    label.text = @"将取景框对准二维码，即可自动扫描。";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 2;
    label.font=[UIFont systemFontOfSize:12];
    label.backgroundColor = [UIColor clearColor];
    [bgImageView addSubview:label];
    

    
    
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(50, 60, 220, 2)];
    _line.image = [UIImage imageNamed:@"qrcode_scan_light_green.png"];
    [bgImageView addSubview:_line];
   
    
    UIImageView*scanImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, bgImageView.frame.size.height+64,  320, 100)];
    scanImageView.image=[UIImage imageNamed:@"qrcode_scan_bar.png"];
    scanImageView.userInteractionEnabled=YES;
    [self.view addSubview:scanImageView];
    NSArray*unSelectImageNames=@[@"qrcode_scan_btn_flash_nor.png",@"qrcode_scan_btn_myqrcode_nor.png"];
    NSArray*selectImageNames=@[@"qrcode_scan_btn_flash_down.png",@"qrcode_scan_btn_myqrcode_down.png"];
    
    for (int i=0; i<unSelectImageNames.count; i++) {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:unSelectImageNames[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:selectImageNames[i]] forState:UIControlStateHighlighted];
        button.frame=CGRectMake(320/3*i, 0, 320/3, 100);
        [scanImageView addSubview:button];

        if (i==0) {
            [button addTarget:self action:@selector(flashLightClick) forControlEvents:UIControlEventTouchUpInside];
        }
        if (i==1) {
            button.hidden=YES;
        }
        
    }
    

    UIImageView*navImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    navImageView.image=[UIImage imageNamed:@"qrcode_scan_bar.png"];
    navImageView.userInteractionEnabled=YES;
    [self.view addSubview:navImageView];
    UILabel*titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(320/2-32,20 , 64, 44)];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.text=@"扫一扫";
    [navImageView addSubview:titleLabel];
    
    UIButton*button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"qrcode_scan_titlebar_back_pressed@2x.png"] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:@"qrcode_scan_titlebar_back_nor.png"] forState:UIControlStateNormal];

    
    [button setFrame:CGRectMake(10,10, 48, 48)];
    [button addTarget:self action:@selector(pressCancelButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

   timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(moveLine) userInfo:nil repeats:YES];
}

-(void)moveLine
{

    [UIView animateWithDuration:2 animations:^{
        
         _line.frame = CGRectMake(50, 50+250, 220, 2);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
          _line.frame = CGRectMake(50, 60, 220, 2);
        }];
    
    }];
    
}
//开启关闭闪光灯
-(void)flashLightClick{
 AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if (device.torchMode==AVCaptureTorchModeOff) {
        //闪光灯开启
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOn];
        
    }else {
        //闪光灯关闭
        
        [device setTorchMode:AVCaptureTorchModeOff];
    }

}

- (void)viewDidLoad
{
  
    //相机界面的定制在self.view上加载即可
    BOOL Custom= [UIImagePickerController
                  isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];//判断摄像头是否能用
    if (Custom) {
        [self initCapture];//启动摄像头
    }
    [self createView];
    [super viewDidLoad];
    
}
#pragma mark 点击取消
- (void)pressCancelButton:(UIButton *)button
{
    self.isScanning = NO;
    [self.captureSession stopRunning];
    
    self.ScanResult(nil,NO);
    if (timer) {
        [timer invalidate];
        timer=nil;
    }
    _line.frame = CGRectMake(50, 60, 220, 2);
    num = 0;
    upOrdown = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 开启相机
- (void)initCapture
{
    self.captureSession = [[AVCaptureSession alloc] init];
    
    AVCaptureDevice* inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *captureInput = [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:nil];
    [self.captureSession addInput:captureInput];
    
    AVCaptureVideoDataOutput *captureOutput = [[AVCaptureVideoDataOutput alloc] init];
    captureOutput.alwaysDiscardsLateVideoFrames = YES;
    
    
    if (IOS7) {
        AVCaptureMetadataOutput*_output=[[AVCaptureMetadataOutput alloc]init];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        [self.captureSession setSessionPreset:AVCaptureSessionPresetHigh];
        [self.captureSession addOutput:_output];
        _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
        
        if (!self.captureVideoPreviewLayer) {
            self.captureVideoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
#pragma mark -
#pragma mark 调整输出位置到方框
//            不会在二维码刚进入屏幕就直接解析出来
            [self.captureVideoPreviewLayer metadataOutputRectOfInterestForRect:CGRectMake(50, 100+64+60, 220, 240)];
        }
        
#pragma mark -
#pragma mark
//        AVCaptureVideoPreviewLayer * backLayer[AVCaptureVideoPreviewLayer layer];
#pragma mark -
#pragma mark frame
        self.captureVideoPreviewLayer.frame = self.view.bounds;
        self.captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        [self.view.layer addSublayer: self.captureVideoPreviewLayer];
        
        self.isScanning = YES;
        [self.captureSession startRunning];
    }

}

#pragma mark AVCaptureMetadataOutputObjectsDelegate//IOS7下触发
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count>0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        self.ScanResult(metadataObject.stringValue,YES);
    }
    
    [self.captureSession stopRunning];
    _line.frame = CGRectMake(50, 60, 220, 2);
    num = 0;
    upOrdown = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
}
+(NSString*)zhengze:(NSString*)str
{
    
    NSError *error;
    //http+:[^\\s]* 这是检测网址的正则表达式
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"http+:[^\\s]*" options:0 error:&error];//筛选
    
    if (regex != nil) {
        NSTextCheckingResult *firstMatch = [regex firstMatchInString:str options:0 range:NSMakeRange(0, [str length])];
        
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            //从urlString中截取数据
            NSString *result1 = [str substringWithRange:resultRange];
            NSLog(@"正则表达后的结果%@",result1);
            return result1;
        }
    }
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
