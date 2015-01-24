//
//  LCAlertView.h
//
//  Created by miracles3 on 14-2-28.
//  Copyright (c) 2014年 LC All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, LCAlertAnimation) {
    LCAlertAnimationDefault = 0,
    LCAlertAnimationFlipHorizontal,
	LCAlertAnimationFlipVertical,
};


/**
 *  block way for back action
 */

typedef void(^AlertAction)(NSInteger buttonIndex);


/**
 *  delegate way for back action
 */

@class LCAlertView;
@protocol  LCAlertViewDelegate <NSObject>
// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(LCAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface LCAlertView : UIView
{
    UIWindow *_originalWindow;
    UIView *_backgroundView;
    UILabel *_alertTitleLabel;
    UILabel *_alertContentLabel;
    NSMutableArray *_buttons;
    NSInteger _allBtnNum;
    UIButton *_oneBtn;
    UIButton *_rightBtn;
    UIButton *_leftBtn;
}

@property(nonatomic,assign) id<LCAlertViewDelegate> delegate;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *message;   // secondary explanation text
@property(nonatomic,assign) LCAlertAnimation alertAnimationStyle;
@property (nonatomic, strong) AlertAction alertAction;

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id/*<LCAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
// shows popup alert animated.
- (void)show;
@end//like the systemic alerview, don't advise that the number of "otherButtonTitles" is more than 3


@interface UIImage (colorful)
//a image using a color
+ (UIImage *)imageWithColor:(UIColor *)color;

@end