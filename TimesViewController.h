//
//  TimesViewController.h
//  palCineIphone
//
//  Created by Mario Zepeda on 12/25/13.
//  Copyright (c) 2013 Mario Zepeda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimesViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *timesWebView;
@property(nonatomic, retain) NSString *movieId;


@end
