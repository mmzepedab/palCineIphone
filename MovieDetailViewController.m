//
//  MovieDetailViewController.m
//  palCineIphone
//
//  Created by Mario Zepeda on 12/21/13.
//  Copyright (c) 2013 Mario Zepeda. All rights reserved.
//

#import "MovieDetailViewController.h" 
#import "AsyncImageView.h"

@interface MovieDetailViewController ()

@end

@implementation MovieDetailViewController

@synthesize scrollView;
@synthesize detailMovie;
@synthesize movieNameLbl;
@synthesize movieSpanishNameLbl;
@synthesize movieEnglishNameLbl;
@synthesize movieLengthLbl;
@synthesize movieReleaseDateLbl;
@synthesize movieGenreLbl;
@synthesize movieRestrictionLbl;
@synthesize movieDescriptionLbl;
@synthesize movieImageThumbnail;

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
    self.movieSpanishNameLbl.text = detailMovie.name;
    self.movieEnglishNameLbl.text = detailMovie.name_english;
    self.movieLengthLbl.text = detailMovie.length;
    self.movieReleaseDateLbl.text = detailMovie.release_date;
    self.movieGenreLbl.text = detailMovie.genre;
    self.movieRestrictionLbl.text = detailMovie.restriction;
    self.movieDescriptionLbl.text = detailMovie.description;
    
    
    NSString *imgURL = [[NSString alloc]initWithFormat:@"http://palcine.me/images/movies/%@",detailMovie.imageURL];
    //NSLog(currentMovie.imageURL);
    NSURL *url = [NSURL URLWithString:imgURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    self.movieImageThumbnail.image = img;
    
    self.scrollView.contentSize = CGSizeMake(320, 900);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
