//
//  MovieDetailViewController.h
//  palCineIphone
//
//  Created by Mario Zepeda on 12/21/13.
//  Copyright (c) 2013 Mario Zepeda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"   

@interface MovieDetailViewController : UIViewController{
    
    NSString *videoURL;
    
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) Movie *detailMovie;
@property (weak, nonatomic) IBOutlet UILabel *movieNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *movieSpanishNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *movieEnglishNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *movieLengthLbl;
@property (weak, nonatomic) IBOutlet UILabel *movieReleaseDateLbl;
@property (weak, nonatomic) IBOutlet UILabel *movieGenreLbl;
@property (weak, nonatomic) IBOutlet UILabel *movieRestrictionLbl;
@property (weak, nonatomic) IBOutlet UITextView *movieDescriptionLbl;
@property (weak, nonatomic) IBOutlet UIImageView *movieImageThumbnail;
@property (weak, nonatomic) IBOutlet UIWebView *movieDescriptionWebView;
@property (weak, nonatomic) IBOutlet UIImageView *starsImageView;

@property (nonatomic, retain) NSString *videoURL;


- (IBAction)viewTrailer:(id)sender;
- (IBAction)viewTimes:(id)sender;

@end
