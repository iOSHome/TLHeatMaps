//
//  UIWindow+AutomaticEvents.h
//  TLSpecterHeatMaps
//
//  Created by lichuanjun on 2017/8/18.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (AutomaticEvents)

//-(void)sp_touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
- (UIView *)sp_hitTest:(CGPoint)point withEvent:(UIEvent *)event;

@end
