//
//  UIView+AutomaticEvents.h
//  TLSpecterHeatMaps
//
//  Created by lichuanjun on 2017/8/18.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AutomaticEvents)

-(void)sp_touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

@end
