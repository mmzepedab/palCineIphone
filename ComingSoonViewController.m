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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
