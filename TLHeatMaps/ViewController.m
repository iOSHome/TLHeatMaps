//
//  ViewController.m
//  TLHeatMaps
//
//  Created by lichuanjun on 2017/8/18.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import "ViewController.h"
#import "TLHeatMapView.h"

@interface ViewController ()<TLHeatMapViewDelegate>

@property (nonatomic, strong) TLHeatMapView *heatMapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *locations = [@[] mutableCopy];
    for(NSInteger index = 0; index < 10; index ++) {
        CGPoint point = CGPointMake(((float)rand() / RAND_MAX) * 1,((float)rand() / RAND_MAX) * 1);
        [locations addObject:[NSValue valueWithCGPoint:point]];
    }
    
    self.heatMapView = [[TLHeatMapView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) points:locations colors:@[[UIColor greenColor], [UIColor yellowColor], [UIColor redColor]] pointRadius:40.0f];
    self.heatMapView.delegate = self;
    self.heatMapView.alpha = 0.8f;
    [self.view addSubview:self.heatMapView];
    
    // 添加手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addPointToHeatMap:)];
    [self.heatMapView addGestureRecognizer:tapGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addPointToHeatMap:(UITapGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:sender.view];
    CGPoint relativePoint = CGPointMake(point.x / sender.view.frame.size.width, point.y / sender.view.frame.size.height);
    NSMutableArray *points = [self.heatMapView.points mutableCopy];
    [points addObject:[NSValue valueWithCGPoint:relativePoint]];
    self.heatMapView.points = points;
}

-(void)heatMapFinishedLoading {
    NSLog(@"FinishedLoadingHeatMap");
}

@end
