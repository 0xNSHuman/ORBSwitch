//
//  ORBSwitch.h
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
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger) {
    ORBSwitchUnknown = -1,
    ORBSwitchSquare,
    ORBSwitchRound,
    ORBSwitchCustom
} ORBSwitchType;

@class ORBSwitch;

#pragma mark - Protocols

@protocol ORBSwitchDelegate <NSObject>

@required
- (void)orbSwitchToggled:(ORBSwitch *)switchObj withNewValue:(BOOL)newValue;

@optional
- (void)orbSwitchToggleAnimationFinished:(ORBSwitch *)switchObj;

@end

@interface ORBSwitch : UIView

#pragma mark - Properties

@property (nonatomic, weak) id <ORBSwitchDelegate> delegate;
@property (assign, nonatomic) BOOL isOn;

@property (assign, readonly) ORBSwitchType switchType;

@property (assign, nonatomic) UIColor *knobColor;
@property (assign, nonatomic) UIColor *inactiveBackgroundColor;
@property (assign, nonatomic) UIColor *activeBackgroundColor;

@property (assign, nonatomic) CGFloat knobRelativeHeight;

#pragma mark - Methods

- (instancetype)initWithType:(ORBSwitchType)switchType
                       frame:(CGRect)switchFrame;

- (instancetype)initWithCustomKnobImage:(UIImage *)knobImage
                inactiveBackgroundImage:(UIImage *)inactiveBGImage
                  activeBackgroundImage:(UIImage *)activeBGImage
                                  frame:(CGRect)switchFrame;

- (void)setCustomKnobImage:(UIImage *)knobImage
   inactiveBackgroundImage:(UIImage *)inactiveBGImage
     activeBackgroundImage:(UIImage *)activeBGImage;

@end
