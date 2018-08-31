//
//  PdfViewController.m
//  CoreDataApp
//
//  Created by Helina Devaraj on 7/31/18.
//  Copyright © 2018 Helina Devaraj. All rights reserved.
//

#import "PdfViewController.h"

@interface PdfViewController ()
{
    NSString *downloadFilePath;
    NSURL *targetURL;

}

@end

@implementation PdfViewController
@synthesize animationView,animateButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    QLPreviewController *previewController = [[QLPreviewController alloc] init];
    previewController.dataSource = self;
    previewController.delegate=self;
//    [[self navigationController] pushViewController:previewController animated:YES];
    
    NSString *url=[NSString stringWithFormat:@"http://45.118.183.245:81/Letters/Form16/T-4102.pdf"];

    targetURL = [NSURL URLWithString:url];
    NSData *dataPdf = [NSData dataWithContentsOfURL:targetURL];
    
    
    
    //Get path directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //Create PDF_Documents directory
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"Documents"];
    [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    
    downloadFilePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"file.pdf"];
    
    [dataPdf writeToFile:downloadFilePath atomically:YES];
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[dataPdf] applicationActivities:nil];

//    [self presentViewController:activityViewController animated:YES completion:nil];
    
    
    //core animation
    
    /*
    
    [UIView animateWithDuration:3.0 animations:^{
        [self.animationView setCenter:CGPointMake(200, 300)];
    }];
    
  
     [UIView animateKeyframesWithDuration:3.0
                                    delay:0.0
                                  options:(UIViewAnimationCurveEaseInOut | UIViewAnimationOptionAutoreverse)
                               animations:^{
                                   [self.animateButton setCenter:CGPointMake(100, 100)];
                               }
                               completion:nil];
    
    */
    
    self.animateButton.layer.cornerRadius=self.animateButton.frame.size.width/2;
    self.animateButton.clipsToBounds = YES;
    
    self.animationView.layer.cornerRadius=self.animationView.frame.size.width/2;
    self.animationView.clipsToBounds = YES;
    
    CGRect boundingRect = CGRectMake(-120, -120, 250, 350);
    CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
    orbit.keyPath = @"position";
    orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
    orbit.duration = 4;
    orbit.additive = YES;
    orbit.repeatCount = HUGE_VALF;
    orbit.calculationMode = kCAAnimationPaced;
    orbit.rotationMode = kCAAnimationRotateAuto;
    
    [self.animateButton.layer addAnimation:orbit forKey:@"orbit"];
    
    
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

#pragma pdfviewer Delegates

- (NSInteger) numberOfPreviewItemsInPreviewController: (QLPreviewController *) controller
{
    return 1;
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    
    return [NSURL fileURLWithPath:downloadFilePath]; // here is self.pdfFilePath its a path of you pdf
    
}
- (IBAction)animate:(id)sender {
}
@end
