//
//  AppDelegate.m
//  GoodNight
//
//  Created by Anthony Agatiello on 6/22/15.
//  Copyright © 2015 ADA Tech, LLC. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSDictionary *defaultsToRegister = @{@"enabled": @NO,
                                         @"maxOrange": @0.4,
                                         @"colorChangingEnabled": @YES,
                                         @"redValue": @1.0,
                                         @"greenValue": @1.0,
                                         @"blueValue": @1.0,
                                         @"dimEnabled": @NO,
                                         @"dimLevel": @1.0,
                                         @"lastAutoChangeDate": [NSDate distantPast],
                                         @"autoStartHour": @19,
                                         @"autoStartMinute": @0,
                                         @"autoEndHour": @7,
                                         @"autoEndMinute": @0,
                                         @"suspendEnabled": @NO,
                                         @"keyEnabled": @"0"};
    
    [userDefaults registerDefaults:defaultsToRegister];
    [GammaController autoChangeOrangenessIfNeededWithTransition:NO];
    [self registerForNotifications];
    [AppDelegate updateNotifications];
    [application setMinimumBackgroundFetchInterval:900];
    
    return YES;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    BOOL handledShortcutItem = [ForceTouchController handleShortcutItem:shortcutItem];
    [ForceTouchController exitIfKeyEnabled];
    completionHandler(handledShortcutItem);
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [GammaController autoChangeOrangenessIfNeededWithTransition:YES];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)registerForNotifications {
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [app registerUserNotificationSettings:settings];
}

+ (void)updateNotifications {
    NSString *bundleName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    
    UILocalNotification *enableNotification = [[UILocalNotification alloc] init];
    
    if (enableNotification == nil) {
        return;
    }
    
    NSDateComponents *compsForEnable = [[NSDateComponents alloc] init];
    [compsForEnable setHour:[userDefaults integerForKey:@"autoStartHour"]];
    [compsForEnable setMinute:[userDefaults integerForKey:@"autoStartMinute"]];
    [enableNotification setSoundName:UILocalNotificationDefaultSoundName];
    [enableNotification setAlertTitle:bundleName];
    [enableNotification setAlertBody:[NSString stringWithFormat:@"Time to enable %@!", bundleName]];
    [enableNotification setTimeZone:[NSTimeZone defaultTimeZone]];
    [enableNotification setFireDate:[[NSCalendar currentCalendar] dateFromComponents:compsForEnable]];
    
    UILocalNotification *disableNotification = [[UILocalNotification alloc] init];
    
    if (disableNotification == nil) {
        return;
    }
    
    NSDateComponents *compsForDisable = [[NSDateComponents alloc] init];
    [compsForDisable setHour:[userDefaults integerForKey:@"autoEndHour"]];
    [compsForDisable setMinute:[userDefaults integerForKey:@"autoEndMinute"]];
    [disableNotification setSoundName:UILocalNotificationDefaultSoundName];
    [disableNotification setAlertTitle:bundleName];
    [disableNotification setAlertBody:[NSString stringWithFormat:@"Time to disable %@!", bundleName]];
    [disableNotification setTimeZone:[NSTimeZone defaultTimeZone]];
    [disableNotification setFireDate:[[NSCalendar currentCalendar] dateFromComponents:compsForDisable]];
    
    if (app.scheduledLocalNotifications.count == 0) {
        [app setScheduledLocalNotifications:@[enableNotification, disableNotification]];
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [GammaController autoChangeOrangenessIfNeededWithTransition:YES];
    [ForceTouchController exitIfKeyEnabled];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id) annotation {
    if ([url.scheme isEqualToString: @"goodnight"]) {
        if ([url.host isEqualToString: @"enable"] && ![userDefaults boolForKey:@"enabled"]) {
            [GammaController enableOrangenessWithDefaults:YES transition:YES];
        }
        else if ([url.host isEqualToString: @"disable"] && [userDefaults boolForKey:@"enabled"]) {
            [GammaController disableOrangenessWithDefaults:YES key:@"enabled" transition:YES];
        }
        if ([[userDefaults objectForKey:@"keyEnabled"] isEqualToString:@"0"]) {
            [GammaController suspendApp];
        }
    }
    return NO;
}

+ (id)initWithIdentifier:(NSString *)identifier {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:identifier];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
