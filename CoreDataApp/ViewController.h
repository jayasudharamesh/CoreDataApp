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




@interface ViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UIButton *saveData_btn;
    IBOutlet UIButton *fetchResults_btn;
    IBOutlet UIButton *deleteData_btn;
    IBOutlet UIButton *updateData_btn;
    IBOutlet UIButton *emplistData_btn;
    IBOutlet UIButton *pdfData_btn;
}

@property (weak, nonatomic) IBOutlet UITextField *name_txt;
@property (weak, nonatomic) IBOutlet UITextField *number_txt;
@property (weak, nonatomic) IBOutlet UITextField *email_txt;
@property (weak, nonatomic) IBOutlet UITextField *location_txt;

@property (weak, nonatomic) IBOutlet UITextField *firstName_txt;
@property (weak, nonatomic) IBOutlet UITextField *lastName_txt;


- (IBAction)saveData:(id)sender;
- (IBAction)fetchResults:(id)sender;
- (IBAction)deleteData:(id)sender;
- (IBAction)updateData:(id)sender;
- (IBAction)employeeList:(id)sender;
- (IBAction)viewPDF:(id)sender;
- (IBAction)uploadPDF:(id)sender;

@end

