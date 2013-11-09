//
//  HomeViewController.h
//  palCineIphone
//
//  Created by Mario Zepeda on 11/4/13.
//  Copyright (c) 2013 Mario Zepeda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "XMLParser.h"
#import "FXImageView.h"

@interface HomeViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>{
    XMLParser *xmlParser;

}
@property (nonatomic, strong) IBOutlet iCarousel *carousel;
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;

@property (strong, nonatomic) NSArray *list;
@property (weak, nonatomic) IBOutlet UIButton *toMovieTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *toMovieTheaterBtn;

//-(void)loadXMLParser;
- (IBAction)toMovieTimeAction:(id)sender;

@end
