//
//  ForceTouchController.m
//  GoodNight
//
//  Created by Anthony Agatiello on 10/20/15.
//  Copyright © 2015 ADA Tech, LLC. All rights reserved.
//

@implementation ForceTouchController

+ (UIApplicationShortcutItem *)shortcutItemForTemperature {
    NSString *shortcutType, *shortcutTitle, *shortcutSubtitle, *iconTemplate = nil;
    
    static NSString * const turnOnText = @"Turn on this adjustment";
    static NSString * const turnOffText = @"Turn off this adjustment";
	
	shortcutType = @"temperatureForceTouchAction";
	
	if (![userDefaults boolForKey:@"enabled"]) {
		shortcutTitle = @"Enable Temperature";
		shortcutSubtitle = turnOnText;
		iconTemplate = @"enable-switch";
	}
	else {
		shortcutTitle = @"Disable Temperature";
		shortcutSubtitle = turnOffText;
		iconTemplate = @"disable-switch";
	}
    
    UIApplicationShortcutIcon *shortcutIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:iconTemplate];
    UIMutableApplicationShortcutItem *shortcut = [[UIMutableApplicationShortcutItem alloc] initWithType:shortcutType localizedTitle:shortcutTitle localizedSubtitle:shortcutSubtitle icon:shortcutIcon userInfo:nil];
    
    return shortcut;
}

+ (UIApplicationShortcutItem *)shortcutItemForBrightness {
	NSString *shortcutType, *shortcutTitle, *shortcutSubtitle, *iconTemplate = nil;
	
	static NSString * const turnOnText = @"Turn on this adjustment";
	static NSString * const turnOffText = @"Turn off this adjustment";
	
	shortcutType = @"dimForceTouchAction";
	
	if (![userDefaults boolForKey:@"dimEnabled"]) {
		shortcutTitle = @"Enable Dimness";
		shortcutSubtitle = turnOnText;
		iconTemplate = @"enable-switch";
	}
	else {
		shortcutTitle = @"Disable Dimness";
		shortcutSubtitle = turnOffText;
		iconTemplate = @"disable-switch";
	}
	
	UIApplicationShortcutIcon *shortcutIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:iconTemplate];
	UIMutableApplicationShortcutItem *shortcut = [[UIMutableApplicationShortcutItem alloc] initWithType:shortcutType localizedTitle:shortcutTitle localizedSubtitle:shortcutSubtitle icon:shortcutIcon userInfo:nil];
	
	return shortcut;
}

+ (void)updateShortcutItems {
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0") && [app respondsToSelector:@selector(shortcutItems)] && [app respondsToSelector:@selector(setShortcutItems:)]) {
		UIApplicationShortcutItem *shortcutTemperature = [self shortcutItemForTemperature];
		UIApplicationShortcutItem *shortcutBrightness = [self shortcutItemForBrightness];
		[app setShortcutItems:@[shortcutTemperature, shortcutBrightness]];
    }
}

+ (BOOL)handleShortcutItem:(UIApplicationShortcutItem *)shortcutItem {
    if ([shortcutItem.type isEqualToString:@"temperatureForceTouchAction"]) {
        if ([userDefaults boolForKey:@"enabled"]) {
            [GammaController disableOrangenessWithDefaults:YES key:@"enabled" transition:YES];
        }
        else if (![userDefaults boolForKey:@"enabled"]) {
            [GammaController enableOrangenessWithDefaults:YES transition:YES];
        }
    }
    else if ([shortcutItem.type isEqualToString:@"dimForceTouchAction"]) {
        if ([userDefaults boolForKey:@"dimEnabled"]) {
			[userDefaults setBool:NO forKey:@"dimEnabled"];
			[GammaController updateDimness];
        }
        else if (![userDefaults boolForKey:@"dimEnabled"]) {
			[userDefaults setBool:YES forKey:@"dimEnabled"];
            [GammaController updateDimness];
        }
    }
    return NO;
}

+ (void)exitIfKeyEnabled {
    if ([userDefaults boolForKey:@"suspendEnabled"] && [[userDefaults objectForKey:@"keyEnabled"] isEqualToString:@"0"]) {
        [GammaController suspendApp];
    }
}

@end