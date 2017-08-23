//
//  TLRootViewController.m
//  TLScreenShot
//
//  Created by lichuanjun on 2017/8/22.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import "TLRootViewController.h"
#import "TLTableViewController.h"
#import "TLCollectionViewController.h"

@interface TLRootViewController ()

@end

@implementation TLRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"主页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btnTable = [[UIButton alloc] initWithFrame:CGRectMake(15, 80, 80, 30)];
    [btnTable setTitle:@"表格视图" forState:UIControlStateNormal];
    [btnTable setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnTable setBackgroundColor:[UIColor greenColor]];
    [btnTable addTarget:self action:@selector(btnTableTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnTable];
    
    UIButton *btnCollection = [[UIButton alloc] initWithFrame:CGRectMake(120, 80, 80, 30)];
    [btnCollection setTitle:@"集合视图" forState:UIControlStateNormal];
    [btnCollection setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnCollection addTarget:self action:@selector(btnCollectionTapped) forControlEvents:UIControlEventTouchUpInside];
    [btnCollection setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:btnCollection];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) btnTableTapped {
    TLTableViewController *tableVC = [[TLTableViewController alloc] init];
    [self.navigationController pushViewController:tableVC animated:YES];
}

-(void) btnCollectionTapped {
    TLCollectionViewController *collectionVC = [[TLCollectionViewController alloc] init];
    [self.navigationController pushViewController:collectionVC animated:YES];
}

@end
