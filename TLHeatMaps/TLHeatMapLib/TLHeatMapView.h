//
//  TLHeatMapView.h
//  TLHeatMaps
//
//  Created by lichuanjun on 2017/8/18.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TLHeatMapViewDelegate <NSObject>

@optional
- (void)heatMapFinishedLoading;

@end


@interface TLHeatMapView : UIView

- (id)initWithFrame:(CGRect)frame points:(NSArray *)points colors:(NSArray *)colors pointRadius:(CGFloat)pointRadius;

// Indexes will be used along with density of points (by normalizing first)
@property (nonatomic, strong) NSArray *colors;

// Points should be NSValues with CGPoints in them, values should range from 0 to 1 and should always be relative to the view itself
@property (nonatomic, strong) NSArray *points;

// Radius in pixels
@property (nonatomic, assign) CGFloat pointRadius;

@property (nonatomic, strong) id<TLHeatMapViewDelegate> delegate;

@end
