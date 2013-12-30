//
//  ToTheaterViewController.m
//  palCineIphone
//
//  Created by Mario Zepeda on 12/26/13.
//  Copyright (c) 2013 Mario Zepeda. All rights reserved.
//

#import "ToTheaterViewController.h"
#import "ToTheaterTimeViewController.h"
#import "LoadingView.h"

@interface ToTheaterViewController (){
    LoadingView *loadingView;
}

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation ToTheaterViewController{
    NSArray *tableData;
}

@synthesize theaterTableView;
@synthesize movieId;
@synthesize movieName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Escoge tu cine";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    theaterTableView.frame = CGRectMake(theaterTableView.frame.origin.x, theaterTableView.frame.origin.y, theaterTableView.frame.size.width, theaterTableView.frame.size.height-25);

    [self methodtocallWebservices];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark TableView Protocols
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{
    return movieName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    Theater *currentTheater = [self.items objectAtIndex:indexPath.row];
    cell.textLabel.text = currentTheater.name;
    //cell.textLabel.font
    UIColor * color = [UIColor colorWithRed:4/255.0f green:70/255.0f blue:126/255.0f alpha:1.0f];
    cell.textLabel.textColor = color;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ToTheaterTimeViewController *toTheaterTimeViewController = [[ToTheaterTimeViewController alloc]initWithNibName:@"ToTheaterTimeViewController" bundle:Nil];
    Theater *currentTheater = [self.items objectAtIndex:indexPath.row];
    toTheaterTimeViewController.theaterId = currentTheater.id;
    toTheaterTimeViewController.theaterName = currentTheater.name;
    toTheaterTimeViewController.movieId = movieId;
    toTheaterTimeViewController.movieName = movieName;
    
    [self.navigationController pushViewController:toTheaterTimeViewController animated:YES];
}

#pragma mark -
#pragma mark WebService Call
-(void)methodtocallWebservices{
    
    loadingView =
    [LoadingView loadingViewInView:self.view];
    // create a standardUserDefaults variable
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    // getting an NSString object
    NSString *loc = [standardUserDefaults stringForKey:@"loc"];
    
    NSString *hostStr = [NSString stringWithFormat:@"http://palcine.me/api/theaters/?loc=%@&m_id=%@",loc,movieId];
    NSURL *url = [[NSURL alloc] initWithString:hostStr];
    receivedData = [NSMutableData dataWithCapacity: 0];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (!theConnection) {
        // Release the receivedData object.
        //NSLog(@"No connection");
        receivedData = nil;
        
        // Inform the user that the connection failed.
    }
    
}

#pragma mark -
#pragma mark NSUrlConnection methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [receivedData setLength:0];
}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [receivedData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [self stopLoading];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [self stopLoading];
}
-(void)stopLoading
{
    self.items = [NSMutableArray array];
    xmlParser = [[XMLParserTheater alloc]loadXMLwithData:receivedData];
    self.items = [xmlParser theaters];
    
    //dispatch_async(dispatch_get_main_queue(), ^{
    //NSLog(@"%@",receivedData);
    
    
    //NSLog(@"Huh? %d",[self.items count]);
    if ([self.items count]>0) {
        //[alertLoader dismissWithClickedButtonIndex:0 animated:YES];
        [theaterTableView reloadData];
        [loadingView removeView];
    }else{
        //[self methodtocallWebservices];
    }
    
    
    
    
    
    //});
}





@end
