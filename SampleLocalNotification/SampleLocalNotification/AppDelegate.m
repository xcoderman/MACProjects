//
//  AppDelegate.m
//  SampleLocalNotification
//
//  Created by pachie on 28/7/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "OneViewController.h"

@implementation AppDelegate


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    application.applicationIconBadgeNumber = 0;
    
    
    
    [[UIApplication sharedApplication] cancelLocalNotification:notification];
    
    [[self window] makeKeyAndVisible];
    
    
    UITabBarController *tab =(UITabBarController *)self.window.rootViewController;
    
    tab.selectedIndex = 0;
    
    UINavigationController *nav = (UINavigationController *)[tab selectedViewController];
    
    HomeViewController *dv = [[HomeViewController alloc]init];
    
    dv = [[nav viewControllers] objectAtIndex:0];

    
    if ([notification.userInfo valueForKey:@"myKey1"] != nil) {
        NSLog(@"This is notifcation window1 and key %@",notification.userInfo);
    
        //[dv performSegueWithIdentifier:@"segone" sender:self];
        dv.notificationID = [notification.userInfo valueForKey:@"myKey1"];
        
        [dv CallOtherView];

    
    }
    else
    {
        NSLog(@"This is notifcation window2 and key %@",[notification.userInfo valueForKey:@"myKey2"]);
        
        //[dv performSegueWithIdentifier:@"segtwo" sender:self];
        
        dv.notificationID = [notification.userInfo valueForKey:@"myKey2"];
        [dv CallOtherView2];

    }
    
    
    
    
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    // Override point for customization after application launch.
//    self.window.backgroundColor = [UIColor whiteColor];
//    [self.window makeKeyAndVisible];
    
    UILocalNotification *localNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotification) {
        application.applicationIconBadgeNumber = 0;
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
