//
//  ToTheaterTimeViewController.m
//  palCineIphone
//
//  Created by Mario Zepeda on 12/26/13.
//  Copyright (c) 2013 Mario Zepeda. All rights reserved.
//

#import "ToTheaterTimeViewController.h"

@interface ToTheaterTimeViewController ()

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation ToTheaterTimeViewController

@synthesize timeTableView;
@synthesize time;
@synthesize roomName;
@synthesize theaterId;
@synthesize theaterName;
@synthesize movieId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Escoge la hora";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    timeTableView.frame = CGRectMake(timeTableView.frame.origin.x, timeTableView.frame.origin.y, timeTableView.frame.size.width, timeTableView.frame.size.height-25);
    
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
    return theaterName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    Time *currentTime = [self.items objectAtIndex:indexPath.row];
    cell.textLabel.text = currentTime.time;
    cell.detailTextLabel.text = currentTime.roomName;
    //cell.textLabel.font
    UIColor * color = [UIColor colorWithRed:4/255.0f green:70/255.0f blue:126/255.0f alpha:1.0f];
    cell.textLabel.textColor = color;
    return cell;
}

#pragma mark -
#pragma mark WebService Call
-(void)methodtocallWebservices{
    
    NSString *hostStr = [NSString stringWithFormat:@"http://www.palcine.me/api/movieRoomTimes/?loc=tgu&t_id=%@&m_id=%@",theaterId, movieId];
    //NSString *hostStr = @"http://www.palcine.me/api/movieRoomTimes/?loc=tgu&t_id=11&m_id=19";
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
    xmlParser = [[XMLParserTheaterTime alloc]loadXMLwithData:receivedData];
    self.items = [xmlParser times];
    
    //dispatch_async(dispatch_get_main_queue(), ^{
    //NSLog(@"%@",receivedData);
    
    
    //NSLog(@"Huh? %d",[self.items count]);
    if ([self.items count]>0) {
        //[alertLoader dismissWithClickedButtonIndex:0 animated:YES];
        [timeTableView reloadData];
    }else{
        //[self methodtocallWebservices];
    }
    
    
    
    
    
    //});
}


@end
