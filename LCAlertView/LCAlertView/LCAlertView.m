//
//  LCAlertView.m
//  LCLoadingView
//
//  Created by miracles3 on 14-2-28.
//  Copyright (c) 2014年 lc. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>
#import "LCAlertView.h"

#define kAlertWidth 265.0f
#define kAlertHeight 160.0f
#define kTitleYOffset 15.0f
#define kTitleHeight 25.0f
#define kContentOffset 30.0f
#define kBetweenLabelOffset 20.0f
#define kSingleButtonWidth 245.0f
#define kCoupleButtonWidth 107.0f
#define kButtonHeight 40.0f
#define kButtonBottomOffset 10.0f
#define kButtonOffset 5.0f

#define kCancleColor [UIColor colorWithRed:87.0/255.0 green:135.0/255.0 blue:173.0/255.0 alpha:1]
#define kSureColor [UIColor colorWithRed:227.0/255.0 green:100.0/255.0 blue:83.0/255.0 alpha:1]

@interface UIImage (Colorful)

//a image using a color
+ (UIImage *)imageWithColor:(UIColor *)color;

@end

@interface UIButton (newbutton)

//creat one button
+ (UIButton *)creatOneBtn:(NSString *)title color:(UIColor *)color frame:(CGRect)frame action:(SEL)action target:(id)target;

@end


@interface LCAlertView()

- (void)rotate:(UIInterfaceOrientation) orientation;
- (void)defaultStyle;
- (void)defaultHideView;
- (void)flipVertical;
- (void)flipHorizontal;
- (void)hideMySelf;

@end

@implementation LCAlertView

@synthesize delegate = _delegate;
@synthesize title = _title;
@synthesize message = _message;
@synthesize alertAnimationStyle = _alertAnimationStyle;
@synthesize alertAction = _alertAction;

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id /*<UIAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
    if(self = [super init]){
        self.layer.cornerRadius = 5.0;
        self.backgroundColor = [UIColor whiteColor];
        _delegate = delegate;
        self.message = message;
        self.title = title;
        _alertAnimationStyle = LCAlertAnimationDefault;
        
        _alertTitleLabel = [[UILabel alloc] init];
        _alertTitleLabel.backgroundColor = [UIColor clearColor];
        _alertTitleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
        _alertTitleLabel.textColor = [UIColor colorWithRed:56.0/255.0 green:64.0/255.0 blue:71.0/255.0 alpha:1];
        _alertTitleLabel.textAlignment = NSTextAlignmentCenter;
        _alertTitleLabel.text = self.title;
        [self addSubview:_alertTitleLabel];
        
        _alertContentLabel = [[UILabel alloc] init];
        _alertContentLabel.backgroundColor = [UIColor clearColor];
        _alertContentLabel.numberOfLines = 0;
        _alertContentLabel.textAlignment = NSTextAlignmentCenter;
        _alertContentLabel.textColor = [UIColor colorWithRed:127.0/255.0 green:127.0/255.0 blue:127.0/255.0 alpha:1];
        _alertContentLabel.font = [UIFont systemFontOfSize:15.0f];
        _alertContentLabel.text = self.message;
        [self addSubview:_alertContentLabel];
        
        _buttons = [[NSMutableArray alloc]init];
        
        NSMutableArray *otherBtns = [[NSMutableArray alloc]init];
        if(otherButtonTitles)
        {
            [otherBtns addObject:otherButtonTitles];
            va_list list;
            va_start(list,otherButtonTitles);
            while(1)
            {
               NSString *eachButton = va_arg(list, id);
                if(!eachButton)
                {
                    break;
                }
            [otherBtns addObject:eachButton];
            }
            va_end(list);
        }
        
        _allBtnNum = 0;
        if(cancelButtonTitle){
            _allBtnNum +=1;
        }
        _allBtnNum += otherBtns.count;
        
        switch(_allBtnNum)
        {
            case 0:
            {
                break;
            }
            case 1:
            {
                _oneBtn = [UIButton creatOneBtn:cancelButtonTitle?cancelButtonTitle:otherButtonTitles color:kSureColor frame:CGRectZero action:@selector(buttonClick:) target:self];
                _oneBtn.tag = 0;
                [self addSubview:_oneBtn];
                break;
            }
            case 2:
            {
                _rightBtn = [UIButton creatOneBtn:cancelButtonTitle color:kSureColor frame:CGRectZero action:@selector(buttonClick:) target:self];
                _rightBtn.tag = 0;
                _leftBtn = [UIButton creatOneBtn:otherButtonTitles color:kCancleColor frame:CGRectZero action:@selector(buttonClick:) target:self];
                _leftBtn.tag = 1;
                [self addSubview:_rightBtn];
                [self addSubview:_leftBtn];
                break;
            }
            default:
            {
                for(int i = 0; i < otherBtns.count; i++){
                    UIButton *btn = [UIButton creatOneBtn:[otherBtns objectAtIndex:i] color:kSureColor frame:CGRectZero action:@selector(buttonClick:) target:self];
                    btn.tag = i+1;
                    [self addSubview:btn];
                    [_buttons addObject:btn];
                }
                
                UIButton *cancleBtn = [UIButton creatOneBtn:cancelButtonTitle?cancelButtonTitle:otherButtonTitles color:kCancleColor frame:CGRectZero action:@selector(buttonClick:) target:self];
                cancleBtn.tag = 0;
                [_buttons addObject:cancleBtn];
                [self addSubview:cancleBtn];
                
                break;
            }
        }

        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:)
                                                     name:UIDeviceOrientationDidChangeNotification object:nil];
    }
    return self;
}



- (void)orientationChanged:(NSNotification *)notification
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:[UIApplication sharedApplication].statusBarOrientationAnimationDuration delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            UIInterfaceOrientation orientation = [[UIApplication sharedApplication]statusBarOrientation];
            [self rotate:orientation];
        } completion:^(BOOL finished) {
        }];
    });
}

- (void)rotate:(UIInterfaceOrientation) orientation
{
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        CGAffineTransform rotation = CGAffineTransformMakeRotation(3*M_PI/2);
        [self setTransform:rotation];
    }else if (orientation == UIInterfaceOrientationLandscapeRight) {
        CGAffineTransform rotation = CGAffineTransformMakeRotation(M_PI/2);
        [self setTransform:rotation];
    }else if (orientation == UIInterfaceOrientationPortrait) {
        CGAffineTransform rotation = CGAffineTransformMakeRotation(0);
        [self setTransform:rotation];
    } else if (orientation == UIDeviceOrientationPortraitUpsideDown) {
        CGAffineTransform rotation = CGAffineTransformMakeRotation(M_PI);
        [self setTransform:rotation];
    }
}


- (void)roate:(UIInterfaceOrientation)orientation sacle:(float)num
{
    CGAffineTransform rotationTransform;
    
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        
         rotationTransform = CGAffineTransformMakeRotation(3*M_PI/2);
  
    }else if (orientation == UIInterfaceOrientationLandscapeRight) {
        
        rotationTransform = CGAffineTransformMakeRotation(M_PI/2);

    }else if (orientation == UIInterfaceOrientationPortrait) {
        
        rotationTransform = CGAffineTransformMakeRotation(0);

    } else if (orientation == UIDeviceOrientationPortraitUpsideDown) {
        
        rotationTransform = CGAffineTransformMakeRotation(-M_PI);

    }
    
    CGAffineTransform scaleTransform = CGAffineTransformScale(CGAffineTransformIdentity,num,num);
    
    self.transform = CGAffineTransformConcat(scaleTransform,rotationTransform);
}



- (void)setupFrame
{
    switch(_allBtnNum)
    {
        case 0:
        {
            break;
        }
        case 1:
        {
            self.frame = CGRectMake((CGRectGetWidth([UIScreen mainScreen].bounds) - kAlertWidth) * 0.5, 0, kAlertWidth, kAlertHeight);
            _oneBtn.frame =  CGRectMake((kAlertWidth - kSingleButtonWidth) * 0.5, kAlertHeight - kButtonBottomOffset - kButtonHeight, kSingleButtonWidth, kButtonHeight);

            break;
        }
        case 2:
        {
            self.frame = CGRectMake((CGRectGetWidth([UIScreen mainScreen].bounds) - kAlertWidth) * 0.5, 0, kAlertWidth, kAlertHeight);
            _leftBtn.frame = CGRectMake((kAlertWidth - 2 * kCoupleButtonWidth - kButtonBottomOffset) * 0.5, kAlertHeight - kButtonBottomOffset - kButtonHeight, kCoupleButtonWidth, kButtonHeight);
            _rightBtn.frame = CGRectMake(CGRectGetMaxX(_leftBtn.frame) + kButtonBottomOffset, kAlertHeight - kButtonBottomOffset - kButtonHeight, kCoupleButtonWidth, kButtonHeight);

            break;
        }
        default:
        {
            float height = kTitleYOffset+kTitleHeight+60+_buttons.count*kButtonHeight+kButtonBottomOffset;
            float trueHeight = 390.5>height?height:390.5;
            self.frame = CGRectMake((CGRectGetWidth([UIScreen mainScreen].bounds) - kAlertWidth) * 0.5, 0, kAlertWidth, trueHeight);
            for (int i = (int)_buttons.count - 1; i >= 0; i--) {
                UIButton *btn = [_buttons objectAtIndex:i];
                btn.frame = CGRectMake((kAlertWidth - kSingleButtonWidth) * 0.5, trueHeight - kButtonBottomOffset - kButtonHeight * (_buttons.count-i), kSingleButtonWidth, kButtonHeight-kButtonOffset);
            }
            break;
        }

    }
    
    _alertTitleLabel.frame = CGRectMake(0, kTitleYOffset, kAlertWidth, kTitleHeight);
    CGFloat contentLabelWidth = kAlertWidth - 16;
    _alertContentLabel.frame = CGRectMake((kAlertWidth - contentLabelWidth) * 0.5, CGRectGetMaxY(_alertTitleLabel.frame), contentLabelWidth, 60);
    
}

- (void)show
{
    CGRect rect = [UIScreen mainScreen].bounds;
  
    _originalWindow = [[UIWindow alloc] initWithFrame:rect];
    _originalWindow.windowLevel = UIWindowLevelAlert;
    _originalWindow.tag =100;

    _backgroundView  = [[UIView alloc] initWithFrame:rect];
    _backgroundView.alpha = 0.4;
    _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.center = _originalWindow.center;
    self.center = _originalWindow.center;
    
    [_originalWindow addSubview:_backgroundView];
    [_originalWindow addSubview:self];
    [_originalWindow becomeKeyWindow];
    [_originalWindow makeKeyAndVisible];

    if (_alertAnimationStyle == LCAlertAnimationDefault) {
        [self defaultStyle];
    }else if (_alertAnimationStyle == LCAlertAnimationFlipVertical){
        [self flipVertical];
    }else if (_alertAnimationStyle == LCAlertAnimationFlipHorizontal){
        [self flipHorizontal];
    }else{
        [self defaultStyle];
    }
}

- (void)flipHorizontal
{
    [self setupFrame];
    
    float width = kAlertWidth * 0.5;
    CGPoint point = CGPointZero;
    point.x -= width;
    point.y += CGRectGetHeight([UIScreen mainScreen].bounds) * 0.5;
    self.center = point;
    
    CGPoint point2 = _backgroundView.center;
    point2.x -= 0.03 * kAlertWidth;
    
    [UIView animateWithDuration:.00f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        [self roate:[[UIApplication sharedApplication]statusBarOrientation] sacle:1.0];
        
    } completion:^(BOOL finished) {
        
        
        [UIView animateWithDuration:.15f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            self.center = _backgroundView.center;
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:.06f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                self.center = point2;
                
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:.05f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    
                    self.center = _backgroundView.center;
                    
                } completion:^(BOOL finished) {
                    
                }];
                
            }];
            
        }];
        
    }];
}

- (void)flipVertical
{
    [self setupFrame];
    
    float height = kAlertHeight * 0.5;
    CGPoint point = CGPointZero;
    point.y -= height;
    point.x += CGRectGetWidth([UIScreen mainScreen].bounds) * 0.5;
    self.center = point;
    
    CGPoint point2 = _backgroundView.center;
    point2.y -= 0.08 * kAlertHeight;
    
    [UIView animateWithDuration:.00f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{

        [self roate:[[UIApplication sharedApplication]statusBarOrientation] sacle:1.0];
        
    } completion:^(BOOL finished) {
        
        
        [UIView animateWithDuration:.30f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            self.center = _backgroundView.center;
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:.06f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                self.center = point2;
                
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:.05f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    
                    self.center = _backgroundView.center;
                    
                } completion:^(BOOL finished) {
                    
                }];
                
            }];
            
        }];
        
    }];
}

- (void)flipVerticalHideView
{
    float height = kAlertHeight * 0.5;
    CGPoint point = self.center;
    point.y += (height + CGRectGetHeight([UIScreen mainScreen].bounds) * 0.5);
    
    [UIView animateWithDuration:0.23f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.transform = CGAffineTransformMakeRotation(M_1_PI / 1.5);
        
         self.center = point;

    } completion:^(BOOL finished) {
        
        [self hideMySelf];
    }]; 
}

- (void)flipHorizontalHideView
{
    float width = kAlertWidth * 0.5;
    CGPoint point = self.center;
    point.x += (width + CGRectGetWidth([UIScreen mainScreen].bounds) * 0.5);
    
    [UIView animateWithDuration:0.23f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.center = point;
        
    } completion:^(BOOL finished) {
        
        [self hideMySelf];
        
    }];
}

- (void)defaultStyle
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication]statusBarOrientation];
    
    [UIView animateWithDuration:0.0f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self setupFrame];
        self.center = _originalWindow.center;
        [self roate:orientation sacle:0.1];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.23f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            [self roate:orientation sacle:1.2];
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:.09f delay:0.02 options:UIViewAnimationOptionCurveEaseIn animations:^{
                
                [self roate:orientation sacle:0.9];
                
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:.05f delay:0.02 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    
                    [self roate:orientation sacle:1.0];
                    
                } completion:^(BOOL finished) {
                    
                }];
            }];
        }];
    }];
}

- (void)defaultHideView
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication]statusBarOrientation];
    [UIView animateWithDuration:.30f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self roate:orientation sacle:0.001];
    } completion:^(BOOL finished) {
        [self hideMySelf];
    }];
}

- (void)hideMySelf
{
    [self removeFromSuperview];
    [_backgroundView removeFromSuperview];
    _originalWindow = nil;
    [[[[UIApplication sharedApplication] delegate] window] makeKeyWindow];
}

- (void)buttonClick:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    if ([self.delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]){
        [self.delegate alertView:self clickedButtonAtIndex:button.tag];
    }
    
    if (self.alertAction) {
        self.alertAction(button.tag);
    }

    if (_alertAnimationStyle ==LCAlertAnimationDefault) {
         [self defaultHideView];
    }else if (_alertAnimationStyle ==LCAlertAnimationFlipVertical){
        [self flipVerticalHideView];
    }else if (_alertAnimationStyle == LCAlertAnimationFlipHorizontal){
        [self flipHorizontalHideView];
    }else{
        [self defaultHideView];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

@implementation UIButton (newbutton)

+ (UIButton *)creatOneBtn:(NSString *)title color:(UIColor *)color frame:(CGRect)frame action:(SEL)action target:(id)target {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    
    [button setBackgroundImage:[UIImage imageWithColor:color] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    
    button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 3.0;
    
    return button;
}

@end


@implementation UIImage (Colorful)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
