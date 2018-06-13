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
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"调用了定时器");
    }];
    
}



@end
