//
//  AppDelegate.m
//  palCineIphone
//
//  Created by Mario Zepeda on 11/3/13.
//  Copyright (c) 2013 Mario Zepeda. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"
#import "HomeViewController.h"
#import "ComingSoonViewController.h"
#import "MyLocationViewController.h"
#import "iRate.h"
#import "Harpy.h"

@implementation AppDelegate

@synthesize window = _window;

@synthesize mainTabBarController;
@synthesize tabBarController;
@synthesize navController;
@synthesize comingSoonNavController;
//@synthesize myLocationViewController;


@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


+ (void)initialize
{
    //set the bundle ID. normally you wouldn't need to do this
    //as it is picked up automatically from your Info.plist file
    //but we want to test with an app that's actually on the store
    
    [iRate sharedInstance].daysUntilPrompt = 1;
    [iRate sharedInstance].usesUntilPrompt = 5;
    
    [iRate sharedInstance].applicationBundleID = @"com.mmzepedab.palCineIphone";
	[iRate sharedInstance].onlyPromptIfLatestVersion = NO;
    [iRate sharedInstance].appStoreID = 791104005;
    [iRate sharedInstance].messageTitle = @"palCine es Gratis";
    [iRate sharedInstance].message = @"Si te gusta esta App y quieres ayudarnos a que siga siendo gratis, regalanos un minuto para darnos tu Review.";
    [iRate sharedInstance].cancelButtonLabel = @"No, Gracias. Quiero pagar por esta App";
    [iRate sharedInstance].remindButtonLabel = @"Recordarme más tarde";
    [iRate sharedInstance].rateButtonLabel = @"Escribir Review Ahora";
    
    //enable preview mode
    //[iRate sharedInstance].previewMode = YES;
    [iRate sharedInstance].verboseLogging = NO;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    
    // Initialize Reachability
    Reachability *reachability = [Reachability reachabilityWithHostname:@"www.google.com"];
    // Start Monitoring
    [reachability startNotifier];
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //self.window.backgroundColor = [UIColor yellowColor];
    //self.tabBarController = [[UITabBarController alloc]init];
    self.mainTabBarController = [[MainTabBarViewController alloc]initWithNibName:@"MainTabBarViewController" bundle:nil];
    //mainTabBarController.tabBar.frame = CGRectMake(0, 380, 320, 50);
    
    HomeViewController *home = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:Nil];
    //MyLocationViewController *myLocation = [[MyLocationViewController alloc]initWithNibName:@"MyLocationViewController" bundle:nil];
    
    //ComingSoonViewController *comingSoonViewController = [[ComingSoonViewController alloc]initWithNibName:@"ComingSoonViewController" bundle:Nil];
    ComingSoonViewController *comingSoonViewController = [[ComingSoonViewController alloc]init];
    MyLocationViewController *myLocationVC = [[MyLocationViewController alloc]init];

    
    self.navController = [[UINavigationController alloc]initWithRootViewController:home];
    self.comingSoonNavController = [[UINavigationController alloc]initWithRootViewController:comingSoonViewController];
    self.myLocationViewController = [[UINavigationController alloc]initWithRootViewController:myLocationVC];
    //[self.window addSubview:self.navController.view];
    
    //self.tabBarController.viewControllers = [NSArray arrayWithObjects:navController,comingSoonNavController, nil];
    self.mainTabBarController.viewControllers = [NSArray arrayWithObjects:navController,comingSoonNavController, self.myLocationViewController, nil];
    //self.window.rootViewController  = self.tabBarController;
    //[self.window addSubview:self.mainTabBarController.view];
    
    self.window.rootViewController = self.mainTabBarController;
    
    //self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //Harpy Methods
    // Set the App ID for your app
    [[Harpy sharedInstance] setAppID:@"791104005"];
    
    // (Optional) Set the App Name for your app
    [[Harpy sharedInstance] setAppName:@"palCine"];
    
    
    [[Harpy sharedInstance] setForceLanguageLocalization:HarpyLanguageSpanish];
    
    // Perform check for new version of your app
    [[Harpy sharedInstance] checkVersion];
    
    
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
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"palCineIphone" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"palCineIphone.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
