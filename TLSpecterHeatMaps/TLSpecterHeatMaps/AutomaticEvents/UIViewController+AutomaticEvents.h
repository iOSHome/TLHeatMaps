//
//  UIViewController+AutomaticEvents.h
//  HelloSpecter
//
//  Created by Sam Green on 2/23/16.
//  Copyright © 2016 Specter. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (AutomaticEvents)

- (void)sp_viewWillAppear:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
