//
//  ViewController.m
//  Runloop_demo
//
//  Created by sve on 2018/6/13.
//  Copyright © 2018年 sve. All rights reserved.
//

#import "ViewController.h"
#import "SVThread.h"

@interface ViewController ()
@property (nonatomic, assign) BOOL finished; //!<是否退出time
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.finished = NO;
    
    NSThread *thread = [[SVThread alloc]initWithBlock:^{ // 创建子线程
        
        [[NSRunLoop currentRunLoop] run]; // 这样就是常驻线程 子线程,开启Runloop
        
        while (!self.finished) {
            // 必须启动runloop
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0]]; // 直接[[NSRunLoop currentRunLoop] run]就不好退出了
        }
    }];
    [thread start];
    // 线程间通信 如果线程死了,是不会调用doSomething的
    [self performSelector:@selector(doSomething) onThread:thread withObject:nil waitUntilDone:NO];
    
}


- (void)doSomething {
    NSLog(@"线程间通信,dosomething-%@",[NSThread currentThread]);
}


// 如何退出后台线程 exit
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.finished = YES;
}


- (void)demo1 {
    // timer不加入Runloop 不能运行
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"调用了定时器--%@",[NSThread currentThread]);
    }];
    
    //    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode]; // 只加入defaulMode在拖动UI的时候,timer不会工作了
    //    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode]; // 只加入这个mode,在不滑动的时候,timer不工作
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes]; //  commonMode 是上面两个mode的和,这一行代码等效上面两行
}


- (void)demo2 {
    // timer不加入Runloop 不能运行
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (self.finished) {
            [NSThread exit];
        }
        [NSThread sleepForTimeInterval:1]; // 耗时操作,在主线程会卡顿
        NSLog(@"调用了定时器--%@",[NSThread currentThread]);
    }];
}

@end
