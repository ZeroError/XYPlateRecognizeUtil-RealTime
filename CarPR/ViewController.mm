//
//  ViewController.m
//  CarPR
//
//  Created by xiaoyu on 2016/10/27.
//  Copyright © 2016年 xiaoyu. All rights reserved.
//


#import "ViewController.h"
#import "UIViewController+MVSPhotoPickerManager.h"
#import "XYPlateRecognizeUtil.h"
#import "ScanViewController.h"
@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = (CGRect){0,self.view.bounds.size.height - 64,self.view.bounds.size.width,64};
    button.backgroundColor = [UIColor clearColor];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitle:@"开始" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)buttonClick{
    ScanViewController *vc = [[ScanViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    
//    [self showPhotoPickerSheetTitle:@"获取车牌" message:nil needOpenFrontCamera:NO cameraActionTitle:@"拍照" photoLibraryActionTitle:@"从相册中选取" canOpenLibrary:YES complete:^(NSArray *assetsImageArray) {
//        
//        if (!assetsImageArray || assetsImageArray.count == 0) {
//            return;
//        }
//        UIImage *assetImage = assetsImageArray.firstObject;
//        
//        UIImageView *image = [[UIImageView alloc] initWithImage:assetImage];
//        image.frame = CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height - 200);
//        [self.view addSubview:image];
//        
//        [[XYPlateRecognizeUtil new] recognizePateWithImage:assetImage complete:^(NSArray *plateStringArray,int code){
//            CGFloat y = 0;
//            for (NSString *carStr in plateStringArray) {
//                
//                UIButton *button = [[UIButton alloc] init];
//                button.frame = (CGRect){0,y,self.view.bounds.size.width,64};
//                button.backgroundColor = [UIColor clearColor];
//                [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//                [button setTitle:carStr forState:UIControlStateNormal];
//                [self.view addSubview:button];
//                y += 64;
//            }
//            NSLog(@"plateStringArray:%@",plateStringArray);
//        }];
//    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
