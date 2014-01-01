//
//  DAYDataModel.m
//  glpaint
//
//  Created by younkue on 2013. 12. 4..
//  Copyright (c) 2013년 daybrush. All rights reserved.
//

#import "DAYDataModel.h"
#import "DAYAlert.h"
static NSMutableDictionary* _loginData;
@implementation DAYDataModel
{
    NSMutableArray* _itemArray;
    NSDictionary* _itemDictionary;
}

- (id)init
{
    self = [super init];
    if (self) {
        _itemArray = [@[@{ @"text": @"Super! Right Hand ne manque que to Regard", @"image": @"http://www.cssauthor.com/wp-content/uploads/2013/07/Blurred-Background_11.jpg" },
            @{ @"text": @"다른글", @"image": @"http://www.cssauthor.com/wp-content/uploads/2013/07/Blurred-Background_2.jpg" },
            @{ @"text": @"앗", @"image":@"http://www.cssauthor.com/wp-content/uploads/2013/07/Blurred-Background_5.jpg" }] mutableCopy];
        
        _itemDictionary = @{@"name" : @"younkue", @"age": @4, @"female" : @YES, @"array" : _itemArray };
    }
    _loginData = [[NSMutableDictionary alloc] initWithCapacity:2];
    
    [_loginData setObject:@"itoolsg" forKey:@"id"];
    [_loginData setObject:@"itoolsg" forKey:@"pwd"];
    return self;
}

-(BOOL)loginCheck:(NSString *)userid withPassword:(NSString *)password {
    if(ISEMPTY(userid)) {
        [DAYAlert showMessage:self withMessage:@"아이디를 입력해주세요"];
        NSLog(@"아이디를 입력해주세요.");
        return NO;
    }
    if(ISEMPTY(password)) {
        [DAYAlert showMessage:self withMessage:@"비밀번호를 입력해주세요"];
        NSLog(@"비밀번호를 입력해주세요.");
        return NO;
    }
    
    
    NSString *aURLString = @"http://localhost:8080/user/login_check.json";
    NSString *aFormData = [NSString stringWithFormat:@"userid=%@&password=%@",userid, password];
    NSURL *aURL = [NSURL URLWithString:aURLString];
    NSMutableURLRequest *aRequest =
    [NSMutableURLRequest requestWithURL:aURL];
    [aRequest setHTTPMethod:@"POST"];
    [aRequest setHTTPBody:
    [aFormData dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSHTTPURLResponse *aResponse;
    NSError *aError;
    NSData *aResultData = [NSURLConnection
                           sendSynchronousRequest:aRequest
                           returningResponse:&aResponse error:&aError];
    
    NSDictionary *dataArray = [NSJSONSerialization
                          JSONObjectWithData:aResultData
                          options:NSJSONReadingMutableContainers
                          error:nil];
    NSLog(@"%@", dataArray);
    
    if([dataArray objectForKey:@"err"]) {
        [DAYAlert showMessage:self withMessage:dataArray[@"desc"]];
        return NO;
    }
    //NSDictionary * loginData = [dataArray objectAtIndex:0];
    
    
    authToken = [NSHTTPCookie
                          cookiesWithResponseHeaderFields:[aResponse allHeaderFields]
                          forURL:[NSURL URLWithString:@""]];
    
    NSLog(@"AUTHTOKEN = %@", authToken);
    if(compare(@"404", dataArray[@"code"])) {
        [DAYAlert showMessage:self withMessage:@"옳지 않은 아이디입니다."];
        NSLog(@"옳지 않은 아이디입니다.1");
        return NO;
    }
    /*
    if(!compare(password, loginData[@"pwd"])) {
        [DAYAlert showMessage:self withMessage:@"옳지 않은 비밀번호입니다."];
        NSLog(@"옳지 않은 비밀번호입니다.");
        return NO;
    }
     */
    
    //Login
    NSLog(@"%@", @"성공.");
    return YES;
    
}


- (BOOL) saveID:(NSString *)userid withPassword:(NSString *)password  withName:(NSString *)name {
    NSString *aURLString = @"http://localhost:8080/user/join.json";
    NSString *aFormData = [NSString stringWithFormat:@"userid=%@&password=%@&name=%@",userid, password, name];
    NSURL *aURL = [NSURL URLWithString:aURLString];
    NSMutableURLRequest *aRequest =
    [NSMutableURLRequest requestWithURL:aURL];
    [aRequest setHTTPMethod:@"POST"];
    [aRequest setHTTPBody:
     [aFormData dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSHTTPURLResponse *aResponse;
    NSError *aError;
    NSData *aResultData = [NSURLConnection
                           sendSynchronousRequest:aRequest
                           returningResponse:&aResponse error:&aError];
    
    if(!aResultData){
        [DAYAlert showMessage:self withMessage:@"실패"];
        return NO;
    }
    NSDictionary *dataArray = [NSJSONSerialization
                               JSONObjectWithData:aResultData
                               options:NSJSONReadingMutableContainers
                               error:nil];
    NSLog(@"%@", dataArray);
    if(!dataArray || dataArray == [NSNull null]) {
        [DAYAlert showMessage:self withMessage:@"실패"];
        return NO;
    }
    if([dataArray objectForKey:@"err"]) {
        [DAYAlert showMessage:self withMessage:dataArray[@"desc"]];
        return NO;
    }
    
    return YES;

}


+ (NSArray *)getToken {
    return authToken;
}

- (NSDictionary*)objectAtIndex:(NSUInteger)index {
    return _itemArray[index];
}

-(NSString *) description {
    return _itemDictionary.description;
}
@end
