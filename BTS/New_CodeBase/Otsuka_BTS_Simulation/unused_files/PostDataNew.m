//
//  PostDataNew.m
//  Otsuka_BTS_Simulation
//
//  Created by administrator on 6/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PostDataNew.h"


@implementation PostDataNew

static NSMutableData *webdata;

//- (void) postData
+ (void) sendDataToBTS
{
    
    NSLog(@"IN POST DATA NEW");
	/*
	 //set post string with actual username and password
	 //NSString * post = [NSString stringWithFormat:@"&userName=%@&password=%@",@"admin",@"cls"];
	 
	 NSString * post = [NSString stringWithFormat:@"&userName=%@&password=%@",@"userName.text",@"pwd.text"];
	 
	 
	 // Encode post string in NSData Format to send in NSData Format
	 NSData * postData=[post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];		
	 
	 //calculate the length of post string
	 NSString * postLength=[NSString stringWithFormat:@"%d",[postData length]];
	 
	 //Create URL Request object and initialize it
	 NSMutableURLRequest * request = [[[NSMutableURLRequest alloc] init] autorelease];	
	 
	 //Set the URL for which your going to send the data
	 [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://vi-bd/btslms/CheckUser.asp"]]];
	 
	 // Set http Method (POST or GET)
	 [request setHTTPMethod:@"POST"];
	 
	 // Set HTTP header field with the length of post data.				   
	 [request setValue:postLength forHTTPHeaderField:@"Content-Length"];				
	 
	 // Set the Encoded value for HTTP header field.
	 [request setHTTPBody:postData];
	 
	 
	 //create URL Connection Object and Initialize it with URL request.
	 NSURLConnection * conn=[[NSURLConnection alloc]initWithRequest:request delegate:self];	
	 
	 // check whether url connection is done
	 if(conn)
	 {
	 NSLog(@"Connection Successful");
	 }
	 
	 else
	 {
	 NSLog(@"Connection could not be made");
	 
	 
	 }*/
		
	//NSString * post = [[NSString alloc] initWithFormat:@"username=%@&password=%@",username,password];
	//NSString * post = [[NSString alloc] initWithFormat:@"appID=%@&data=%@&nickname=dino",username,password];
	NSString * post = @"appID=BED7548A-7B29-5B74-AE2D-010B3C0AEBD8&data=(({AttemptID = 'CB3F55E8-8D6B-40B2-9E8F-802A31F853C3';Bookmark = '';FinishedAttempt = NO;KPIData =             {'Customer Results Score' = 0;'Trusted Advisor Relationship Score' = 0;};PageCount = 0;Status = 'Not Started';TotalScore = 0;}),({}))&nickname=s s";
	NSData * postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	
	NSString * postLength = [NSString stringWithFormat:@"%d", [postData length]];
	
	//NSURL * url=[NSURL URLWithString:@"http:asp-stage.clearpointlearning.com/CheckUser.asp"];
	NSURL * url=[NSURL URLWithString:@"http://mchotcpowerup.clearpointlearning.com/ipadtest/default.aspx"];
	
	NSMutableURLRequest * theRequest = [NSMutableURLRequest requestWithURL:url];
	
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPBody:postData];
	
	
	NSURLConnection * theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if(theConnection)
	{
		webdata=[[NSMutableData data] retain];
		NSLog(@"Connection On");
	}
	
	else {
		
		//userName.text = nil;
		//pwd.text = nil;
		NSLog(@"Connection Failed");
        
		
	}
	
	
    
	
    
}

//+ (void) sendDataToBTS {
    //[self performSelector:@selector(postData)];
//}

-(void) connection: (NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	
	[webdata setLength: 0];
	
    NSLog(@"Response Received");
}


-(void) connection: (NSURLConnection *)connection didReceiveData:(NSData *)data
{
	
	[webdata appendData: data];
	
	NSLog(@"check data Received");
}

-(void) connection: (NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
	
	[connection release];
	[webdata release];
	NSLog(@"Error Received");
}

-(void) connectionDidFinishLoading:(NSURLConnection *)connection
{
	
	NSString * loginStatus = [[NSString alloc] initWithBytes: [webdata mutableBytes] length:[webdata length] encoding:NSUTF8StringEncoding];
	//NSLog(loginStatus);
	NSLog(@"loginStatus >>> %@", loginStatus);
	NSLog(@"Data Received");
	
	[loginStatus release];
	
	[connection release];
	[webdata release];
	
}

- (void)dealloc {
    [super dealloc];
}

@end
