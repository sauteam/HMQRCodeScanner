//
//  HMScannerBorder.m
//  HMQRCodeScanner
//
//  Created by 刘凡 on 16/1/2.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMScannerBorder.h"

@implementation HMScannerBorder {
    /// 冲击波图像
    UIImageView *scannerLine;
    /// 图片文件数组
    NSArray *fileNames;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
    }
    return self;
}

#pragma mark - 扫描动画方法
/// 开始扫描动画
- (void)startScannerAnimating {
    
    [self stopScannerAnimating];
    
    [UIView animateWithDuration:3.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [UIView setAnimationRepeatCount:MAXFLOAT];
                         
                         scannerLine.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height);
                     } completion:nil];
}

/// 停止扫描动画
- (void)stopScannerAnimating {
    [scannerLine.layer removeAllAnimations];
    scannerLine.center = CGPointMake(self.bounds.size.width * 0.5, 0);
}

#pragma mark - 设置界面
- (void)prepareUI {
    self.clipsToBounds = YES;
    
    fileNames = [[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:@"HMScanner.bundle"];
    // 冲击波图像
    scannerLine = [[UIImageView alloc] initWithImage:[self imageWithName:@"QRCodeScanLine"]];
    scannerLine.frame = CGRectMake(0, 0, self.bounds.size.width, scannerLine.bounds.size.height);
    scannerLine.center = CGPointMake(self.bounds.size.width * 0.5, 0);
    
    for (NSInteger i = 1; i < 5; i++) {
        NSString *imgName = [NSString stringWithFormat:@"ScanQR%zd", i];
        UIImageView *img = [[UIImageView alloc] initWithImage:[self imageWithName:imgName]];
        
        [self addSubview:img];
        
        switch (i) {
            case 2:
                img.frame = CGRectOffset(img.frame,
                                         self.bounds.size.width - img.bounds.size.width,
                                         0);
                break;
            case 3:
                img.frame = CGRectOffset(img.frame,
                                         0,
                                         self.bounds.size.height - img.bounds.size.height);
                break;
            case 4:
                img.frame = CGRectOffset(img.frame,
                                         self.bounds.size.width - img.bounds.size.width,
                                         self.bounds.size.height - img.bounds.size.height);
                break;
            default:
                break;
        }
    }
    
    [self addSubview:scannerLine];
}

- (UIImage *)imageWithName:(NSString *)imageName {
    NSArray *result = [fileNames filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self CONTAINS %@", imageName]];
    
    return [UIImage imageWithContentsOfFile:result.lastObject];
}

@end