//
//  ScanViewController.m
//  CarPR
//
//  Created by 孟丰 on 2017/5/1.
//  Copyright © 2017年 xiaoyu. All rights reserved.
//

#import "ScanViewController.h"
#import "UIViewController+MVSPhotoPickerManager.h"
#import "XYPlateRecognizeUtil.h"

@interface ScanViewController ()

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title= @"扫描车牌";
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self canUserCamear]) {
        [self.view addSubview:self.previewView];
        [self setCamere];
        [self.session startRunning];
    }
    
    UILabel *fps = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 50)];
    fps.font=[UIFont systemFontOfSize:18.0f];
    fps.backgroundColor=[UIColor clearColor];
    fps.textColor=[UIColor redColor];
    fps.textAlignment=NSTextAlignmentCenter;
    // fps.transform = CGAffineTransformMakeRotation(90);
    fps.text=@"车牌号为:";
    self.textLabel = fps;
    [self.view addSubview:self.textLabel];
    [self.view bringSubviewToFront:self.textLabel];
    
    
    
}

#pragma mark - 截取视频输出流
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    
//        // 获取图片信息
//        CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
//    
//        // 转换为CIImage
//        CIImage *ciImage = [CIImage imageWithCVImageBuffer:imageBuffer];
//    
//        // 转换UIImage
//        UIImage *image = [UIImage imageWithCIImage:ciImage];
    
        UIImage *image = [self imageFromSampleBuffer:sampleBuffer];
    
    
        [[XYPlateRecognizeUtil new] recognizePateWithImage:image complete:^(NSString *carString,int code){
    
            
            switch (code) {
                case 0:
                     NSLog(@"没有识别到车牌");
                    break;
                case 1:
                    [self.textLabel performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%@",carString] waitUntilDone:NO];
                    break;
                default:
                     NSLog(@"没有识别到车牌");
                    break;
            }

//            NSLog(@"plateStringArray:%@",carString);
        }];
    
    
    
//    CVImageBufferRef imageBuffer =  CMSampleBufferGetImageBuffer(sampleBuffer);
//    CVPixelBufferLockBaseAddress(imageBuffer, 0);
//    uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer);
//    size_t width = CVPixelBufferGetWidth(imageBuffer);
//    size_t height = CVPixelBufferGetHeight(imageBuffer);
//    CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
//    Mat img=Mat((int)height,(int)width,CV_8UC4,baseAddress);
//    
//    [[XYPlateRecognizeUtil new] recognizePateWithMat:img complete:^(NSString *carString,int code){
//        
//        if (code == 1) {
//            
//            [self.textLabel performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%@",carString] waitUntilDone:NO];
//        }
//        NSLog(@"plateStringArray:%@",carString);
//    }];
    
}


// Create a UIImage from sample buffer data
- (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer
{
    // Get a CMSampleBuffer's Core Video image buffer for the media data
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    // Lock the base address of the pixel buffer
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    
    // Get the number of bytes per row for the pixel buffer
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    
    // Get the number of bytes per row for the pixel buffer
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    // Get the pixel buffer width and height
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    // Create a device-dependent RGB color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // Create a bitmap graphics context with the sample buffer data
    CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8,
                                                 bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    // Create a Quartz image from the pixel data in the bitmap graphics context
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
    // Unlock the pixel buffer
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    
    // Free up the context and color space
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    // Create an image object from the Quartz image
    //UIImage *image = [UIImage imageWithCGImage:quartzImage];
    UIImage *image = [UIImage imageWithCGImage:quartzImage scale:1.0f orientation:UIImageOrientationRight];
    
    // Release the Quartz image
    CGImageRelease(quartzImage);
    
    return (image);
}

#pragma mark - 初始化相机
- (void)setCamere {
    NSError *error = nil;
    //  初始化数据连接
    self.session = [[AVCaptureSession alloc] init];
    //UIDevice是一个单例对象，代表当前设备，可以获取设备信息，比如说分配的名字，设备型号，OS名字，版本号等
    //判断当前设备是否为iphone
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        
        [self.session setSessionPreset:AVCaptureSessionPreset640x480];
    else
        [self.session setSessionPreset:AVCaptureSessionPreset640x480];
    
    //  初始化设备
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    [_device lockForConfiguration:&error];
    
    if ([_device lockForConfiguration:&error]) {
        //设置自动对焦
        if ([_device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {
            _device.focusMode = AVCaptureFocusModeContinuousAutoFocus;
        }
        //自动白平衡
        if ([_device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance]) {
            _device.whiteBalanceMode = AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance;
        }
        [_device unlockForConfiguration];
    }
    //  初始化输入设备
    self.cameraInput = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
    if ( [self.session canAddInput:self.cameraInput] )
        [self.session addInput:self.cameraInput];
    
    self.videoDataOutput = [AVCaptureVideoDataOutput new];
    
    
    //  视频输出流设置
    NSDictionary * rgbOutputSetting = [NSDictionary dictionaryWithObject:
                                       [NSNumber numberWithInt:kCMPixelFormat_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    
    [self.videoDataOutput setVideoSettings:rgbOutputSetting];
    [self.videoDataOutput setAlwaysDiscardsLateVideoFrames:YES];
    
    //dispatch_queue_t对象， 设置AVCaptureVideoDataOutput对SampleBuffer的处理为FIFO队列方式，这样没个帧到 captureOutput:didOutputSampleBuffer:fromConnection:里面处理的时候都会按照FIFO方式，并且可以为了处理最新帧，抛弃旧的帧，保证不会错乱顺序。
    videoDataOutputQueue = dispatch_queue_create("videoDataOutputQueue", DISPATCH_QUEUE_SERIAL);
    [self.videoDataOutput setSampleBufferDelegate:self queue:videoDataOutputQueue];
    
    if ([self.session canAddOutput:self.videoDataOutput]) {
        [self.session addOutput:self.videoDataOutput];
    }
    
    //  初始化图片输出
    //AVCaptureStillImageOutput对象，AVCaptureOutput的子类，用来捕捉高质量的持续图片
    self.stillImageOutput = [[AVCapturePhotoOutput alloc] init];
    //    [self.stillImageOutput addObserver:self forKeyPath:@"capturingStillImage" options:NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)(AVCaptureStillImageIsCapturingStillImageContext)];
    
    if ([self.session canAddOutput:self.stillImageOutput]) {
        [self.session addOutput:self.stillImageOutput];
    }
    
    //  初始化预览图层
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    
    //    [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspect];
    //  预览图层的尺寸
    //    self.previewLayer.frame = CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_WIDTH );
    
    CALayer *rootLayer = [_previewView layer];
    [rootLayer setMasksToBounds:YES];
    [_previewLayer setFrame:[rootLayer bounds]];
    [rootLayer addSublayer:_previewLayer];
    
bail:
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Failed with error %d", (int)[error code]]
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Dismiss"
                                                  otherButtonTitles:nil];
        [alertView show];
        //        [self teardownAVCapture];
    }
    
}


#pragma mark - 检查相机权限
- (BOOL)canUserCamear{
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusDenied) {
        return NO;
    }
    else{
        return YES;
    }
    return YES;
}

- (UIView *)previewView {
    if (!_previewView) {
        _previewView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height - 100)];
    }
    return _previewView;
}



// clean up capture setup
- (void)dealloc
{
    [self.session stopRunning];
    [self.previewLayer removeFromSuperlayer];
    
}

@end
