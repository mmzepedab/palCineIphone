//
//  XMLParser.m
//  Nav
//
//  Created by Mario Zepeda on 11/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XMLParser.h"
#import "Movie.h"

@implementation XMLParser
@synthesize movies;

-(id) loadXMLByURL:(NSString *)urlString{
    movies = [[NSMutableArray alloc] init];
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
    
    return self;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    if ([elementName isEqualToString:@"movie"])
    {
        currentMovie = [Movie alloc];
    }

}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if ([elementName isEqualToString:@"id"]) {
        currentMovie.id = currentNodeContent;
    }
    if ([elementName isEqualToString:@"name"]){
        currentMovie.name = currentNodeContent;
    }
    if([elementName isEqualToString:@"genre_id"]){
        currentMovie.genre = currentNodeContent;
    }
    if([elementName isEqualToString:@"image_thumbnail"]){
        currentMovie.image_thumbnail = currentNodeContent;

        
        NSString *imgURL = [[NSString alloc]initWithFormat:@"http://palcine.me/palcineweb/images/%@",currentMovie.image_thumbnail];
        NSURL *url = [NSURL URLWithString:imgURL];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [[UIImage alloc] initWithData:data];
        currentMovie.imageThumbnail = img;        
    }
    if([elementName isEqualToString:@"image"]){
        currentMovie.imageURL = currentNodeContent;
        [movies addObject:currentMovie];
        currentMovie = nil;
        currentNodeContent = nil;
        
        
    }
    if([elementName isEqualToString:@"movie"]){
        //currentMovie.raiting = currentNodeContent;
        
        
    }
    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    currentNodeContent = (NSMutableString *) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
