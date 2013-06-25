//
//  XmlParser.m
//  XMLParsing1
//
//  Created by Abraham Varghese on 6/24/10.
//  Copyright 2010 ClearPoint Inc. All rights reserved.
//

#import "XmlParser.h"


@implementation XmlParser
@synthesize result;
@synthesize currentElementName;
@synthesize currentElementValue;
@synthesize parentArray;
@synthesize attributeList;

- (NSMutableArray *)loadXMLByURL:(NSString *)xmlName{
	parser = [[NSXMLParser alloc] initWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:xmlName ofType:@"xml"]]];
	parser.delegate = self;
	[parser parse];
	return result;
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
	result=[[NSMutableArray alloc] init];
	parentArray=[[NSMutableArray alloc] init];
	[parentArray addObject:result];
	currentElementName=@"";
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
	if (qName) {
		elementName = qName;
	}
	currentElementValue=@"";
	if (currentElementName!=@"")
	{
		id newParent=NULL;
		if ([currentElementName isKindOfClass:[NSString class]])
		{
			//NSLog(@"currentElementName >>> %@", elementName);
			newParent=[[NSMutableArray alloc] init];
			if ([attributeList count] != 0) [newParent addObject:[NSDictionary dictionaryWithObjectsAndKeys: attributeList, @"attributes", nil]];
		} else {
			newParent=[[NSMutableDictionary alloc] init];
		}
		[parentArray addObject:newParent];
		[newParent release];
	}
	currentElementName=elementName;
	attributeList = attributeDict;
	//NSLog(@"currentElementName >>> %@", elementName);
	//for (id key in attributeList) {
		//NSLog(@"key: %@, value: %@", key, [attributeList objectForKey:key]);
	//}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{     
	if (qName) {
		elementName = qName;
	}
	
	if (currentElementName==@"")
	{
		//We're adding a container with children.  Add it to the parent and remove this item fromt he parentArray
		int currentIndex=[parentArray count]-1;
		int parentIndex=currentIndex - 1;
		id currentChild=[parentArray objectAtIndex:currentIndex];
		id currentParent=[parentArray objectAtIndex:parentIndex];
		
		if ([currentParent isKindOfClass:[NSMutableArray class]])
		{
			//NSLog(@"count >>> %d", [attributeList count]);
			
			[currentParent addObject:currentChild];
		} else {
			[currentParent setObject:currentChild forKey:elementName];
		}
		
		[parentArray removeObjectAtIndex:currentIndex];
	} else {
		//We're adding a simple type element
		int currentIndex=[parentArray count]-1;
		id currentParent=[parentArray objectAtIndex:currentIndex];
		if ([currentParent isKindOfClass:[NSMutableArray class]])
		{
			//[currentParent addObject:currentElementValue];
			if ([attributeList count] != 0) {
				[currentParent addObject:[NSDictionary dictionaryWithObjectsAndKeys:currentElementValue,currentElementName, attributeList, @"attributes", nil]];
			} else {
				[currentParent addObject:[NSDictionary dictionaryWithObjectsAndKeys:currentElementValue,currentElementName, nil]];
			}


		} else {
			[currentParent setObject:currentElementValue forKey:currentElementName];
		}
	}
	currentElementName=@"";
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	currentElementValue=[NSString stringWithString:string];
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock{
	[currentElementValue release];
	currentElementValue = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
}

-(void) dealloc {
	
	[result release];
	[parentArray release];
	[parser release];
    [super dealloc];
}

@end