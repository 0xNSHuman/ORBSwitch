//
//  ORBSwitch.m
//  ORBSwitchDemo
//
//  Created by 0xNSHuman on 21/03/16.
//  Copyright © 2016 0xNSHuman (hello@vladaverin.me). All rights reserved.
//
//  Distributed under the permissive zlib License
//  Get the latest version from here:
//
//  https://github.com/0xNSHuman/ORBSwitch
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.

#import "ORBSwitch.h"

#define kORBSwitchRoundCornerRadius 10.0f
#define kORBSwitchKnobRelativeHeightDefault 0.6f
#define kORBSwitchKnobRelativePadding ((1.0f - self.knobRelativeHeight) / 2.0f)

#define kORBSwitchKnobFrameStateOn CGRectMake(self.bounds.size.width - self.bounds.size.height * kORBSwitchKnobRelativePadding - self.bounds.size.height * self.knobRelativeHeight, self.bounds.size.height * kORBSwitchKnobRelativePadding, self.bounds.size.height * self.knobRelativeHeight, self.bounds.size.height * self.knobRelativeHeight)

#define kORBSwitchKnobFrameStateOff CGRectMake(self.bounds.size.height * kORBSwitchKnobRelativePadding, self.bounds.size.height * kORBSwitchKnobRelativePadding, self.bounds.size.height * self.knobRelativeHeight, self.bounds.size.height * self.knobRelativeHeight)

@interface ORBSwitch () {
    UIImage *_inactiveBGImage;
    UIImage *_activeBGImage;
    UIImage *_knobImage;
    
    UIImageView *_backgroundImageView;
    UIImageView *_knobImageView;
    
    UIButton *_switchButton;
}

@property (assign, readwrite) ORBSwitchType switchType;

@end

@implementation ORBSwitch

@synthesize isOn = _isOn;
@synthesize knobColor = _knobColor;
@synthesize inactiveBackgroundColor = _inactiveBackgroundColor;
@synthesize activeBackgroundColor = _activeBackgroundColor;
@synthesize knobRelativeHeight = _knobRelativeHeight;

#pragma mark - Public Init

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithType:ORBSwitchSquare frame:frame knobImage:nil inactiveBackgroundImage:nil activeBackgroundImage:nil];
}

- (instancetype)initWithType:(ORBSwitchType)switchType frame:(CGRect)switchFrame {
    return [self initWithType:switchType frame:switchFrame knobImage:nil inactiveBackgroundImage:nil activeBackgroundImage:nil];
}

- (instancetype)initWithCustomKnobImage:(UIImage *)knobImage
                inactiveBackgroundImage:(UIImage *)inactiveBGImage
                  activeBackgroundImage:(UIImage *)activeBGImage frame:(CGRect)switchFrame {
    
    return [self initWithType:ORBSwitchCustom frame:switchFrame knobImage:knobImage inactiveBackgroundImage:inactiveBGImage activeBackgroundImage:activeBGImage];
}

#pragma mark - Designated Init

- (instancetype)initWithType:(ORBSwitchType)switchType frame:(CGRect)frame knobImage:(UIImage *)knobImage inactiveBackgroundImage:(UIImage *)inactiveBGImage activeBackgroundImage:(UIImage *)activeBGImage {
    
    if (self = [super initWithFrame:frame]) {
        self.switchType = switchType;
        
        self.knobColor = [UIColor clearColor];
        self.inactiveBackgroundColor = [UIColor clearColor];
        self.inactiveBackgroundColor = [UIColor clearColor];
        self.knobRelativeHeight = kORBSwitchKnobRelativeHeightDefault;
        
        if (self.switchType == ORBSwitchCustom) {
            _inactiveBGImage = inactiveBGImage;
            _activeBGImage = activeBGImage;
            _knobImage = knobImage;
        }
        
        [self reconstructSwitch];
    }
    
    return self;
}

#pragma mark - View updates

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self reconstructSwitch];
}

- (void)setCustomKnobImage:(UIImage *)knobImage
   inactiveBackgroundImage:(UIImage *)inactiveBGImage
     activeBackgroundImage:(UIImage *)activeBGImage {

    self.switchType = ORBSwitchCustom;
    _inactiveBGImage = inactiveBGImage;
    _activeBGImage = activeBGImage;
    _knobImage = knobImage;
    
    [self reconstructSwitch];
}

#pragma mark - Custom Accessors

- (void)setKnobRelativeHeight:(CGFloat)knobRelativeHeight {
    if (knobRelativeHeight > 1.0f) {
        return;
    }
    
    _knobRelativeHeight = knobRelativeHeight;
    [self reconstructSwitch];
}

- (void)setKnobColor:(UIColor *)knobColor {
    _knobColor = knobColor;
    
    if (self.switchType != ORBSwitchCustom) {
        _knobImageView.backgroundColor = _knobColor;
    }
}

- (void)setInactiveBackgroundColor:(UIColor *)inactiveBackgroundColor {
    _inactiveBackgroundColor = inactiveBackgroundColor;
    
    if (self.switchType != ORBSwitchCustom) {
        (![self isOn]) ? _backgroundImageView.backgroundColor = _inactiveBackgroundColor : nil;
    }
}

- (void)setActiveBackgroundColor:(UIColor *)activeBackgroundColor {
    _activeBackgroundColor = activeBackgroundColor;
    
    if (self.switchType != ORBSwitchCustom) {
        ([self isOn]) ? _backgroundImageView.backgroundColor = _activeBackgroundColor : nil;
    }
}

- (void)setIsOn:(BOOL)isOn animated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.25f delay:0.0f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
            self.isOn = isOn;
        } completion:^(BOOL finished) {
            if ([self.delegate respondsToSelector:@selector(orbSwitchToggleAnimationFinished:)]) {
                [self.delegate orbSwitchToggleAnimationFinished:self];
            }
        }];
        
        CATransition *transition = [CATransition animation];
        transition.duration = 0.25f;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        transition.type = kCATransitionFade;
        
        [_backgroundImageView.layer addAnimation:transition forKey:nil];
    } else {
        self.isOn = isOn;
    }
    
    if ([self.delegate respondsToSelector:@selector(orbSwitchToggled:withNewValue:)]) {
        [self.delegate orbSwitchToggled:self withNewValue:isOn];
    }
}

- (void)setIsOn:(BOOL)isOn {
    if (self.switchType == ORBSwitchCustom) {
        [_backgroundImageView setImage:(isOn) ? _activeBGImage : _inactiveBGImage];
    } else {
        [_backgroundImageView setBackgroundColor:(isOn) ? self.activeBackgroundColor : self.inactiveBackgroundColor];
    }
    
    [_knobImageView setFrame:(isOn) ? kORBSwitchKnobFrameStateOn : kORBSwitchKnobFrameStateOff];
    
    _isOn = isOn;
}

- (BOOL)isOn {
    return _isOn;
}

#pragma mark - Switch construction

- (void)reconstructSwitch {
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
    
    _backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _backgroundImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_backgroundImageView];
    
    _knobImageView = [[UIImageView alloc]
                      initWithFrame:(_isOn) ? kORBSwitchKnobFrameStateOn : kORBSwitchKnobFrameStateOff];
    
    switch (self.switchType) {
        case ORBSwitchSquare: {
            [_knobImageView setBackgroundColor:self.knobColor];
            [_knobImageView setImage:nil];
            
            _backgroundImageView.layer.cornerRadius = _knobImageView.layer.cornerRadius = 0.0f;
            break;
        }
            
        case ORBSwitchRound: {
            [_knobImageView setBackgroundColor:self.knobColor];
            [_knobImageView setImage:nil];
            
            _backgroundImageView.layer.cornerRadius = _knobImageView.layer.cornerRadius = kORBSwitchRoundCornerRadius;
            break;
        }
            
        case ORBSwitchCustom: {
            [_knobImageView setBackgroundColor:[UIColor clearColor]];
            [_knobImageView setImage:_knobImage];
            
            _backgroundImageView.layer.cornerRadius = _knobImageView.layer.cornerRadius = 0.0f;
            break;
        }
            
        default:
            break;
    }
    
    _knobImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_knobImageView];
    
    _switchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _switchButton.frame = self.bounds;
    [_switchButton addTarget:self action:@selector(switchTriggered) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_switchButton];
    
    self.isOn = _isOn;
}

#pragma mark - Button events

- (void)switchTriggered {
    [self setIsOn:!self.isOn animated:YES];
}

@end
