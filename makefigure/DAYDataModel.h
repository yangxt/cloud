//
//  DAYDataModel.h
//  glpaint
//
//  Created by younkue on 2013. 12. 4..
//  Copyright (c) 2013년 daybrush. All rights reserved.
//

#import <Foundation/Foundation.h>

#define EMPTY @""
#define compare(a, b) [a isEqualToString:b]
#define ISEMPTY(a) [a isEqualToString:@""]


static NSArray* authToken;

@interface DAYDataModel : NSObject

-(NSDictionary*)objectAtIndex:(NSUInteger)index;
-(BOOL)loginCheck:(NSString *)userid withPassword:(NSString *)password;
- (BOOL) saveID:(NSString *)userid withPassword:(NSString *)password  withName:(NSString *)name ;
+(NSArray *)getToken;
@end

