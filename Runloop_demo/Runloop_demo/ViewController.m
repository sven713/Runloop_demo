//
//  ViewController.m
//  Runloop_demo
//
//  Created by sve on 2018/6/13.
//  Copyright © 2018年 sve. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // timer不加入Runloop 不能运行
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"调用了定时器");
    }];
    
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode]; // 只加入defaulMode在拖动UI的时候,timer不会工作了
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode]; // 只加入这个mode,在不滑动的时候,timer不工作
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes]; //  commonMode 是上面两个mode的和,这一行代码等效上面两行
}



@end
