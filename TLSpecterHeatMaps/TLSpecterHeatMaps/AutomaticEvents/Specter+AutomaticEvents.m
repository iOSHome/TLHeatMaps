//
//  Specter+AutomaticEvents.m
//  TLSpecterHeatMaps
//
//  Created by lichuanjun on 2017/8/18.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import "Specter+AutomaticEvents.h"
#import "UIViewController+AutomaticEvents.h"
#import "UIView+AutomaticEvents.h"
#import "UIApplication+AutomaticEvents.h"

#import "SPSwizzle.h"


@implementation Specter (AutomaticEvents)

static Specter *gSharedAutomatedInstance = nil;
+ (instancetype)sharedAutomatedInstance {
    return gSharedAutomatedInstance;
}

+ (void)setSharedAutomatedInstance:(Specter *)instance {
    gSharedAutomatedInstance = instance;
    [self addSwizzles];
}

+ (void)addSwizzles {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSError *error = NULL;
        
        sp_sendEvent:
        
        // Actions & Events
        [UIApplication sp_swizzleMethod:@selector(sendEvent:)
                             withMethod:@selector(sp_sendEvent:)
                                  error:&error];
        if (error) {
            NSLog(@"Failed to swizzle sendEvent: on UIAppplication. Details: %@", error);
            error = NULL;
        }
        
        // UIViewController
        [UIViewController sp_swizzleMethod:@selector(viewWillAppear:)
                                withMethod:@selector(sp_viewWillAppear:)
                                     error:&error];
        if (error) {
            NSLog(@"Failed to swizzle viewWillAppear: on UIViewController. Details: %@", error);
            error = NULL;
        }
        
        // UIView
        [UIView sp_swizzleMethod:@selector(touchesBegan:withEvent:)
                        withMethod:@selector(sp_touchesBegan:withEvent:)
                            error:&error];
        if (error) {
            NSLog(@"Failed to swizzle touchesBegan:withEvent: on UIView. Details: %@", error);
            error = NULL;
        }

        // UIWindow
//        [UIWindow sp_swizzleMethod:@selector(hitTest:withEvent:)
//                        withMethod:@selector(sp_hitTest:withEvent:)
//                             error:&error];
//        if (error) {
//            NSLog(@"Failed to swizzle hitTest:withEvent: on UIWindow. Details: %@", error);
//            error = NULL;
//        }
        
    });
}

@end

