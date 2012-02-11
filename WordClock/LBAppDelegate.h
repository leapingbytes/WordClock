//
//  LBAppDelegate.h
//  WordClock
//
//  Created by Andrei Tchijov on 2/10/12.
//  Copyright (c) 2012 Leaping Bytes, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LBViewController;

@interface LBAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LBViewController *viewController;

@end
