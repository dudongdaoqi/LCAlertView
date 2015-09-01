//
//  LCAlertView.h
//  LCLoadingView
//
//  Created by miracles3 on 14-2-28.
//  Copyright (c) 2014年 lc. All rights reserved.
//

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

typedef void(^ImageAction)(void);

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
@property (nonatomic, strong) ImageAction imageAction;

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id/*<LCAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
// shows popup alert animated.
- (void)show;


- (id)initWithImage:(NSString *)image closeImage:(NSString *)closeImage delegate:(id /*<UIAlertViewDelegate>*/)delegate;


@end//like the systemic alerview, don't advise that the number of "otherButtonTitles" is more than 3


@interface UIImage (colorful)
//a image using a color
+ (UIImage *)imageWithColor:(UIColor *)color;

@end