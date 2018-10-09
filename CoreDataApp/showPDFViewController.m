//
//  showPDFViewController.m
//  CoreDataApp
//
//  Created by Helina Devaraj on 9/10/18.
//  Copyright © 2018 Helina Devaraj. All rights reserved.
//

#import "showPDFViewController.h"

@interface showPDFViewController ()<UIWebViewDelegate>

@end

@implementation showPDFViewController
@synthesize webviewObj;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
//    NSArray *imageExtension=@[@"png",@"pdf",@"jpg"];
//    NSString *str=str_image;
//    for (NSTextCheckingResult *result in str) {
//        NSURL *url =[result URL];
//        NSString *extension=[url pathExtension];
//        if ([imageExtension containsObject:extension]) {
//            NSLog(@"%@",url);
//        }
//    }
    
    NSString *strURL=[NSString stringWithFormat:@"https://s3-ap-southeast-1.amazonaws.com/inedge/user/claims/IKYA004ClaimFinal_441903_2018-09-10_10-40-22.pdf"];
    
    NSURL *imageURL = [NSURL fileURLWithPath:strURL];
//    NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
//    [webviewObj loadRequest:request];
//    webviewObj.delegate=self;
    
    
    NSURL * payoutUrl = [NSURL URLWithString:strURL];
    NSURLRequest *payoutViewRequest= [NSURLRequest requestWithURL:payoutUrl];
    NSData *pdfData = [NSData dataWithContentsOfURL:payoutUrl ];
  
    // [pdfViewer loadData:pdfData MIMEType:@"application/pdf" textEncodingName:@"utf-8" baseURL:nil];
    [webviewObj loadRequest:payoutViewRequest];
    
    [webviewObj setUserInteractionEnabled:YES];
    [webviewObj setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
