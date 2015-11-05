//
//  GammaController.h
//  GoodNight
//
//  Created by Anthony Agatiello on 6/22/15.
//  Copyright © 2015 ADA Tech, LLC. All rights reserved.
//

@interface GammaController : NSObject <UIAlertViewDelegate>

typedef struct __IOMobileFramebuffer *IOMobileFramebufferConnection;
typedef kern_return_t IOMobileFramebufferReturn, SpringBoardServicesReturn;

+ (void)setGammaWithRed:(float)red green:(float)green blue:(float)blue;
+ (void)setGammaWithOrangeness:(float)percentOrange;
+ (void)autoChangeOrangenessIfNeededWithTransition:(BOOL)transition;
+ (BOOL)wakeUpScreenIfNeeded;
+ (void)enableOrangenessWithDefaults:(BOOL)defaults transition:(BOOL)transition;
+ (void)setGammaWithTransitionFrom:(float)oldPercentOrange to:(float)newPercentOrange;
+ (void)disableOrangenessWithDefaults:(BOOL)defaults key:(NSString *)key transition:(BOOL)transition;
+ (void)updateDimness;
+ (void)suspendApp;

@end