//
//  TimesViewController.m
//  palCineIphone
//
//  Created by Mario Zepeda on 12/25/13.
//  Copyright (c) 2013 Mario Zepeda. All rights reserved.
//

#import "TimesViewController.h"

@interface TimesViewController ()

@end

@implementation TimesViewController

@synthesize timesWebView;
@synthesize movieId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Horarios";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[timesWebView stringByEvaluatingJavaScriptFromString:@"document. body.style.zoom = 1000.0;"];
    
    CGRect oldFrame = timesWebView.frame;
    
        CGRect newFrame =CGRectMake(oldFrame.origin.x, oldFrame.origin.y, oldFrame.size.width, oldFrame.size.height-200);
        [timesWebView setFrame:newFrame];
    
    // create a standardUserDefaults variable
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    // getting an NSString object
    NSString *loc = [standardUserDefaults stringForKey:@"loc"];
    
    
    timesWebView.scalesPageToFit = NO;
    //timesWebView.delegate = self;
    [timesWebView.scrollView setZoomScale:1.0];
    NSString *myUrl = [NSString stringWithFormat:@"http://palcine.me/movie/times?m_id=%@&loc=%@",movieId,loc];
    NSURL *url = [NSURL URLWithString:myUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [timesWebView setScalesPageToFit:NO];
    [self.timesWebView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
