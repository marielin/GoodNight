//
//  SettingsViewController.m
//  GoodNight
//
//  Created by Anthony Agatiello on 10/16/15.
//  Copyright © 2015 ADA Tech, LLC. All rights reserved.
//

#import "AppDelegate.h"
#import "SettingsViewController.h"

@implementation SettingsViewController

- (instancetype)init
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    self = [storyboard instantiateViewControllerWithIdentifier:@"settingsViewController"];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.suspendSwitch.on = [userDefaults boolForKey:@"suspendEnabled"];
//    self.peekPopSwitch.on = [userDefaults boolForKey:@"peekPopEnabled"];
}

- (IBAction)suspendSwitchChanged {
    [userDefaults setBool:self.suspendSwitch.on forKey:@"suspendEnabled"];
}

//- (IBAction)peekPopSwitchChanged {
//    [userDefaults setBool:self.peekPopSwitch.on forKey:@"peekPopEnabled"];
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0") && self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        if (section == 0) {
            return 1;
        }
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0") && self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
		return 1;
    }
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *headerText = @"";
    if (tableView) {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0") && self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
            if (section == 0) {
                headerText = @"3D Touch";
            }
        }
    }
    return headerText;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    NSString *footerText = @"";
    if (tableView) {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0") && self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
            if (section == 0) {
                footerText = @"When enabled, the \"Exit After Action\" exits the app after you enable or disable the set adjustment using 3D Touch.";
            }
        }
        else {
            footerText = @"There are no settings for your device at this moment. However, some may be added in a future update.";
        }
    }
    return footerText;
}

@end
