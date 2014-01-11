//
//  MovieDetailViewController.m
//  palCineIphone
//
//  Created by Mario Zepeda on 12/21/13.
//  Copyright (c) 2013 Mario Zepeda. All rights reserved.
//

#import "MovieDetailViewController.h" 
#import "AsyncImageView.h"
#import "VideoViewController.h"
#import "TimesViewController.h"
#import "ViewTrailerViewController.h"

@interface MovieDetailViewController ()

@end

@implementation MovieDetailViewController

@synthesize scrollView;
@synthesize detailMovie;
@synthesize movieNameLbl;
@synthesize starsImageView;
@synthesize movieSpanishNameLbl;
@synthesize movieEnglishNameLbl;
@synthesize movieLengthLbl;
@synthesize movieReleaseDateLbl;
@synthesize movieGenreLbl;
@synthesize movieRestrictionLbl;
@synthesize movieDescriptionLbl;
@synthesize movieImageThumbnail;
@synthesize movieDescriptionWebView;
@synthesize webView;

@synthesize videoURL;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Detalle";
        
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.movieNameLbl.text = detailMovie.name;
    
    //self.starsImageView.image = [[UIImage alloc]initWithContentsOfFile:[NSString stringWithFormat:@"stars%@.png",detailMovie.raiting]];
    self.starsImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"stars%d.png",[detailMovie.raiting intValue]]];
    
    self.movieSpanishNameLbl.text = detailMovie.name;
    self.movieSpanishNameLbl.numberOfLines = 0;
    [self.movieSpanishNameLbl sizeToFit];
    
    self.movieEnglishNameLbl.text = detailMovie.name_english;
    self.movieEnglishNameLbl.numberOfLines = 0;
    [self.movieEnglishNameLbl sizeToFit];
    
    self.movieLengthLbl.text = [NSString stringWithFormat: @"%@ minutos", detailMovie.length];    
    self.movieReleaseDateLbl.text = detailMovie.release_date;
    self.movieGenreLbl.text = detailMovie.genre;
    self.movieRestrictionLbl.text = detailMovie.restriction;
    //self.movieDescriptionLbl.text = detailMovie.description;
    [movieDescriptionWebView loadHTMLString:[NSString stringWithFormat:@"<div align='justify' style='font-family: helvetica; color: #686868; margin: 0; padding: 0;'>%@<div>",detailMovie.description] baseURL:nil];
    
    
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^(void) {
        
        NSString *imgURL = [[NSString alloc]initWithFormat:@"http://palcine.me/images/movies/%@",detailMovie.imageURL];
        //NSLog(currentMovie.imageURL);
        NSURL *url = [NSURL URLWithString:imgURL];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [[UIImage alloc] initWithData:data];
                             if (img) {
                                 dispatch_async(dispatch_get_main_queue(), ^{
                                        self.movieImageThumbnail.image = img;
                                 });
                             }
    });
    
    
    
    
    
    
    
    self.scrollView.contentSize = CGSizeMake(320, 600);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)viewTrailer:(id)sender {
    
    self.videoURL = [NSString stringWithFormat:@"http:%@",detailMovie.trailer_link];
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString: self.videoURL]];

    ViewTrailerViewController *trailerViewController = [[ViewTrailerViewController alloc]initWithNibName:@"ViewTrailerViewController" bundle:Nil];
    trailerViewController.videoURL = self.videoURL;
    [self presentModalViewController:trailerViewController animated:YES];
    
    
    
    //VideoViewController *videoViewController = [[VideoViewController alloc] initWithNibName:nil bundle:nil] ;
    
    //videoViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //videoViewController.videoURL = self.videoURL;
    //videoViewController.movieNameString = self.movieNameLbl.text;
    
    //[self.navigationController pushViewController:videoViewController animated:YES];
    //[self presentViewController:videoViewController animated:YES completion:^{
        // completion
    //}];
    //[self presentModalViewController:videoViewController animated:YES];

    
}

- (IBAction)viewTimes:(id)sender {
    TimesViewController *timesViewController = [[TimesViewController alloc]initWithNibName:@"TimesViewController" bundle:Nil];
    
    timesViewController.movieId = detailMovie.id;
    [self.navigationController pushViewController:timesViewController animated:YES];
}




- (NSUInteger)supportedInterfaceOrientations
{
	return UIInterfaceOrientationMaskPortrait;
}




@end
