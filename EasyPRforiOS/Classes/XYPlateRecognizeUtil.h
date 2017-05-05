//
//  XYPlateRecognizeUtil.h
//  CarPR
//
//  Created by xiaoyu on 2016/10/27.
//  Copyright © 2016年 xiaoyu. All rights reserved.
//
#ifdef __cplusplus
#import <opencv2/opencv.hpp>
#endif

#ifdef __OBJC__
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#endif
@interface XYPlateRecognizeUtil : NSObject

-(void)recognizePateWithImage:(UIImage *)image complete:(void (^)(NSString *carString,int code))complete;

-(void)recognizePateWithMat:(cv::Mat&)mat complete:(void (^)(NSString *carString,int code))complete;
@end
