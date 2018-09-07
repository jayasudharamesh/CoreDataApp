//
//  UploadPDFViewController.h
//  CoreDataApp
//
//  Created by Helina Devaraj on 9/3/18.
//  Copyright © 2018 Helina Devaraj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIManager.h"

@interface UploadPDFViewController : UIViewController
{
    int selectBtn;
    
    UITableView *tableViewList;
    int selectrow;
    
    UIDocumentPickerViewController *docPicker;
    UIImagePickerController *imagePicker;
    NSMutableArray *arrimg;
    
    NSString * UploadType;
    NSURL * PDFUrl;
}
@property (weak, nonatomic) IBOutlet UITableView *tblObj;
-(IBAction)selectedDays:(id)sender;
- (IBAction)submit:(id)sender;
@property (nonatomic) CGFloat previousContentOffset;

- (IBAction)choose:(id)sender;

@end
