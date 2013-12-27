//
//  XMLParserTheaterTime.m
//  palCineIphone
//
//  Created by Mario Zepeda on 12/27/13.
//  Copyright (c) 2013 Mario Zepeda. All rights reserved.
//

#import "XMLParserTheaterTime.h"
#import "Time.h"

@implementation XMLParserTheaterTime
@synthesize times;

-(id) loadXMLwithData:(NSData *)data{
    //NSLog(@"%@",data);
    times = [[NSMutableArray alloc] init];
    //NSURL *url = [NSURL URLWithString:urlString];
    //NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
    
    return self;
}

-(id) loadXMLByURL:(NSString *)urlString{
    times = [[NSMutableArray alloc] init];
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
    
    return self;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    if ([elementName isEqualToString:@"movieRoomTime"])
    {
        currentTime = [Time alloc];
    }
    
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if ([elementName isEqualToString:@"room_id"]) {
        currentTime.roomName = currentNodeContent;
        
    }
    if ([elementName isEqualToString:@"time"]){
        currentTime.time = currentNodeContent;
        [times addObject:currentTime];
        currentTime = nil;
        currentNodeContent = nil;
    }
    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    currentNodeContent = (NSMutableString *) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
