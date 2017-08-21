//
//  SpecterPrivate.h
//  Specter
//
//  Created by Sam Green on 6/16/16.
//  Copyright © 2016 Specter. All rights reserved.
//

#import "Specter.h"
#import "Specter+AutomaticEvents.h"

@interface Specter ()
{
    NSUInteger _flushInterval;
}

@property (nonatomic, copy) NSString *apiToken;

@end

