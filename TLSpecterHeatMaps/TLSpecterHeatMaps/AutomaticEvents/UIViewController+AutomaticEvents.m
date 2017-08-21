//
//  UIViewController+AutomaticEvents.m
//  HelloSpecter
//
//  Created by Sam Green on 2/23/16.
//  Copyright © 2016 Specter. All rights reserved.
//

#import "UIViewController+AutomaticEvents.h"
#import "Specter+AutomaticEvents.h"
#import <objc/runtime.h>

@implementation UIViewController (AutomaticEvents)

-(void)sp_viewWillAppear:(BOOL)animated {
    NSLog(@"sp_viewWillAppear");
}

@end
