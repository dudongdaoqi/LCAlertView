LCAlertView
=========
LCAlertview like the system alertview

1. uses for iphone and ipad
2. it can rotate with the screen
3. like the system alertview, use easy

This alert provides a alertview like system using ARC model.

How To Use
----------

#import "LCAlertView.h"

LCAlertView *alert = [[LCAlertView alloc]initWithTitle:@"hello" message:@"are you ready" delegate:self cancelButtonTitle:@"cancle" otherButtonTitles:@"sure",nil];
[alert show]; 

#pragma mark delegate

- (void)alertView:(LCAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"alert:%lu",buttonIndex);
}