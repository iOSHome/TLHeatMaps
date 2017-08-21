//
//  UIWindow+AutomaticEvents.m
//  TLSpecterHeatMaps
//
//  Created by lichuanjun on 2017/8/18.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import "UIWindow+AutomaticEvents.h"

@implementation UIWindow (AutomaticEvents)

- (UIView *)sp_hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (![self shouldTouchsClass:self.class]) {
        return self;
    }
    // 1.判断下窗口能否接收事件
    if (self.userInteractionEnabled == NO || self.hidden == YES ||  self.alpha <= 0.01) return nil;
    // 2.判断下点在不在窗口上
    // 不在窗口上
    if ([self pointInside:point withEvent:event] == NO) return nil;
    // 3.从后往前遍历子控件数组
    int count = (int)self.subviews.count;
    for (int i = count - 1; i >= 0; i--)     {
        // 获取子控件
        UIView *childView = self.subviews[i];
        // 坐标系的转换,把窗口上的点转换为子控件上的点
        // 把自己控件上的点转换成子控件上的点
        CGPoint childP = [self convertPoint:point toView:childView];
        UIView *fitView = [childView hitTest:childP withEvent:event];
        if (fitView) {
            // 如果能找到最合适的view
//            NSLog(@"22222sp_hitTest: %@ - %@ - x:%f, y:%f",fitView, event, point.x, point.y);
            return fitView;
        }
    }
//    for (UIView *subview in [self.subviews reverseObjectEnumerator]) {
//        CGPoint convertedPoint = [subview convertPoint:point fromView:self];
//        UIView *hitTestView = [subview hitTest:convertedPoint withEvent:event];
//        if (hitTestView) {
//            if ([self shouldTouchsClass:self.class]) {
////                NSLog(@"22222sp_hitTest: %@ - %@ - x:%f, y:%f",hitTestView, event, point.x, point.y);
//            }
//
//            return hitTestView;
//        }
//    }

    // 4.没有找到更合适的view，也就是没有比自己更合适的view
    return self;
    
//    if ([self isKeyWindow]) {
//        if ([self shouldTouchsClass:self.class]) {
//            NSLog(@"sp_hitTest: %@ - %@ - x:%f, y:%f",self, event, point.x, point.y);
//        }
//    }
//    
//    return [self sp_hitTest:point withEvent:event];
}

//-(void)sp_touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
//    UITouch * touch = touches.anyObject;
//    CGPoint location = [touch locationInView:window];
//    NSLog(@"UIWindow: %@",NSStringFromCGPoint(location));
//}

- (BOOL)shouldTouchsClass:(Class)aClass {
    static NSSet *blacklistedClasses = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *blacklistedClassNames = @[ @"UITextEffectsWindow",
                                            @"UIStatusBarWindow",
                                            @"UIRemoteKeyboardWindow"];
        NSMutableSet *transformedClasses = [NSMutableSet setWithCapacity:blacklistedClassNames.count];
        for (NSString *className in blacklistedClassNames) {
            if (NSClassFromString(className)) {
                [transformedClasses addObject:NSClassFromString(className)];
            }
        }
        blacklistedClasses = [transformedClasses copy];
    });
    
    return ![blacklistedClasses containsObject:aClass];
}

@end
