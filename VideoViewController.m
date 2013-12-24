//
//  VideoViewController.m
//  palCineIphone
//
//  Created by Mario Zepeda on 12/23/13.
//  Copyright (c) 2013 Mario Zepeda. All rights reserved.
//

#import "VideoViewController.h"

@interface VideoViewController ()

@end

@implementation VideoViewController

@synthesize videoView;
@synthesize videoURL;
@synthesize videoHTML;
@synthesize movieNameLbl;
@synthesize movieNameString;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Trailer";
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.movieNameLbl.text = movieNameString;
    videoView.backgroundColor = [UIColor whiteColor];
    //videoView.opaque = NO;
    
    [self embedYouTube];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)embedYouTube {
    
    videoHTML = [NSString stringWithFormat:@"\
                 <html>\
                 <head>\
                 <style type=\"text/css\">\
                 iframe {position:absolute; top:50%%; margin-top:-130px;}\
                 body {background-color:#FFF; margin:0;}\
                 </style>\
                 </head>\
                 <body>\
                 <iframe width=\"100%%\" height=\"240px\" src=\"%@\" frameborder=\"0\" allowfullscreen></iframe>\
                 </body>\
                 </html>", videoURL];
    
    [videoView loadHTMLString:videoHTML baseURL:nil];
}



- (IBAction) closeModal {
    [self dismissModalViewControllerAnimated:YES];
    
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}

- (NSUInteger)supportedInterfaceOrientations
{
	return UIInterfaceOrientationMaskPortrait;
}


@end
