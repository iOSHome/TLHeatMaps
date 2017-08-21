//
//  UIApplication+AutomaticEvents.m
//  TLSpecterHeatMaps
//
//  Created by lichuanjun on 2017/8/21.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import "UIApplication+AutomaticEvents.h"

@implementation UIApplication (AutomaticEvents)

- (void)sp_sendEvent:(UIEvent *)event {
//    NSLog(@"====%@====",event);
    
    if (event.type==UIEventTypeTouches) {
        UITouch *touch = [event allTouches].anyObject;
        switch (touch.phase) {
            case UITouchPhaseBegan:
                NSLog(@"UITouchPhaseBegan");
                break;
            case UITouchPhaseMoved:
                NSLog(@"UITouchPhaseMoved");
                break;
            case UITouchPhaseStationary:
                NSLog(@"UITouchPhaseStationary");
                break;
            case UITouchPhaseEnded:
                NSLog(@"UITouchPhaseEnded");
                break;
            case UITouchPhaseCancelled:
                NSLog(@"UITouchPhaseCancelled");
                break;
            default:
                break;
        }
    }
}

@end
