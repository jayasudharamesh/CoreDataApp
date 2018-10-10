//
//  ViewController.m
//  CoreDataApp
//
//  Created by Helina Devaraj on 7/30/18.
//  Copyright © 2018 Helina Devaraj. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "EmployeeListViewController.h"
#import "PdfViewController.h"
#import "CaptionForPhotoViewController.h"
#import "UploadPDFViewController.h"
#import "ScrollViewController.h"
#import "DynamicViewController.h"
#import "ActivityListViewController.h"
#import "RadioViewController.h"

API_AVAILABLE(ios(10.0))
@interface ViewController ()
{
    AppDelegate *appDelegate;
    NSManagedObjectContext *context;
    NSArray *arr_saveData;
    NSArray *arr_Results;
    NSManagedObject *transaction;
    NSManagedObject *transactionUser;
}
@end

@implementation ViewController
@synthesize name_txt,number_txt,email_txt,location_txt;
@synthesize firstName_txt,lastName_txt;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    if (@available(iOS 10.0, *)) {
        appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    } else {
        // Fallback on earlier versions
    }
    context=appDelegate.persistentContainer.viewContext;
    
    
    name_txt.delegate=self;
    number_txt.delegate=self;
    email_txt.delegate=self;
    location_txt.delegate=self;
    arr_Results=[[NSArray alloc]init];
    
    name_txt.hidden=YES;
    number_txt.hidden=YES;
    email_txt.hidden=YES;
    location_txt.hidden=YES;
    firstName_txt.hidden=YES;
    lastName_txt.hidden=YES;
    
    saveData_btn.hidden=YES;
    fetchResults_btn.hidden=YES;
    deleteData_btn.hidden=YES;
    updateData_btn.hidden=YES;
//    emplistData_btn.hidden=YES;
    pdfData_btn.hidden=YES;
   

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
- (IBAction)saveData:(id)sender {
    
    
    transaction = [NSEntityDescription insertNewObjectForEntityForName:@"EmpContact" inManagedObjectContext:context];
    
    
    [transaction setValue:self.name_txt.text forKey:@"empname"];
    [transaction setValue:self.email_txt.text forKey:@"empemail"];
    [transaction setValue:self.number_txt.text forKey:@"empnumber"];
    [transaction setValue:self.location_txt.text forKey:@"emplocation"];
    // Create Another Person

    transactionUser = [NSEntityDescription insertNewObjectForEntityForName:@"UserAccount" inManagedObjectContext:context];
    // Set First and Last Name
    [transactionUser setValue:self.firstName_txt.text forKey:@"firstName"];
    [transactionUser setValue:self.lastName_txt.text forKey:@"lastName"];
   
    [appDelegate saveContext];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Save Failed! %@ %@", error, [error localizedDescription]);
    }
    
    //Refreshing an Object
    
    [context refreshObject:transaction mergeChanges:YES];

   
    
  
    
    /*
     VenueInfo *venueInfo=[NSEntityDescription   insertNewObjectForEntityForName:@"VenueInfo" inManagedObjectContext:self.managedObjectContext];
     vanueInfo.name=txtVenueName.text;           // venue name entry
     
     
     ContactInfo *contactInfo=[NSEntityDescription   insertNewObjectForEntityForName:@"ContactInfo" inManagedObjectContext:self.managedObjectContext];
     
     contactInfo.phone=txtPhone.text;
     contactInfo.email=txtEmail.text;
     contactInfo.venue=venueInfo;
     
     */
   
}

- (IBAction)fetchResults:(id)sender {
    NSFetchRequest *fetchResults=[NSFetchRequest fetchRequestWithEntityName:@"EmpContact"];
    arr_Results=[context executeFetchRequest:fetchResults error:nil];
    
    
    NSLog(@"%@",[arr_Results valueForKey:@"empname"]);
    NSLog(@"%@",[arr_Results valueForKey:@"empemail"]);
    NSLog(@"%@",[arr_Results valueForKey:@"empnumber"]);
    NSLog(@"%@",[arr_Results valueForKey:@"emplocation"]);
    
    
    NSFetchRequest *fetchResultsUser=[NSFetchRequest fetchRequestWithEntityName:@"UserAccount"];
    NSArray *arr_ResultsUser=[context executeFetchRequest:fetchResultsUser error:nil];
    
    NSLog(@"%@",[arr_ResultsUser valueForKey:@"firstName"]);
    NSLog(@"%@",[arr_ResultsUser valueForKey:@"lastName"]);
    
    
//    [fetchResults setValue:fetchResultsUser forKey:@"useraccount"];
//     fetchResultsUser.venue=venueInfo
    
    if ([[arr_Results valueForKey:@"empname"] count]==0) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Message" message:@"No data" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^ (UIAlertAction *action)
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
    
        self.name_txt.text=[arr_Results valueForKey:@"empname"][0];
        self.email_txt.text=[arr_Results valueForKey:@"empemail"][0];
        self.number_txt.text=[arr_Results valueForKey:@"empnumber"][0];
        self.location_txt.text=[arr_Results valueForKey:@"emplocation"][0];
        
        self.firstName_txt.text=[arr_ResultsUser valueForKey:@"firstName"][0];
        self.lastName_txt.text=[arr_ResultsUser valueForKey:@"lastName"][0];
        
        
        
        
    }
    
    
}

- (IBAction)deleteData:(id)sender {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"EmpContact" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"empname like %@",self.name_txt.text];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    
    NSError *error;
    NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
    
    NSLog(@"%@",items);
    
    for (NSManagedObject *managedObject in items)
    {
        [context deleteObject:managedObject];
        self.name_txt.text=@"";
        self.email_txt.text=@"";
        self.number_txt.text=@"";
        self.location_txt.text=@"";
        self.firstName_txt.text=@"";
        self.lastName_txt.text=@"";
        [appDelegate saveContext];
    }
    
}

- (IBAction)updateData:(id)sender {
    
    [self updateDataInDataBase: self.name_txt.text WithCity:self.location_txt.text withemail:self.email_txt.text withNumber:self.number_txt.text];
    [self updateUserData:self.firstName_txt.text lastName:self.lastName_txt.text];
    [appDelegate saveContext];
}

- (IBAction)employeeList:(id)sender
{
    /*
    NSFetchRequest *fetchResults=[NSFetchRequest fetchRequestWithEntityName:@"EmpContact"];
    arr_Results=[context executeFetchRequest:fetchResults error:nil];
    
    EmployeeListViewController *empListVC=[self.storyboard instantiateViewControllerWithIdentifier:@"empListVC"];
    empListVC.arr_employeeNameList=[arr_Results valueForKey:@"empname"];
    [self.navigationController pushViewController:empListVC animated:YES];
    
   */
    
    CaptionForPhotoViewController *empListVC=[self.storyboard instantiateViewControllerWithIdentifier:@"photoCaption"];
    [self.navigationController pushViewController:empListVC animated:YES];
}

- (IBAction)viewPDF:(id)sender {
    //pdfVC
    
    PdfViewController *pdfVC=[self.storyboard instantiateViewControllerWithIdentifier:@"pdfVC"];
    [self.navigationController pushViewController:pdfVC animated:YES];
   /*
    
    NSString *url=[NSString stringWithFormat:@"http://45.118.183.245:81/Letters/Form16/T-4102.pdf"];
    
    NSURL *targetURL = [NSURL URLWithString:url];
    NSData *dataPdf = [NSData dataWithContentsOfURL:targetURL];
    
    
   
//    NSString *texttoshare = @"myURL"; //this is your text string to share
    NSArray *activityItems = @[dataPdf];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypePrint];
    [self presentViewController:activityVC animated:TRUE completion:nil];
    
 */
    
}

- (IBAction)uploadPDF:(id)sender
{
    //http://52.74.228.143:808/CustomerServices/CustomerService.svc/addpolicy?EmpId=ADMTEST&FolderName=Incentive&PolicyName=sdsh&Policypath=https://s3-ap-southeast-1.amazonaws.com/inedge/user/attachments/Q2aLzEa6-421800_31_2017_6788DiscoverInsurance.pdf&CustomerId=TEST&Status=0&IsActive=true
    
    
    UploadPDFViewController *pdfVC=[self.storyboard instantiateViewControllerWithIdentifier:@"uploadPDF"];
    [self.navigationController pushViewController:pdfVC animated:YES];
    
    
    
}

- (IBAction)scrollView_btn:(id)sender {
    
    ScrollViewController *pdfVC=[self.storyboard instantiateViewControllerWithIdentifier:@"scrollViewVC"];
    [self.navigationController pushViewController:pdfVC animated:YES];
}

- (IBAction)dynamic_View:(id)sender
{
    
    ActivityListViewController *dynamicVC=[self.storyboard instantiateViewControllerWithIdentifier:@"activityListVC"];
    [self.navigationController pushViewController:dynamicVC animated:YES];
}

- (IBAction)radioButton:(id)sender
{
    
    RadioViewController *dynamicVC=[self.storyboard instantiateViewControllerWithIdentifier:@"radioButtonVC"];
    [self.navigationController pushViewController:dynamicVC animated:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
   
    [textField resignFirstResponder];
    return YES;
    
}
-(void)updateDataInDataBase:(NSString *)name WithCity:(NSString *)city withemail:(NSString *)emailID withNumber:(NSString *)mobileNumber
{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"EmpContact" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *arrResult = [context executeFetchRequest:fetchRequest error:&error];
    [arrResult setValue:name forKey:@"empname"];
    [arrResult setValue:emailID forKey:@"empemail"];
    [arrResult setValue:mobileNumber forKey:@"empnumber"];
    [arrResult setValue:city forKey:@"emplocation"];
    NSLog(@"object edited");
    
    if (![context save:&error]) {
        NSLog(@"Error editing  - error:%@",error);
    }
}

-(void)updateUserData:(NSString *)firstName lastName:(NSString *)lastName
{
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc]init];
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"UserAccount" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *arr_userDetails=[context executeFetchRequest:fetchRequest error:&error];
    [arr_userDetails setValue:self.firstName_txt.text forKey:@"firstName"];
    [arr_userDetails setValue:self.lastName_txt.text forKey:@"lastName"];
   
    if (![context save:&error]) {
        NSLog(@"Error editing  - error:%@",error);
    }
}
@end
