//
//  main.m
//  Runloop_demo
//
//  Created by sve on 2018/6/13.
//  Copyright © 2018年 sve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSLog(@"来了");
        // 主线程的Runloop开启了,这个死循环在执行,就不会打印后面的coming
        int a = UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        NSLog(@"coming?");
        return a;
    }
}
