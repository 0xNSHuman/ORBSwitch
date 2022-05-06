//
//  ViewController.m
//  ORBSwitchDemo
//
//  Created by 0xNSHuman on 28/11/2016.
//  Copyright © 2016 0xNSHuman (hello@vladaverin.me). All rights reserved.
//

#import "ViewController.h"
#import "ORBSwitch.h"

@interface ViewController () <ORBSwitchDelegate> {
    ORBSwitch *_switch1;
    ORBSwitch *_switch12;
    ORBSwitch *_switch2;
    ORBSwitch *_switch22;
    ORBSwitch *_switch3;
    ORBSwitch *_switch32;
    ORBSwitch *_switch4;
    ORBSwitch *_switch42;
}

@end

@implementation ViewController

#pragma View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.16 green:0.63 blue:0.60 alpha:1.00];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self prepareUI];
    
    _switch1 = [[ORBSwitch alloc] initWithType:ORBSwitchSquare frame:CGRectMake(0,
                                                                                0,
                                                                                100,
                                                                                60)];
    _switch1.knobColor = [UIColor orangeColor];
    _switch1.inactiveBackgroundColor = [UIColor lightGrayColor];
    _switch1.activeBackgroundColor = [UIColor darkGrayColor];
    
    _switch1.center = CGPointMake(self.view.bounds.size.width / 4,
                                  self.view.bounds.size.height * 0.20f);
    
    _switch12 = [[ORBSwitch alloc] initWithType:ORBSwitchSquare frame:CGRectMake(0,
                                                                                0,
                                                                                100,
                                                                                60)];
    _switch12.knobColor = _switch1.knobColor;
    _switch12.isOn = YES;
    _switch12.inactiveBackgroundColor = _switch1.inactiveBackgroundColor;
    _switch12.activeBackgroundColor = _switch1.activeBackgroundColor;
    
    _switch12.center = CGPointMake(self.view.bounds.size.width / 4 * 3,
                                  self.view.bounds.size.height * 0.20f);
    
    _switch2 = [[ORBSwitch alloc] initWithType:ORBSwitchRound frame:CGRectMake(0,
                                                                                0,
                                                                                100,
                                                                                60)];
    _switch2.knobColor = [UIColor whiteColor];
    _switch2.inactiveBackgroundColor = [UIColor redColor];
    _switch2.activeBackgroundColor = [UIColor greenColor];
    _switch2.knobRelativeHeight = 0.8f;
    
    _switch2.center = CGPointMake(self.view.bounds.size.width / 4,
                                  self.view.bounds.size.height * 0.40f);
    
    _switch22 = [[ORBSwitch alloc] initWithType:ORBSwitchRound frame:CGRectMake(0,
                                                                                0,
                                                                                100,
                                                                                60)];
    _switch22.knobColor = _switch2.knobColor;
    _switch22.isOn = YES;
    _switch22.inactiveBackgroundColor = _switch2.inactiveBackgroundColor;
    _switch22.activeBackgroundColor = _switch2.activeBackgroundColor;
    _switch22.knobRelativeHeight = _switch2.knobRelativeHeight;
    
    _switch22.center = CGPointMake(self.view.bounds.size.width / 4 * 3,
                                   self.view.bounds.size.height * 0.40f);
    
    
    _switch3 = [[ORBSwitch alloc] initWithCustomKnobImage:[UIImage imageNamed:@"sw_knob"] inactiveBackgroundImage:[UIImage imageNamed:@"sw_bg.jpg"] activeBackgroundImage:[UIImage imageNamed:@"sw_bg_on.jpg"] frame:CGRectMake(0, 0, 100, 60)];
    _switch3.center = CGPointMake(self.view.bounds.size.width / 4,
                                  self.view.bounds.size.height * 0.60f);
    _switch3.knobRelativeHeight = 0.8f;
    
    _switch32 = [[ORBSwitch alloc] initWithCustomKnobImage:[UIImage imageNamed:@"sw_knob"] inactiveBackgroundImage:[UIImage imageNamed:@"sw_bg.jpg"] activeBackgroundImage:[UIImage imageNamed:@"sw_bg_on.jpg"] frame:CGRectMake(0, 0, 100, 60)];
    _switch32.isOn = YES;
    _switch32.center = CGPointMake(self.view.bounds.size.width / 4 * 3,
                                  self.view.bounds.size.height * 0.60f);
    _switch32.knobRelativeHeight = 0.8f;
    
    
    _switch4 = [[ORBSwitch alloc] initWithCustomKnobImage:[UIImage imageNamed:@"mario_r"] inactiveBackgroundImage:[UIImage imageNamed:@"mario_bg"] activeBackgroundImage:[UIImage imageNamed:@"mario_bg"] frame:CGRectMake(0, 0, 100, 60)];
    _switch4.center = CGPointMake(self.view.bounds.size.width / 4,
                                  self.view.bounds.size.height * 0.80f);
    _switch4.knobRelativeHeight = 0.8f;
    
    _switch42 = [[ORBSwitch alloc] initWithCustomKnobImage:[UIImage imageNamed:@"mario_r"] inactiveBackgroundImage:[UIImage imageNamed:@"mario_bg"] activeBackgroundImage:[UIImage imageNamed:@"mario_bg"] frame:CGRectMake(0, 0, 100, 60)];
    _switch42.isOn = YES;
    _switch42.center = CGPointMake(self.view.bounds.size.width / 4 * 3,
                                  self.view.bounds.size.height * 0.80f);
    _switch42.knobRelativeHeight = 0.8f;
    
    
    
    _switch1.delegate = _switch2.delegate = _switch3.delegate = _switch4.delegate = _switch12.delegate = _switch22.delegate = _switch32.delegate = _switch42.delegate = self;
    
    [self.view addSubview:_switch1];
    [self.view addSubview:_switch2];
    [self.view addSubview:_switch3];
    [self.view addSubview:_switch4];
    [self.view addSubview:_switch12];
    [self.view addSubview:_switch22];
    [self.view addSubview:_switch32];
    [self.view addSubview:_switch42];
}

#pragma mark - UI

- (void)prepareUI {
    UIView *verticalSep = [[UIView alloc]
                           initWithFrame:CGRectMake(self.view.bounds.size.width / 2,
                                                    self.view.bounds.size.height * 0.15f,
                                                    1,
                                                    self.view.bounds.size.height * 0.70f)];
    verticalSep.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:verticalSep];
    
    UILabel *onLbl = [[UILabel alloc]
                      initWithFrame:CGRectMake(0,
                                               0,
                                               40, 20)];
    onLbl.center = CGPointMake(self.view.bounds.size.width / 4 * 3,
                               self.view.bounds.size.height * 0.10f);
    onLbl.text = @"on";
    onLbl.textColor = [UIColor whiteColor];
    onLbl.font = [UIFont fontWithName:@"Helvetica-Light" size:24.0f];
    onLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:onLbl];
    
    UILabel *offLbl = [[UILabel alloc]
                       initWithFrame:CGRectMake(0,
                                                0,
                                                40, 20)];
    offLbl.center = CGPointMake(self.view.bounds.size.width / 4,
                                self.view.bounds.size.height * 0.10f);
    offLbl.text = @"off";
    offLbl.textColor = [UIColor whiteColor];
    offLbl.font = [UIFont fontWithName:@"Helvetica-Light" size:24.0f];
    offLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:offLbl];
}

#pragma mark - ORBSwitchDelegate

- (void)orbSwitchToggled:(ORBSwitch *)switchObj withNewValue:(BOOL)newValue {
    NSLog(@"Switch toggled: new state is %@", (newValue) ? @"ON" : @"OFF");
}

- (void)orbSwitchToggleAnimationFinished:(ORBSwitch *)switchObj {
    if (switchObj == _switch4 || switchObj == _switch42) {
        [switchObj setCustomKnobImage:[UIImage imageNamed:(switchObj.isOn) ? @"mario_l" : @"mario_r"]
              inactiveBackgroundImage:[UIImage imageNamed:@"mario_bg"]
                activeBackgroundImage:[UIImage imageNamed:@"mario_bg"]];
    }
}

@end
