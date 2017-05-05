//
//  ScanViewController.h
//  CarPR
//
//  Created by 孟丰 on 2017/5/1.
//  Copyright © 2017年 xiaoyu. All rights reserved.
//


#ifdef __cplusplus
#import <opencv2/opencv.hpp>
#endif

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreImage/CoreImage.h>
#import <ImageIO/ImageIO.h>
#import <AssertMacros.h>
//#include "easypr.h"
//#include "switch.hpp"
//#include "GlobalData.hpp"
#include "plate.hpp"
#endif
@interface ScanViewController : UIViewController<AVCaptureVideoDataOutputSampleBufferDelegate>{
    dispatch_queue_t videoDataOutputQueue;
    dispatch_queue_t Queue;
}

//捕获设备，通常是前置摄像头，后置摄像头，麦克风（音频输入）
@property(nonatomic)AVCaptureDevice *device;

/**
 *  AVCaptureSession对象来执行输入设备和输出设备之间的数据传递
 */
@property (nonatomic, strong) AVCaptureSession* session;
/**
 *  输入设备
 */
@property (nonatomic, strong) AVCaptureDeviceInput* cameraInput;
/**
 *  照片输出流
 */
@property (nonatomic, strong) AVCapturePhotoOutput* stillImageOutput;
/**
 *  预览图层
 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer* previewLayer;
/**
 *  视频预览图层
 */
@property (nonatomic, strong) AVCaptureVideoDataOutput *videoDataOutput;

@property (nonatomic, strong) UIView *previewView;

@property (nonatomic, retain) UILabel *textLabel;

@end
