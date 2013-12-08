//
//  AppDelegate.h
//  palCineIphone
//
//  Created by Mario Zepeda on 11/3/13.
//  Copyright (c) 2013 Mario Zepeda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabBarViewController.h"

@class iCarouselExampleViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong,nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) IBOutlet MainTabBarViewController *mainTabBarController;

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) UINavigationController *comingSoonNavController;
@property (strong, nonatomic) UIViewController *myLocationViewController;


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
