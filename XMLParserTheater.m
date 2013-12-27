//
//  XMLParserTheater.m
//  palCineIphone
//
//  Created by Mario Zepeda on 12/26/13.
//  Copyright (c) 2013 Mario Zepeda. All rights reserved.
//

#import "XMLParserTheater.h"
#import "Theater.h"

@implementation XMLParserTheater
@synthesize theaters;

-(id) loadXMLwithData:(NSData *)data{
    //NSLog(@"%@",data);
    theaters = [[NSMutableArray alloc] init];
    //NSURL *url = [NSURL URLWithString:urlString];
    //NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
    
    return self;
}

-(id) loadXMLByURL:(NSString *)urlString{
    theaters = [[NSMutableArray alloc] init];
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
    
    return self;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    if ([elementName isEqualToString:@"theater"])
    {
        currentTheater = [Theater alloc];
    }
    
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if ([elementName isEqualToString:@"id"]) {
        currentTheater.id = currentNodeContent;
    }
    if ([elementName isEqualToString:@"name"]){
        currentTheater.name = currentNodeContent;
        [theaters addObject:currentTheater];
        currentTheater = nil;
        currentNodeContent = nil;
    }
    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    currentNodeContent = (NSMutableString *) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
