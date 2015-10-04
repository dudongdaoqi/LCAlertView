//
//  LCViewController.m
//  LCAlertView
//
//  Created by xulicheng on 09/01/2015.
//  Copyright (c) 2015 xulicheng. All rights reserved.
//

#import "LCViewController.h"
#import "LCAlertView.h"

@interface LCViewController ()

@end

@implementation LCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    LCAlertView *alert1 = [[LCAlertView alloc]initWithTitle:@"提示" message:@"发现新版本,请更新!"  delegate:self cancelButtonTitle:@"更新" otherButtonTitles:nil, nil];
    [alert1 show];
    
    LCAlertView *alert = [[LCAlertView alloc]initWithImage:@"watch_bind" closeImage:@"confirm_delete" delegate:self];
    alert.imageAction = ^{
        NSLog(@"image tap");
    };
    alert.alertAction = ^(NSInteger buttonIndex){
        NSLog(@"close tap");
    };
    [alert show];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
