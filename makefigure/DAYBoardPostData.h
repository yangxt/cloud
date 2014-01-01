//
//  DAYBoardPostData.h
//  glpaint
//
//  Created by younkue on 2013. 12. 31..
//  Copyright (c) 2013년 daybrush. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAYBoardPostData : NSObject <NSURLConnectionDataDelegate>

- (id)init:(id)sender withId:(NSInteger) postId ;
@end
