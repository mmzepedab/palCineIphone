//
//  ComingSoonViewController.m
//  palCineIphone
//
//  Created by Mario Zepeda on 12/3/13.
//  Copyright (c) 2013 Mario Zepeda. All rights reserved.
//

#import "ComingSoonViewController.h"
#import "Reachability.h"
#import "Movie.h"
#import "AsyncImageView.h"
#import "LoadingView.h"
#import "MovieDetailViewController.h"
#import "ToTheaterViewController.h"

@interface ComingSoonViewController (){
    LoadingView *loadingView;
}

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation ComingSoonViewController

@synthesize list;
@synthesize toMovieTimeBtn;
@synthesize carousel;
@synthesize tabBar;
@synthesize items;
@synthesize movieTitleLbl;
@synthesize noInternetLbl;
@synthesize dateLbl;
@synthesize videoURL;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // Add Observer Reachability
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityDidChange:) name:kReachabilityChangedNotification object:nil];
        
        // Custom initialization
        UIImage* tabImage = [UIImage imageNamed:@"comingIcon.png"];
        UITabBarItem* theItem = [[UITabBarItem alloc] initWithTitle:@"Proximamente" image:tabImage tag:0];
        self.tabBarItem = theItem;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
        [self methodtocallWebservices];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //Call WebService
    [self methodtocallWebservices];
    
    
    self.title = @"Proximamente";
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor : [UIColor whiteColor]};
    
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7) {
        self.navigationController.navigationBar.barTintColor = [[UIColor alloc]initWithRed:0 green:0.301 blue:0.6 alpha:100];
        self.navigationController.navigationBar.translucent = NO;
    }else {
        self.navigationController.navigationBar.tintColor = [[UIColor alloc]initWithRed:0 green:0.301 blue:0.6 alpha:100];
        //self.navigationController.navigationBar.backgroundColor = [[UIColor alloc]initWithRed:0 green:0.301 blue:0.6 alpha:100];
        //[[UINavigationBar appearance] setBackgroundColor:[UIColor redColor]];
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
        
        view = [[[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, 136.0f, 184.0f)] autorelease];
        //view.contentMode = UIViewContentModeScaleAspectFit;
        //view.contentMode = UIViewContentModeScaleAspectFit;
        //view.backgroundColor = [UIColor clearColor];
        
        FXImageView *imageView = [[FXImageView alloc] initWithFrame:CGRectMake(0, 0, 136.0f, 184.0f)];
        
        [imageView.layer setBorderColor: [[UIColor colorWithRed:224/255.0f green:224/255.0f blue:224/255.0f alpha:1.0f] CGColor]];
        [imageView.layer setBorderWidth: 1.0];
        imageView.backgroundColor = [UIColor colorWithRed:244/255.0f green:246/255.0f blue:247/255.0f alpha:1.0f];
        UIActivityIndicatorView *spinner = [[[UIActivityIndicatorView alloc]
                                             initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
        
        [imageView addSubview:spinner];
        [spinner startAnimating];
        spinner.center = imageView.center;
        [imageView sendSubviewToBack: spinner];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.asynchronous = YES;
        //imageView.reflectionScale = 0.5f;
        //imageView.reflectionAlpha = 0.25f;
        //imageView.reflectionGap = 10.0f;
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
    //NSLog(currentMovie.imageURL);
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


#pragma mark -
#pragma mark iCarousel taps

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    Movie *currentMovie = [items objectAtIndex:index];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: [NSString stringWithFormat:@"http:%@",currentMovie.trailer_link]]];
    
    //NSNumber *item = (self.items)[index];
    //NSLog(@"Pelicual: %@", currentMovie.name);
}

- (void)carouselCurrentItemIndexUpdated:(iCarousel *)carousel
{
    //NSLog(@"No entiendo");
    //int index= carousel.currentItemIndex;
    
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)myCarousel
{
    Movie *currentMovie = [items objectAtIndex:myCarousel.currentItemIndex];
    self.carouselMovieId = currentMovie.id;
    self.carouselMovieName = currentMovie.name;
    movieTitleLbl.text = currentMovie.name;
    dateLbl.text = currentMovie.release_date;
    self.videoURL = currentMovie.trailer_link;
    
}

-(void)methodtocallWebservices{
    
    //NSLog(@"Call WS");
    [loadingView removeView];
    loadingView =
    [LoadingView loadingViewInView:self.view];
    //CGRect newFrame = loadingView.frame;
    
    //newFrame.size.width = 200;
    //newFrame.size.height = 200;
    //[loadingView setFrame:newFrame];
    //loadingView.center = self.view.center;
    
    
    NSString *is_coming_soon = @"1";
    
    NSString *hostStr = [NSString stringWithFormat:@"http://palcine.me/api/movies?is_coming_soon=%@",is_coming_soon];
    NSURL *url = [[NSURL alloc] initWithString:hostStr];
    //NSLog(@"login url:  %@",url);
    receivedData = [NSMutableData dataWithCapacity: 0];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    //(void)[[NSURLConnection alloc] initWithRequest:request delegate:self];
    //[url release];
    if (!theConnection) {
        // Release the receivedData object.
        //NSLog(@"No connection");
        receivedData = nil;
        
        // Inform the user that the connection failed.
    }
    
    //[loadingView init];
    //alertLoader = [[UIAlertView alloc] initWithTitle:@"" message:@"Descargando información..." delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    //alertLoader.tag=1;
    //[alertLoader show];
}

- (void)didPresentAlertView:(UIAlertView *)alertView
{
    if (alertView.tag== 1) {
        //NSLog(@"alertView");
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        indicator.center = CGPointMake(alertView.bounds.size.width/2, alertView.bounds.size.height/3 * 2);
        [indicator startAnimating];
        [alertView addSubview:indicator];
    }
}


#pragma mark -
#pragma mark NSUrlConnection methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse object.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    // receivedData is an instance variable declared elsewhere.
    [receivedData setLength:0];
}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //  [self.receivedData appendData:data];
    [receivedData appendData:data];
    //receivedData = data;
    
    
    //[alertLoader release];
    //xmlParser = [[XMLParser alloc]loadXMLByURL:@"http://palcine.me/api/movies"];
    //NSLog(@"%@",data);
    
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [self stopLoading];
    //[self handleError:error];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    // do something with the data
    // receivedData is declared as a property elsewhere
    //NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
    //NSString *theXML = [[NSString alloc] initWithBytes:[receivedData mutableBytes] length:[receivedData length] encoding:NSUTF8StringEncoding];
	//NSLog(theXML);
    // Release the connection and the data object
    // by setting the properties (declared elsewhere)
    // to nil.  Note that a real-world app usually
    // requires the delegate to manage more than one
    // connection at a time, so these lines would
    // typically be replaced by code to iterate through
    // whatever data structures you are using.
    //theConnection = nil;
    //receivedData = nil;
    [self stopLoading];
}
-(void)stopLoading
{
    self.items = [NSMutableArray array];
    xmlParser = [[XMLParser alloc]loadXMLwithData:receivedData];
    self.items = [xmlParser movies];
    
    //dispatch_async(dispatch_get_main_queue(), ^{
    //NSLog(@"%@",receivedData);
    
    
    //NSLog(@"Huh? %d",[self.items count]);
    if ([self.items count]>0) {
        //[alertLoader dismissWithClickedButtonIndex:0 animated:YES];
        carousel.type = iCarouselTypeLinear;
        [carousel reloadData];
        Movie *firstMovie = [self.items objectAtIndex:0];
        self.carouselMovieId = firstMovie.id;
        self.carouselMovieName = firstMovie.name;
        movieTitleLbl.text = firstMovie.name;
        dateLbl.text = firstMovie.release_date;
        self.videoURL = firstMovie.trailer_link;
        [loadingView removeView];
    }else{
        [carousel reloadData];
        [loadingView removeView];
        //[self methodtocallWebservices];
    }
    
    
    
    
    
    //});
}


- (void)reachabilityDidChange:(NSNotification *)notification {
    Reachability *reachability = (Reachability *)[notification object];
    UIAlertView *myAlert = [[UIAlertView alloc]initWithTitle:@"Sin Internet" message:@"Verifica tu conexion a internet" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    if ([reachability isReachable]) {
        //NSLog(@"Reachable");
        noInternetLbl.hidden = true;
        movieTitleLbl.hidden = false;
        //[self performSelector:@selector(dismissAlert:) withObject:myAlert afterDelay:0];
        //[myAlert show];
        [myAlert dismissWithClickedButtonIndex:0 animated:YES];
        //[self methodtocallWebservices];
        
        [carousel reloadData];
    } else {
        movieTitleLbl.hidden = true;
        noInternetLbl.hidden = false;
        [myAlert show];
        //NSLog(@"Unreachable");
    }
}

-(void)dismissAlert:(UIAlertView *)alertView{
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
}


- (IBAction)viewTrailerBtn:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: [NSString stringWithFormat:@"http:%@",self.videoURL]]];
    
}
@end
