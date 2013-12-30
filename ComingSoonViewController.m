//
//  ComingSoonViewController.m
//  palCineIphone
//
//  Created by Mario Zepeda on 12/3/13.
//  Copyright (c) 2013 Mario Zepeda. All rights reserved.
//

#import "ComingSoonViewController.h"

@interface ComingSoonViewController ()

@end

@implementation ComingSoonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIImage* tabImage = [UIImage imageNamed:@"comingIcon.png"];
        UITabBarItem* theItem = [[UITabBarItem alloc] initWithTitle:@"Proximamente" image:tabImage tag:0];
        self.tabBarItem = theItem;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Proximamente";
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor : [UIColor whiteColor]};
    
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7) {
        self.navigationController.navigationBar.barTintColor = [[UIColor alloc]initWithRed:0 green:0.301 blue:0.6 alpha:100];
        self.navigationController.navigationBar.translucent = NO;
    }else {
        self.navigationController.navigationBar.tintColor = [[UIColor alloc]initWithRed:0 green:0.301 blue:0.6 alpha:100];
        //self.navigationController.navigationBar.backgroundColor = [[UIColor alloc]initWithRed:0 green:0.301 blue:0.6 alpha:100];
        //[[UINavigationBar appearance] setBackgroundColor:[UIColor redColor]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
