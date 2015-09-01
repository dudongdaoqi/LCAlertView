# LCAlertView

[![CI Status](http://img.shields.io/travis/xulicheng/LCAlertView.svg?style=flat)](https://travis-ci.org/xulicheng/LCAlertView)
[![Version](https://img.shields.io/cocoapods/v/LCAlertView.svg?style=flat)](http://cocoapods.org/pods/LCAlertView)
[![License](https://img.shields.io/cocoapods/l/LCAlertView.svg?style=flat)](http://cocoapods.org/pods/LCAlertView)
[![Platform](https://img.shields.io/cocoapods/p/LCAlertView.svg?style=flat)](http://cocoapods.org/pods/LCAlertView)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

LCAlertView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "LCAlertView"
```


LCAlertView
=========
LCAlertview like the system alertview

1. uses for iphone and ipad
2. it can rotate with the screen
3. like the system alertview, use easy
4. you can use block style in 2.0
5. three kinds of animation mode:Default/FlipHorizontal/FlipVertical

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
```

### Using blocks

```objective-c

LCAlertView *alert = [[LCAlertView alloc]initWithTitle:@"提示" message:@"网路不稳定" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
alert.alertAction = ^(NSInteger buttonIndex){
NSLog(@"alert:%lu",buttonIndex);
};
[alert show];
```

### Animation Mode

```objective-c

typedef NS_ENUM(NSInteger, LCAlertAnimation) {
LCAlertAnimationDefault = 0,
LCAlertAnimationFlipHorizontal,
LCAlertAnimationFlipVertical,
};

alert.alertAnimationStyle = LCAlertAnimationFlipHorizontal;

```

### Alert Image


```objective-c

LCAlertView *alert = [[LCAlertView alloc]initWithImage:@"watch_bind" closeImage:@"confirm_delete" delegate:self];
alert.imageAction = ^{
NSLog(@"image tap");
};
alert.alertAction = ^(NSInteger buttonIndex){
NSLog(@"close tap");
};
[alert show];

```

