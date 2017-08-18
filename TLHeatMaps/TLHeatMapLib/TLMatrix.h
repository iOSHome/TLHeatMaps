//
//  TLMatrix.h
//  TLHeatMaps
//
//  Created by lichuanjun on 2017/8/18.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLMatrix : NSObject

- (instancetype)initWithColumns:(NSInteger)columns lines:(NSInteger)lines;
- (instancetype)initWithColumns:(NSInteger)columns lines:(NSInteger)lines fillWith:(id)obj;

- (void)setObject:(id)object column:(NSInteger)column line:(NSInteger)line;
- (id)objectForColumn:(NSInteger)column line:(NSInteger)line;

@property (nonatomic, readonly) NSInteger lines;
@property (nonatomic, readonly) NSInteger columns;

@end
