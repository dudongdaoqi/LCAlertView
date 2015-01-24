LCAlertView
=========
LCAlertview like the system alertview

1. uses for iphone and ipad
2. it can rotate with the screen
3. like the system alertview, use easy

This alert provides a alertview like system using ARC model.

Release
----------
[1.0](https://github.com/dudongdaoqi/LCAlertView/tree/1.0) ios4.3 MRC

[2.0](https://github.com/dudongdaoqi/LCAlertView/releases/tag/v2.0) ios5.0 ARC

How To Use
----------

```objective-c

#import "LCAlertView.h"

LCAlertView *alert = [[LCAlertView alloc]initWithTitle:@"hello" message:@"are you ready" delegate:self cancelButtonTitle:@"cancle" otherButtonTitles:@"sure",nil];
[alert show]; 

#pragma mark delegate

- (void)alertView:(LCAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"alert:%lu",buttonIndex);
}