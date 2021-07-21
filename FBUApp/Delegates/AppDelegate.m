//
//  AppDelegate.m
//  FBUApp
//
//  Created by jessicasyl on 7/12/21.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
@import GoogleMaps;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ParseClientConfiguration *config = [ParseClientConfiguration  configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {

            configuration.applicationId = @"QUuVhJ9tB5HZ8w0h6F0KpqNmGcsJIMMFLKAqNzzb"; // <- UPDATE
            configuration.clientKey = @"BNL8oHok4W3Ygc4Ppj0o0V1GrZmwtokCfjJC7QrX"; // <- UPDATE
            configuration.server = @"https://parseapi.back4app.com";
        }];

        [Parse initializeWithConfiguration:config];
    
    [GMSServices provideAPIKey:@"AIzaSyBtFn7L9owgSjgTtZBNy4DL8xL9IqxEiII"];
    

        return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
