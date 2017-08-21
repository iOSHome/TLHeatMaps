//
//  TLTestViewController.m
//  TLSpecterHeatMaps
//
//  Created by lichuanjun on 2017/8/18.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import "TLTestViewController.h"
#import "TLTouchZoneButton.h"

@interface TLTestViewController ()

@end

@implementation TLTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    lblTitle.text = @"测试1";
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.userInteractionEnabled = YES;
    
    self.navigationItem.titleView = lblTitle;
    self.navigationItem.titleView.backgroundColor = [UIColor brownColor];
    
//    self.title = @"Test";
    
    
    TLTouchZoneButton *btn = [[TLTouchZoneButton alloc] initWithFrame:CGRectMake(20, 100, 10, 10)];
    [btn setBackgroundColor:[UIColor lightGrayColor]];
    [btn setImage:[UIImage imageNamed:@"rules256.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(testClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)testClick {
    NSLog(@"testClick");
}

@end
