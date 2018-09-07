//
//  ViewController.m
//  objcSendImage
//
//  Created by Досжан Калибек on 4/23/17.
//  Copyright © 2017 Doszhan Kalibek. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIDocumentPickerDelegate, UIDocumentMenuDelegate>
{
    UIDocumentPickerViewController *docPicker;
    UIImagePickerController *imagePicker;
    NSMutableArray *arrimg;
    
    NSString * UploadType;
    NSURL * PDFUrl;
}

@end

@implementation ViewController

UILabel *imageStatusLabel;
UIImageView *imageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildView];
}

- (void) buildView {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    UIView *imageContainerView = [[UIView alloc] initWithFrame:CGRectMake(
                                                                          0,
                                                                          0,
                                                                          screenWidth,
                                                                          450)];
    imageContainerView.layer.borderColor = [UIColor grayColor].CGColor;
    imageContainerView.layer.borderWidth = 1.0f;
    [self.view addSubview:imageContainerView];
    
    CGFloat currentY = 30;
    
    imageStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(
                                                                30,
                                                                currentY,
                                                                imageContainerView.frame.size.width - 60,
                                                                20)];
    imageStatusLabel.text = @"No image";
    imageStatusLabel.textAlignment = NSTextAlignmentCenter;
    [imageContainerView addSubview:imageStatusLabel];
    currentY += imageStatusLabel.frame.size.height + 20;
    
    UIButton *selectImageButton = [[UIButton alloc] initWithFrame:CGRectMake(
                                                                      (screenWidth - 200)/2,
                                                                      currentY,
                                                                      200,
                                                                      30)];
    [selectImageButton setTitle:@"Select image" forState:UIControlStateNormal];
    selectImageButton.showsTouchWhenHighlighted = true;
    selectImageButton.backgroundColor = [UIColor grayColor];
    [selectImageButton addTarget:self action:@selector(selectImage:) forControlEvents:UIControlEventTouchUpInside];
    [imageContainerView addSubview:selectImageButton];
    currentY += selectImageButton.frame.size.height + 20;
    
    UIButton *takePhotoButton = [[UIButton alloc] initWithFrame:CGRectMake(
                                                                             (screenWidth - 200)/2,
                                                                             currentY,
                                                                             200,
                                                                             30)];
    [takePhotoButton setTitle:@"Take photo" forState:UIControlStateNormal];
    takePhotoButton.showsTouchWhenHighlighted = true;
    takePhotoButton.backgroundColor = [UIColor grayColor];
    [takePhotoButton addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [imageContainerView addSubview:takePhotoButton];
    currentY += takePhotoButton.frame.size.height + 20;

    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(
                                                              30,
                                                              currentY,
                                                              imageContainerView.frame.size.width - 60,
                                                              200)];
    imageView.backgroundColor = [UIColor grayColor];
    [imageContainerView addSubview:imageView];
    currentY += imageView.frame.size.height + 20;
    
    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectMake(
                                                                      (screenWidth - 200)/2,
                                                                      currentY,
                                                                      200,
                                                                      30)];
    [sendButton setTitle:@"Send image" forState:UIControlStateNormal];
    sendButton.showsTouchWhenHighlighted = true;
    sendButton.backgroundColor = [UIColor grayColor];
    [sendButton addTarget:self action:@selector(sendImage:) forControlEvents:UIControlEventTouchUpInside];
    [imageContainerView addSubview:sendButton];
}

- (void) selectImage:(UIButton *) sender {
    NSLog(@"selectImage");
    UIImagePickerController *pickerViewController = [[UIImagePickerController alloc] init];
    pickerViewController.allowsEditing = YES;
    pickerViewController.delegate = self;
    [pickerViewController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:pickerViewController animated:YES completion:nil];
}

- (void) takePhoto:(UIButton *) sender {
    NSLog(@"takePhoto");
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *pickerViewController =[[UIImagePickerController alloc]init];
        pickerViewController.allowsEditing = YES;
        pickerViewController.delegate = self;
        pickerViewController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:pickerViewController animated:YES completion:nil];
    } else {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Camera is not available" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void) sendImage:(UIButton *) sender {
    NSLog(@"sendImage");
    
    imageStatusLabel.text = @"Image is uploading";
    
    UIImage *yourImage= imageView.image;
    NSData *imageData = UIImagePNGRepresentation(yourImage);
    NSString *postLength = [NSString stringWithFormat:@"%d", (int)[imageData length]];
    
    NSLog(@"%@",imageData);
    int imgSize = imageData.length;
    NSLog(@"SIZE OF IMAGE: %.2f Kb", (float)imgSize/1024);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"POST"];
    [request setURL:[NSURL URLWithString:@"http://52.74.228.143:808/EmployeeServices/EmployeeClaimsService.svc/ClaimPhotoUpload?EmployeeId=IKYA004&ClaimId=189178&ClaimdtlId=441889&Remarks="]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:imageData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      if (data == nil) {
                                          [self printCannotLoad];
                                           NSLog(@"fail");
                                      } else {
                                          [self printSuccess];
                                          NSLog(@"success");
                                      }
                                  }];
    [task resume];
}

- (void) printCannotLoad {
    dispatch_sync(dispatch_get_main_queue(), ^{
        imageStatusLabel.text = @"Cannot upload";
    });
}

- (void) printSuccess {
    dispatch_sync(dispatch_get_main_queue(), ^{
        imageStatusLabel.text = @"Successfully uploaded";
    });
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [self dismissViewControllerAnimated:picker completion:nil];
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    imageView.image = image;
    imageStatusLabel.text = @"Image imported into the app";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Open Document Picker(Delegate) for PDF, DOC Slection from iCloud


- (void)showDocumentPickerInMode:(UIDocumentPickerMode)mode
{
    
    UIDocumentMenuViewController *picker =  [[UIDocumentMenuViewController alloc] initWithDocumentTypes:@[@"com.adobe.pdf"] inMode:UIDocumentPickerModeImport];
    
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}


-(void)documentMenu:(UIDocumentMenuViewController *)documentMenu didPickDocumentPicker:(UIDocumentPickerViewController *)documentPicker
{
    documentPicker.delegate = self;
    [self presentViewController:documentPicker animated:YES completion:nil];
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller
  didPickDocumentAtURL:(NSURL *)url
{
    PDFUrl= url;
    UploadType=@"PDF";
//    [arrimg removeAllObjects];
    [arrimg addObject:url];
    
    
}
-(void)chooseDocument{
    [self showDocumentPickerInMode:UIDocumentPickerModeOpen];
}

- (IBAction)selectPDF:(id)sender
{
    [self chooseDocument];
    
}

- (IBAction)submitPDF:(id)sender {

    NSURLRequest *request1=[NSURLRequest requestWithURL:PDFUrl];
    NSData *data=[NSData dataWithContentsOfURL:PDFUrl options:nil error:nil];
    NSLog(@"%@",data);
    int imgSize = data.length;
    NSLog(@"SIZE OF IMAGE: %.2f Kb", (float)imgSize/1024);
    
//    [pdfData writeToFile:pathToFile2 atomically:YES];
    /*
    [data writeToURL:PDFUrl options:nil error:nil];
    
    */
    
    
    UIImage *yourImage= imageView.image;
    NSData *imageData = UIImagePNGRepresentation(yourImage);
    NSString *postLength = [NSString stringWithFormat:@"%d", (int)[imageData length]];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"POST"];
    [request setURL:[NSURL URLWithString:@"http://52.74.228.143:808/EmployeeServices/EmployeeClaimsService.svc/ClaimPhotoUpload?EmployeeId=IKYA004&ClaimId=189178&ClaimdtlId=441889&Remarks="]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:data];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      if (data == nil) {
                                          [self printCannotLoad];
                                          NSLog(@"fail");
                                      } else {
                                          [self printSuccess];
                                          NSLog(@"success");
                                      }
                                  }];
    [task resume];
    
}
@end
