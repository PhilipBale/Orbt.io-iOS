//
//  ORBTAppDelegate.m
//  Orbt.io
//
//  Created by = on 11/11/2016.
//  Copyright (c) 2016 =. All rights reserved.
//

#import "ORBTAppDelegate.h"
#import "ORBTClient.h"

@implementation ORBTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSString *appId = @"58277dfa2714b5342634d011";
    NSString *uuid = @"test@test.com";
    NSString *identityToken = @"a21d79087496c9003946c906edc3f85d31ea4f6d";
    
    BOOL debug = YES;
    if (debug) {
        appId = @"57e30e9a835d3724b8094aa3";
        identityToken = @"f3b4fea25583a58294f82ade0312afcd30f21d9a";
    }
    
    
    [ORBTClient setAppId:appId];
    
    
    ORBTClient *client = [ORBTClient sharedClient];
    [client connectWithUUID:uuid identityToken:identityToken completion:^(BOOL success) {
        NSLog(@"Connected");
    }];
    // Override point for customization after application launch.
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
