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
    
    // timer不加入Runloop 不能运行
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (self.finished) {
            [NSThread exit];
        }
        [NSThread sleepForTimeInterval:1]; // 耗时操作,在主线程会卡顿
        NSLog(@"调用了定时器--%@",[NSThread currentThread]);
    }];
    
    
    NSThread *thread = [[SVThread alloc]initWithBlock:^{ // 创建子线程
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes]; // 在Runloop中添加timer监听事件
        
        [[NSRunLoop currentRunLoop] run]; // 开启运行循环否则不会执行 在子线程开启运行循环,后台开启常驻线程
        
//        while (true) { // 利用死循环, 子线程的任务一直没执行完毕,线程不会销毁,thread就不会被销毁,线程的生命只跟任务有关系
//
//        }
    }];
    [thread start];
}

// 如何退出后台线程 exit
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    self.finished = YES;
    [NSThread exit];
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


@end
