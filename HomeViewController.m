//
//  HomeViewController.m
//  palCineIphone
//
//  Created by Mario Zepeda on 11/4/13.
//  Copyright (c) 2013 Mario Zepeda. All rights reserved.
//

#import "HomeViewController.h"
#import "Movie.h"
#import "AsyncImageView.h"

@interface HomeViewController ()

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation HomeViewController

@synthesize list;
@synthesize toMovieTimeBtn;
@synthesize toMovieTheaterBtn;
@synthesize carousel;
@synthesize tabBar;
@synthesize items;





- (void)awakeFromNib
{
    //set up data
    //your carousel should always be driven by an array of
    //data of some kind - don't store data in your item views
    //or the recycling mechanism will destroy your data once
    //your item views move off-screen
    
}

- (void)dealloc
{
    //it's a good idea to set these to nil here to avoid
    //sending messages to a deallocated viewcontroller
    //this is true even if your project is using ARC, unless
    //you are targeting iOS 5 as a minimum deployment target
    carousel.delegate = nil;
    carousel.dataSource = nil;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.items = [NSMutableArray array];
        self.tabBar.selectedItem = self.tabBar.items[0];
        //[tabBar setSelectedItem:[tabBar.items objectAtIndex:0]];
        xmlParser = [[XMLParser alloc]loadXMLByURL:@"http://palcine.me/api/movies?loc=tgu"];
        
        items = [xmlParser movies];
        
        //for (int i = 0; i < 5; i++)
        //{
            //[_items addObject:@(i)];
        //}
        //_items = [[xmlParser movies] count];
    }
    return self;
}

- (void)viewDidLoad
{
    
    
    
    [super viewDidLoad];
    //xmlParser = [[XMLParser alloc]loadXMLByURL:@"http://palcine.me/palcineweb/ws/movieList.php"];
    carousel.type = iCarouselTypeCoverFlow;
    //Movie *currentMovie = [[xmlParser movies] objectAtIndex:1];
    //NSLog(currentMovie.image_thumbnail);
    // Do any additional setup after loading the view from its nib.
    //configure carousel
    CALayer *btnLayer = [toMovieTimeBtn layer];
    //[btnLayer setMasksToBounds:YES];
    //[btnLayer setCornerRadius:5.0f];
    
    CALayer *btnLayer2 = [toMovieTheaterBtn layer];
    //[btnLayer2 setMasksToBounds:YES];
    //[btnLayer2 setCornerRadius:5.0f];
    
    self.title = @"palCine";
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor : [UIColor whiteColor]};
    
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7) {
        self.navigationController.navigationBar.barTintColor = [[UIColor alloc]initWithRed:0 green:0.301 blue:0.6 alpha:100];
        self.navigationController.navigationBar.translucent = NO;
    }else {
        self.navigationController.navigationBar.tintColor = [[UIColor alloc]initWithRed:0 green:0.301 blue:0.6 alpha:100];
        
    }
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    //free up memory by releasing subviews
    self.carousel = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    //NSLog(@"%d",[items count]);
    return [items count];
    //Movie *currentMovie = [xmlParser movies];
    //NSLog(@"%d",[[xmlParser movies] count]);
    //NSLog(@"When i get here?");
    //return 3;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    //UILabel *label = nil;

    
    if (view == nil)
    {
        // create activity indicator
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]
                                                      initWithFrame:CGRectMake(0.0f, 0.0f, 20.0f, 20.0f)];
        [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        
        [view addSubview:activityIndicator];
        
        
        //label = [[UILabel alloc] initWithFrame:view.bounds];
        //label.backgroundColor = [UIColor clearColor];
        
        //label.textAlignment = NSTextAlignmentCenter;
        //label.font = [label.font fontWithSize:50];
        //label.tag = 1;
        //[view addSubview:label];
        
        view = [[[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, 170.0f, 230.0f)] autorelease];
        //view.contentMode = UIViewContentModeScaleAspectFit;
        //view.contentMode = UIViewContentModeScaleAspectFit;
        //view.backgroundColor = [UIColor clearColor];
        
        FXImageView *imageView = [[FXImageView alloc] initWithFrame:CGRectMake(0, 0, 170.0f, 230.0f)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.asynchronous = YES;
        imageView.reflectionScale = 0.5f;
        imageView.reflectionAlpha = 0.25f;
        imageView.reflectionGap = 10.0f;
        imageView.shadowOffset = CGSizeMake(0.0f, 4.0f);
        imageView.shadowColor = [UIColor grayColor];
        imageView.shadowBlur = 10.0f;
        view=imageView;
        
        [[AsyncImageLoader sharedLoader]cancelLoadingImagesForTarget:view];

        
    }
    else
    {
        //get a reference to the label in the recycled view
        //label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    //label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"batman.jpg"]];
    //label.text = [_items[index] stringValue];
    //label.text = @"Hola";
    //cancel any previously loading images for this view
    //[[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:view];
    
    //set image URL. AsyncImageView class will then dynamically load the image
    Movie *currentMovie = [items objectAtIndex:index];
    NSString *imgURL = [[NSString alloc]initWithFormat:@"http://palcine.me/images/movies/%@",currentMovie.imageURL];
    NSLog(currentMovie.imageURL);
    NSURL *url = [NSURL URLWithString:imgURL];
    ((AsyncImageView *)view).imageURL = url;
    //((FXImageView *)view).image = movieImage.image;
    
    return view;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing)
    {
        return value * 1.1f;
    }
    return value;
}


- (IBAction)toMovieTimeAction:(id)sender {
    
    UIAlertView *myAlert = [[UIAlertView alloc]initWithTitle:@"Huh" message:@"Todo bien" delegate:self cancelButtonTitle:@"Adios" otherButtonTitles: nil];
    [myAlert show];
    
}
@end
