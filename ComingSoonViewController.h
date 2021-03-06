//
//  ComingSoonViewController.h
//  palCineIphone
//
//  Created by Mario Zepeda on 12/3/13.
//  Copyright (c) 2013 Mario Zepeda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "XMLParser.h"
#import "FXImageView.h"

@interface ComingSoonViewController : UIViewController<iCarouselDataSource, iCarouselDelegate, NSURLConnectionDelegate ,UIAlertViewDelegate>{
    XMLParser *xmlParser;
    NSMutableData *receivedData;
    UIAlertView *alertLoader;
}

@property (nonatomic, strong) IBOutlet iCarousel *carousel;
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
@property (weak, nonatomic) IBOutlet UILabel *movieTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *noInternetLbl;

//@property (nonatomic, assign) NSData *receivedData;
@property (strong, nonatomic) NSArray *list;
@property (weak, nonatomic) IBOutlet UIButton *toMovieTimeBtn;

@property (weak, nonatomic) NSString  *carouselMovieId;
@property (weak, nonatomic) NSString  *carouselMovieName;
@property (weak, nonatomic) NSString  *videoURL;
@property (weak, nonatomic) IBOutlet UILabel *dateLbl;
- (IBAction)viewTrailerBtn:(id)sender;
- (IBAction)viewTrailer:(id)sender;

@end
