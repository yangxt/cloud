//
//  DAYBoardPostData.m
//  glpaint
//
//  Created by younkue on 2013. 12. 31..
//  Copyright (c) 2013년 daybrush. All rights reserved.
//

#import "DAYBoardPostData.h"
#import "PostViewController.h"

@implementation DAYBoardPostData
{
NSMutableData *_responseData;
id parentSelf;
}

- (id)init:(id)sender withId:(int) postId {
    self = [super init];
    if (self) {
        parentSelf = sender;
        _responseData = [[NSMutableData alloc] initWithCapacity:10];
        NSLog(@"POSTNUM = %d", postId);
        NSString *aURLString = [NSString stringWithFormat:@"http://localhost:8080/board/%d.json", postId];
        NSURL *aURL = [NSURL URLWithString:aURLString];
        NSMutableURLRequest *aRequest = [NSMutableURLRequest
                                         requestWithURL:aURL];
        
        [aRequest setHTTPMethod:@"POST"];
        
        
        NSURLConnection *connection = [[NSURLConnection alloc]
                                       initWithRequest:aRequest delegate:self startImmediately:YES];
        
        
    }
    return self;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:
(NSData *)data
{
    
    [_responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary* resultArray = [NSJSONSerialization
                            JSONObjectWithData:_responseData
                            options:NSJSONReadingMutableContainers error:nil];
    //NSLog(@"array = %@", resultArray);
    [(PostViewController *)parentSelf setPost:resultArray];
    
    
}
@end
