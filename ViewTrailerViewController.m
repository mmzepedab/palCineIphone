//
//  ViewTrailerViewController.m
//  palCineIphone
//
//  Created by Mario Zepeda on 1/9/14.
//  Copyright (c) 2014 Mario Zepeda. All rights reserved.
//

#import "ViewTrailerViewController.h"

@interface ViewTrailerViewController ()

@end

@implementation ViewTrailerViewController

@synthesize webView;
@synthesize recognizer;
@synthesize videoURL;
@synthesize fingerImage;
@synthesize activityIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    webView.scrollView.scrollEnabled = NO;
    webView.scrollView.bounces = NO;
    /*
    
     */
    
    
    
    NSString *html = [NSString stringWithFormat:@"<html><body><iframe class=\"youtube-player\" type=\"text/html\" width=\"%f\" height=\"%f\" src=\"%@?HD=1;rel=0\" allowfullscreen frameborder=\"0\" rel=nofollow></iframe></body></html>",self.view.frame.size.width-15,200.0,videoURL];
    [self.webView loadHTMLString:html baseURL:nil];
    
    //NSURL *url = [NSURL URLWithString:@"http://www.youtube.com/embed/84ieTKsn1Qk"];
    //NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //[self.webView loadRequest:request];
    
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    /*
    fingerImage.frame = CGRectMake(100, 100, fingerImage.frame.size.width, fingerImage.frame.size.height);
    [UIImageView beginAnimations:nil context:nil];
    [UIImageView setAnimationDuration:1.0f];
    fingerImage.frame = CGRectMake(100, 300, fingerImage.frame.size.width, fingerImage.frame.size.height);
    [UIImageView commitAnimations];
     */
    
    [UIImageView animateWithDuration:1.0
                          delay:0.5
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [fingerImage setFrame:CGRectMake(145, 300, fingerImage.frame.size.width, fingerImage.frame.size.height)];
                     }
                     completion:^(BOOL finished){
                         [UIImageView animateWithDuration:1.0 animations:^(void) {
                             fingerImage.alpha = 0;
                         }];
                     }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeModalView:(id)sender {
    // create a standardUserDefaults variable
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    // saving an NSString
    [standardUserDefaults setObject:@"NO" forKey:@"shouldScrollToFirst"];
    // synchronize the settings
    [standardUserDefaults synchronize];
    [self dismissModalViewControllerAnimated:YES];
}

-(void)swipeHandler:(UISwipeGestureRecognizer *)recognizer {
    // create a standardUserDefaults variable
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    // saving an NSString
    [standardUserDefaults setObject:@"NO" forKey:@"shouldScrollToFirst"];
    // synchronize the settings
    [standardUserDefaults synchronize];
    [self dismissModalViewControllerAnimated:YES];
}

//iOS 6+
- (BOOL)shouldAutorotate {
    return YES; }

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll; }

//iOS 5
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [activityIndicator startAnimating];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    activityIndicator.hidden = YES;
    [activityIndicator stopAnimating];
}

@end
