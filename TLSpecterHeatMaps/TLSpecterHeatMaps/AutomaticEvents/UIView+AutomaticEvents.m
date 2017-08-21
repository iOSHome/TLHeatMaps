//
//  UIView+AutomaticEvents.m
//  TLSpecterHeatMaps
//
//  Created by lichuanjun on 2017/8/18.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import "UIView+AutomaticEvents.h"
#import "Specter+AutomaticEvents.h"
#import <objc/runtime.h>

@implementation UIView (AutomaticEvents)

-(void)sp_touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];   
    UITouch * touch = touches.anyObject;
    CGPoint location = [touch locationInView:window];
//    NSLog(@"UIView: %@",NSStringFromCGPoint(location));
}

@end
