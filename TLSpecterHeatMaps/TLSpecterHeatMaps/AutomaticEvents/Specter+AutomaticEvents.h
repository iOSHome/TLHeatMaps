//
//  Specter+AutomaticEvents.h
//  TLSpecterHeatMaps
//
//  Created by lichuanjun on 2017/8/18.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//
#import "Specter.h"

NS_ASSUME_NONNULL_BEGIN

@interface Specter (AutomaticEvents)

+ (instancetype)sharedAutomatedInstance;
+ (void)setSharedAutomatedInstance:(Specter *)instance;

@end

NS_ASSUME_NONNULL_END
