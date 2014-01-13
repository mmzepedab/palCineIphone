//
//  ViewTrailerViewController.h
//  palCineIphone
//
//  Created by Mario Zepeda on 1/9/14.
//  Copyright (c) 2014 Mario Zepeda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewTrailerViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *recognizer;

@property (weak, nonatomic) NSString  *videoURL;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)closeModalView:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *fingerImage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
