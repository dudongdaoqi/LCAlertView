//
//  RootViewController.m
//  LCAlertView
//
//  Created by lc on 14-7-31.
//  Copyright (c) 2014年 lc. All rights reserved.
//

#import "RootViewController.h"
#import "LCAlertView.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)defaultAlertAction:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Warm" message:@"net is bad" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
    [alert show];
}

- (IBAction)blockAlert:(id)sender
{
    LCAlertView *alert = [[LCAlertView alloc]initWithTitle:@"Warm" message:@"net is bad" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];
    //alert.alertAnimationStyle = LCAlertAnimationFlipHorizontal;
    alert.alertAction = ^(NSInteger buttonIndex){
        NSLog(@"alert:%lu",buttonIndex);
    };
    [alert show];
}

- (IBAction)LCAlertAction:(id)sender
{
    LCAlertView *alert = [[LCAlertView alloc]initWithTitle:@"Warm" message:@"net is bad" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];
    alert.alertAnimationStyle = LCAlertAnimationFlipHorizontal;
    [alert show];
}

#pragma mark delegate

- (void)alertView:(LCAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"alert:%lu",buttonIndex);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
