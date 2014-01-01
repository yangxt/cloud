//
//  WriteViewController.m
//  makefigure
//
//  Created by younkue on 2013. 11. 29..
//  Copyright (c) 2013년 daybrush. All rights reserved.
//

#import "WriteViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "DAYDataModel.h"
#import "DAYAlert.h"
#import "PostViewController.h"
#import "ListViewController.h"
@interface WriteViewController ()
{
    UIImage* aImage;
    UIImagePickerController *picker;
    int stage;
}
@end

@implementation WriteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _show_object_menu = true;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];


}

-(void)KeyboardNotification : (NSNotification *)notification {
    NSDictionary* info = [notification userInfo];
    CGRect endInfoKey = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //    [UIView animateWithDuration:1 animations:^{
    _scrollView.frame = CGRectMake(0, 63, self.view.frame.size.width,  endInfoKey.origin.y - 63);
    
    //endInfoKey
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:
     @selector(KeyboardNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:
     @selector(KeyboardNotification:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)didTap: (UITapGestureRecognizer *)rec
{
    [self.textTitle resignFirstResponder];
    [self.textContents resignFirstResponder];
    [self.scrollView resignFirstResponder];
    [self.imageAtt resignFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated {
    
    if(stage != 0) {
        if(aImage)
           [_imageAtt setImage:aImage];
     return;
    }
   stage = 1;
    picker
    = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self.navigationController
     presentViewController:picker animated:YES completion:^{
         NSLog(@"sss");
         
     }];
 
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)toggleMenu {
    _show_object_menu = !_show_object_menu;
    if(_show_object_menu) {
        self.view_menu_up.hidden = false;
        self.view_menu.hidden = false;
    } else {
        self.view_menu_up.hidden = true;
        self.view_menu.hidden = true;
    }
}

- (IBAction)savePost:(id)sender {
    NSString* postURL = @"http://localhost:8080/board/write.json";
    NSArray* token = [DAYDataModel getToken];
    if(!token || token == [NSNull null]) {
        [DAYAlert showMessage:self withMessage:@"다시 로그인해주세요."];
        [self.navigationController popViewControllerAnimated:TRUE];
        return;
    }
    
    if(compare(_textContents.text, @"") || compare(_textTitle.text, @"")) {
        [DAYAlert showMessage:self withMessage:@"글써주세요."];
        return;
    }
    NSURL *aURL = [NSURL URLWithString:postURL];

//    NSMutableURLRequest *wigiRequest =
//    [NSMutableURLRequest requestWithURL:postURL  cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
//    [wigiRequest setTimeoutInterval:30.0];
//
   NSMutableURLRequest *wigiRequest = [NSMutableURLRequest requestWithURL:aURL
                                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:30.0];
    [wigiRequest setHTTPMethod:@"POST"];
    NSString *stringBoundary = @"0xKhTmLbOuNdArY---This_Is_ThE_BoUnDaRyy---pqo";
    // header value
    NSString *headerBoundary = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",
                                stringBoundary];
    
    // set header
    [wigiRequest addValue:headerBoundary forHTTPHeaderField:@"Content-Type"];
    
    //add body
    NSMutableData *postBody = [NSMutableData data];
    NSLog(@"body made");
    //wigi access token

    NSDictionary* headers = [NSHTTPCookie requestHeaderFieldsWithCookies:token];
    
    
    //Title
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"title\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postBody appendData:[_textTitle.text dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
   
    //Contest
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"contents\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postBody appendData:[_textContents.text dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

    
    //image
    NSDate *now = [NSDate date];
    int CurrentTime = (int)(CACurrentMediaTime() * 10000.0);
    NSString * filename = [NSString stringWithFormat:@"item%d.jpg", CurrentTime];
    
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"\r\n", filename] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Type: image/jpeg\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Transfer-Encoding: binary\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // get the image data from main bundle directly into NSData object
    NSData *imgData = UIImageJPEGRepresentation(aImage, 1.0);

    // add it to body
    [postBody appendData:imgData];
    [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"message added");
    // final boundary
    [postBody appendData:[[NSString stringWithFormat:@"--%@--\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // add body to post
    [wigiRequest setHTTPBody:postBody];
    [wigiRequest setAllHTTPHeaderFields:headers];
    
    NSLog(@"body set");
    // pointers to some necessary objects
    NSHTTPURLResponse* response =[[NSHTTPURLResponse alloc] init];
    NSError* error = [[NSError alloc] init] ;
    
    // synchronous filling of data from HTTP POST response
    NSData *responseData = [NSURLConnection sendSynchronousRequest:wigiRequest returningResponse:&response error:&error];
    NSLog(@"just sent request");
    
//    if (error) {
//        NSLog(@"EROROROROR : %@");
//        return;
//    }
    NSLog(@"just 3");
    
    // convert data into string
    NSDictionary *dataArray = [NSJSONSerialization
                               JSONObjectWithData:responseData
                               options:NSJSONReadingMutableContainers
                               error:nil];
    
    if([dataArray objectForKey:@"err"]) {
        [DAYAlert showMessage:self withMessage:[dataArray objectForKey:@"desc"]];
        return;
    }
    
    if([dataArray objectForKey:@"id"]) {
//        [self.navigationController popViewControllerAnimated:TRUE];
//        PostViewController* postviewcontroller = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowPost"];
//        [postviewcontroller setPostId:(NSInteger) [dataArray objectForKey:@"id"]];
//        
//        [self.navigationController pushViewController:postviewcontroller animated:TRUE];
        NSArray* arr = self.navigationController.viewControllers;
        ListViewController* listController = [arr objectAtIndex:arr.count - 2];
        [listController setGoPostNum:[[dataArray objectForKey:@"id"]intValue] ];
        [listController setReadyGo];
        
        [self.navigationController popViewControllerAnimated:TRUE];

    } else {
        [DAYAlert showMessage:self withMessage:@"에러"];
        return;
    }
    /*NSString *responseString = [[NSString alloc] initWithBytes:[responseData bytes]
                                                         length:[responseData length]
                                                       encoding:NSUTF8StringEncoding];
    NSLog(@"done");
    // see if we get a welcome result
    NSLog(@"%@", responseString);

     //garbage collection
     [imgData release];
     [wigiURL release];
     [wigiRequest release];
     [stringBoundary release];
     [headerBoundary release];
     */
    
}

- (IBAction)cancelWrite:(id)sender {
    //[self dismissModalViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:true];
}



- (IBAction)showObjectMenu:(id)sender {
    [self toggleMenu];
}




- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 미디어 선택이 끝나고 난 이후
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(__bridge id)kUTTypeImage])
    {
        aImage = [info
                           objectForKey:UIImagePickerControllerOriginalImage];
        
        //NSLog(@"Image = %@", aImage);
        [_imageAtt setImage:aImage];
        
        
        UIAlertView *alertView1 = [[UIAlertView alloc] initWithTitle:@"이미지" message:@"골랐어요" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        alertView1.alertViewStyle = UIAlertViewStyleDefault;
        
        CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:aImage];
        editor.delegate = self;
        [picker pushViewController:editor animated:YES];

    }
    NSLog(@"End select");
}

- (void)imageEditor:(CLImageEditor *)editor
didFinishEdittingWithImage:(UIImage *)image
{
    aImage = image;
    [_imageAtt setImage:image];
    
    [editor dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController
                                        *)picker
{
    [picker dismissViewControllerAnimated:true completion:^{}];
    // 선택을 취소한 이후
    NSLog(@"Cancel select");
    //[self dismissModalViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:true];
    stage = -1;
}

- (IBAction)editImage:(id)sender {
    CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:aImage];
    editor.delegate = self;
    [self presentViewController:editor animated:YES completion:nil];
    
    

}
@end
