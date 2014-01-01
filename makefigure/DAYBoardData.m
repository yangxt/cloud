//
//  DAYBoardData.m
//  glpaint
//
//  Created by younkue on 2013. 12. 11..
//  Copyright (c) 2013년 daybrush. All rights reserved.
//

#import "DAYBoardData.h"
#import "ListViewController.h"
@implementation DAYBoardData 
{
    NSMutableData *_responseData;
    id parentSelf;
}

- (id)init:(id)sender {
    self = [super init];
    if (self) {
        parentSelf = sender;
        _responseData = [[NSMutableData alloc] initWithCapacity:10];
        NSString *aURLString = @"http://localhost:8080/board/getBoard.json";
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
    NSArray* resultArray = [NSJSONSerialization
                            JSONObjectWithData:_responseData
                            options:NSJSONReadingMutableContainers error:nil];
    //NSLog(@"array = %@", resultArray);
    [(ListViewController *)parentSelf saveBoardArray:resultArray];
    
    
}
@end
