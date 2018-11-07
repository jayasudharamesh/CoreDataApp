//
//  ViewController.h
//  CoreDataApp
//
//  Created by Helina Devaraj on 7/30/18.
//  Copyright © 2018 Helina Devaraj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import <MessageUI/MessageUI.h>

#import <CFNetwork/CFNetwork.h>




@interface ViewController : UIViewController<UITextFieldDelegate,MFMailComposeViewControllerDelegate>
{
    IBOutlet UIButton *saveData_btn;
    IBOutlet UIButton *fetchResults_btn;
    IBOutlet UIButton *deleteData_btn;
    IBOutlet UIButton *updateData_btn;
    IBOutlet UIButton *emplistData_btn;
    IBOutlet UIButton *pdfData_btn;
    
    IBOutlet UIButton *newSignIn_btn;
    
//    SKPSMTPMessage *testMsg;
}

@property (weak, nonatomic) IBOutlet UITextField *name_txt;
@property (weak, nonatomic) IBOutlet UITextField *number_txt;
@property (weak, nonatomic) IBOutlet UITextField *email_txt;
@property (weak, nonatomic) IBOutlet UITextField *location_txt;

@property (weak, nonatomic) IBOutlet UITextField *firstName_txt;
@property (weak, nonatomic) IBOutlet UITextField *lastName_txt;
@property (weak, nonatomic) IBOutlet UIButton *dynamicbtn;

@property (weak, nonatomic) IBOutlet UILabel *localized_Lbl;

- (IBAction)saveData:(id)sender;
- (IBAction)fetchResults:(id)sender;
- (IBAction)deleteData:(id)sender;
- (IBAction)updateData:(id)sender;
- (IBAction)employeeList:(id)sender;
- (IBAction)viewPDF:(id)sender;
- (IBAction)uploadPDF:(id)sender;
- (IBAction)scrollView_btn:(id)sender;
- (IBAction)dynamic_View:(id)sender;
- (IBAction)radioButton:(id)sender;
- (IBAction)sendEmail:(id)sender;
- (IBAction)signInWithFB:(id)sender;

@end

