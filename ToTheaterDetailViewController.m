//
//  ToTheaterDetailViewController.m
//  palCineIphone
//
//  Created by Mario Zepeda on 12/27/13.
//  Copyright (c) 2013 Mario Zepeda. All rights reserved.
//

#import "ToTheaterDetailViewController.h"

@interface ToTheaterDetailViewController ()

@end

@implementation ToTheaterDetailViewController

@synthesize movieNameLbl;
@synthesize timeLbl;
@synthesize roomNameLbl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Tu detalle";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    movieNameLbl.text = [self movieName];
    timeLbl.text = [self time];
    roomNameLbl.text = [self roomName];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)yesButtonAction:(id)sender {
    
    int timeInterval = [self getTimeInterval:[self time]]*60 - 1800;
    //NSLog(@"time interval %d",timeInterval);
    
    
    UIAlertView *myAlert = [[UIAlertView alloc]initWithTitle:@"palCine" message:@"Que disfrutes tu película, te recordaremos unos minutos antes de que empiece." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [myAlert show];
    //[self performSelector:@selector(dismiss:) withObject:myAlert afterDelay:1.0];
    
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    //localNotification.fireDate = [NSDate dateWithTimeInterval:5 sinceDate:[NSDate date]];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:timeInterval];
    localNotification.alertBody = [NSString stringWithFormat:@"Te recordamos que vas a ver %@ a la(s) %@ en %@", [self movieName], [self time], [self roomName] ];
    localNotification.alertAction = NSLocalizedString(@"ver detalle de la pelicula", nil);
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber = -1;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];

    
}

-(int)getTimeInterval:(NSString*)time{
    //NSString* myString = @"11:58 pm";
    NSString* myString = time;
    NSArray* myArray = [myString  componentsSeparatedByString:@":"];
    
    NSString* myHourString = [myArray objectAtIndex:0];
    NSString* myMinutesAmPm = [myArray objectAtIndex:1];
    myArray = [myMinutesAmPm  componentsSeparatedByString:@" "];
    NSString* myMinutesString = [myArray objectAtIndex:0];
    
    int time24;
    int myHour = [myHourString intValue];
    int myMinutes = [myMinutesString intValue];
    //int myTime = (myHour*60) + myMinutes;
    if (myHour == 12 ) {
        if (([[myArray objectAtIndex:1] rangeOfString:@"p"].location == NSNotFound)) {
            myHour = 0;
        }
        time24 = 0;
        
        
    }else{
        if (!([[myArray objectAtIndex:1] rangeOfString:@"p"].location == NSNotFound)) {
            //NSLog(@"string does not contain P");
            
            time24 = 12*60;
            
        } else {
            //NSLog(@"string contains P!");
            time24 = 0;
            
        }
        
    }
    
    
    
    
    //NSLog(@"%d",myHour*60 + time24);
    //NSLog(@"%d",myMinutes);
    //NSLog(@"%d",myHour*60+myMinutes);
    
    
    
    
    
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"HH:mm"];
    
    // Creates a date object representing the current date
    NSString *nowString = [timeFormatter stringFromDate:[NSDate date]];
    NSDate *now = [timeFormatter dateFromString:nowString];
    
    // Creates an object representing the Gregorian calendar
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    // Sets the calendar object with an object representing the time zone specified in System Preferences
    [calendar setTimeZone:[NSTimeZone systemTimeZone]];
    
    // Calls the components:fromDate: method on the calendar object, passing in the date object created in line 2. This call returns an object containing the hour, minute, and second components of the date object
    NSDateComponents *dc = [calendar components:(NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit) fromDate:now];
    
    // Logs the current hour, minute, and second to the console
    //NSLog(@"The time is %d:%d:%d", [dc hour], [dc minute], [dc second]);
    
    int currentTime = ([dc hour]*60) + [dc minute];
    
    //NSLog(@"Tiempo para las 11 de la manana %d ", (myHour*60+myMinutes + time24) - currentTime);
    
    return (myHour*60+myMinutes + time24) - currentTime;

}

- (IBAction)noButtonAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}


@end
