//
//  UploadPDFViewController.m
//  CoreDataApp
//
//  Created by Helina Devaraj on 9/3/18.
//  Copyright © 2018 Helina Devaraj. All rights reserved.
//

#import "UploadPDFViewController.h"
#import "NewTableViewCell.h"
#import "showPDFViewController.h"

@interface UploadPDFViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UIDocumentPickerDelegate, UIDocumentMenuDelegate>
{
    NSArray *arr_days,*arr_status,*arr_names;
    NewTableViewCell *tempcell;
    NSMutableDictionary *dict;
    NSMutableArray *indexarr;
    NSMutableArray *arr;
    
    UIPickerView *myPickerView;
    UIToolbar *toolBar;
    UIBarButtonItem *barButtonDone;
    NSArray *selectArray;
    int selectIndex;
    NSMutableDictionary *myDict1;
    NSMutableDictionary *amounts;
    UILabel *lblname;
    UIButton *button;
    UIButton *button1;
    UITextField *txtfield;
    NSString *labelString,*textFieldString;
    
    showPDFViewController *showpdfVC;
}

@end

@implementation UploadPDFViewController
@synthesize tblObj;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    arr_names=[[NSArray alloc]initWithObjects:@"12",@"22",@"23",@"24", nil];
    arr_days=[[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4", nil];
    arr_status=[[NSArray alloc]initWithObjects:@"resigned",@"inactive", nil];
    tblObj.delegate=self;
    tblObj.dataSource=self;
    [tblObj reloadData];
    dict=[[NSMutableDictionary alloc]init];
    amounts=[[NSMutableDictionary alloc]init];
    selectArray=[[NSArray alloc]init];
    
    arrimg =[[NSMutableArray alloc]init];
   
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                                          action:@selector(dismissKeyboard)];
//
//    [self.view addGestureRecognizer:tap];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    tableViewList.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
//
//    tableViewList.hidden = UIScrollViewKeyboardDismissModeInteractive;
    
}
-(void)dismissKeyboard {
//    [aTextField resignFirstResponder];
    
//    tableViewList.hidden=YES;
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
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    tableViewList.hidden=YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
  if (tableView==tblObj) {
         return arr_names.count;
   }else
        if (selectBtn==0) {
            selectBtn=0;
            return arr_days.count;
        }else
            selectBtn=1;
            return arr_status.count;

   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
   
    
    if (tableView==tblObj) {
        tempcell=(NewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"uploadCell"];
        if(tempcell==nil){
            tempcell=[[NSBundle mainBundle]loadNibNamed:@"NewTableViewCell" owner:self options:nil].lastObject;
        }
        
        tempcell.days_btn.delegate=self;
        tempcell.status_btn.delegate=self;
        tempcell.days_btn.tag=indexPath.row;
        tempcell.status_btn.tag=indexPath.row;
        tempcell.name_Lbl.tag=indexPath.row;
        tempcell.days_btn.hidden=YES;
        tempcell.status_btn.hidden=YES;
    
        
//         [tempcell.btn_days addTarget:self action:@selector(selectedDays:) forControlEvents:UIControlEventTouchUpInside];
//        [tempcell.btn_status addTarget:self action:@selector(selectedstatus:) forControlEvents:UIControlEventTouchUpInside];
        
    
    lblname  = (UILabel *)    [tempcell name_Lbl];
    lblname.tag =100;
    
    button = (UIButton *)[tempcell btn_days];
    button.tag =indexPath.row;
    tempcell.days_btn.enabled = YES;
    [button addTarget:self  action:@selector(selectedDays:)  forControlEvents:UIControlEventTouchUpInside];

     lblname.text=[arr_names objectAtIndex:indexPath.row];
    
    if ([amounts valueForKey:lblname.text] != nil) {
        button.titleLabel.text = [amounts valueForKey:lblname.text];
        NSLog(@"%@",amounts);
       
    } else {
        button.titleLabel.text=@"";
       
        
    }
    
        UILabel* lblname1  = (UILabel *)    [tempcell name_Lbl];
        lblname1.tag =100;
        
        button1 = (UIButton *)[tempcell btn_status];
        button1.tag =indexPath.row;
        
        tempcell.status_btn.enabled = YES;
        
        [button1 addTarget:self action:@selector(selectedstatus:) forControlEvents:UIControlEventTouchUpInside];
        lblname1.text=[arr_names objectAtIndex:indexPath.row];
        
        if ([dict valueForKey:lblname.text] != nil) {
            [button1 setTitle:[dict valueForKey:lblname.text] forState:UIControlStateNormal];
            NSLog(@"%@",dict);
            
            
        } else {
            
            [button1 setTitle:@"Active" forState:UIControlStateNormal];
            
            
            
        }
   
        
        
        return tempcell;
    }else if (tableView==tableViewList)
    {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        if (selectBtn==0) {
            cell.textLabel.text=[arr_days objectAtIndex:indexPath.row];
        }else if (selectBtn==1)
        {
            cell.textLabel.text=[arr_status objectAtIndex:indexPath.row];
        }
        return cell;
    }else
        return nil;
    

   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
  
    
    for (int i=0; i<[arr_names count]; i++) {
        
        
    }
    
    
    if (tableView==tblObj) {
        
    }else if (tableView==tableViewList)
    {
        if (selectBtn==0) {
            selectBtn=0;
            
            [tempcell.btn_days setTitle:[arr_days objectAtIndex:indexPath.row] forState:UIControlStateNormal];
            NSString *buttonTitle=tempcell.btn_days.currentTitle;
            tempcell.days_btn.text=[arr_days objectAtIndex:indexPath.row];
            [dict setObject:buttonTitle forKey:[arr_names objectAtIndex:selectrow]];
            
          
            tableViewList.hidden=NO;
            [tableViewList reloadData];
             tableViewList.hidden=YES;
            
        }else
        {
             selectBtn=1;
            [tempcell.btn_status setTitle:[arr_status objectAtIndex:indexPath.row] forState:UIControlStateNormal];
            NSString *buttonTitle=tempcell.btn_status.currentTitle;
            tempcell.days_btn.text=[arr_days objectAtIndex:indexPath.row];
            [dict setObject:buttonTitle forKey:[arr_names objectAtIndex:selectrow]];
        
            tableViewList.hidden=NO;
            [tableViewList reloadData];
             tableViewList.hidden=YES;
            
        }
        
        NSLog(@"%@",dict);
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 120;
    
}


-(IBAction)selectedDays:(UIButton *)sender
{
    selectBtn=0;
    
 
    tableViewList=[[UITableView alloc]init];
    tableViewList.frame = CGRectMake(80,200,80,150);
    tableViewList.dataSource=self;
    tableViewList.delegate=self;
    tableViewList.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [tableViewList registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    tableViewList.layer.borderColor = [UIColor lightGrayColor].CGColor;
    tableViewList.layer.borderWidth = 0.8;
    
    [self.view addSubview:tableViewList];
 
    
    tableViewList.hidden=NO;
    [tableViewList reloadData];
    
    
    selectrow=(int)[sender tag];
    NSLog(@"tag %d",selectrow);

   
    
    NSLog(@"tag number is = %ld",(long)[sender tag]);
    selectArray=[arr_days objectAtIndex:[sender tag]];
   
    NSLog(@"%@",selectArray);
    tempcell.btn_days = (UIButton *)sender;
   
    
}

-(IBAction)selectedstatus:(id)sender{
    selectBtn=1;
    selectrow=(int)[sender tag];
    
    tableViewList=[[UITableView alloc]init];
    tableViewList.frame = CGRectMake(150,200,150,150);
    tableViewList.dataSource=self;
    tableViewList.delegate=self;
    tableViewList.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [tableViewList registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    tableViewList.layer.borderColor = [UIColor lightGrayColor].CGColor;
    tableViewList.layer.borderWidth = 0.8;

    [self.view addSubview:tableViewList];
    
    
    tableViewList.hidden=NO;
    [tableViewList reloadData];
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    tableViewList.hidden=NO;
    // Here You can do additional code or task instead of writing with keyboard
    return NO;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat currentContentOffset = scrollView.contentOffset.y;
    
    if (currentContentOffset > self.previousContentOffset) {
        // scrolling towards the bottom
        [tableViewList setHidden:YES];
    } else if (currentContentOffset < self.previousContentOffset) {
        // scrolling towards the top
        [tableViewList setHidden:YES];
    }
    self.previousContentOffset = currentContentOffset;
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
    [arrimg removeAllObjects];
    [arrimg addObject:url];
    
    
}
#pragma mark- Choose File or Image
- (IBAction)browseFile:(id)sender
{
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select Photo option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Take Photo ",
                            @"Choose Existing",@"Document",nil];
    
    popup.tag = 1;
    [popup showInView:[UIApplication sharedApplication].keyWindow];
}
-(void)choosePhoto{
    
    imagePicker = [[UIImagePickerController alloc] init];
    
    imagePicker.delegate = self;
    
    [[UINavigationBar appearance] setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}
-(void)chooseDocument{
     [self showDocumentPickerInMode:UIDocumentPickerModeOpen];
}
- (IBAction)submit:(id)sender
{
    NSLog(@"%@",dict);
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped do nothing.
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Take photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // take photo button tapped.
        //        [self takePhoto];
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Choose photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // choose photo button tapped.
                [self choosePhoto];
        
        
        
       
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Choose Document" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        // Distructive button tapped.
                [self chooseDocument];
        
       
        
    }]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}
#pragma mark - Upload Image

-(void)uploadimage
{
    //loader start
    APIManager *obj =[[APIManager alloc]init];
    [obj setDelegate:(id)self];
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    [dict setValue:@"SOME PARAMETER" forKey:@"type"];
    [dict setValue:@"SOME PARAMETER" forKey:@"title"];
    
    NSString *urlString = [NSString stringWithFormat:@"%@",@"API URL"];
    NSURL *url =[NSURL URLWithString:urlString];
    [obj startRequestForImageUploadingWithURL:url withRequestType:(kAPIManagerRequestTypePOST) withDataDictionary:dict arrImage:arrimg CalledforMethod:imageupload index:0 isMultiple:NO str_imagetype:@"image"];
}
#pragma mark - Upload PDF

-(void)uploadpdf
{
    
    
    APIManager *obj =[[APIManager alloc]init];
    [obj setDelegate:(id)self];
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    [dict setValue:@"SOME PARAMETER" forKey:@"type"];
    [dict setValue:@"SOME PARAMETER" forKey:@"title"];
    NSString *urlString = [NSString stringWithFormat:@"%@",@"http://52.74.228.143:808/EmployeeServices/EmployeeClaimsService.svc/ClaimPhotoUpload?EmployeeId=IKYA004&ClaimId=189178&ClaimdtlId=441889&Remarks="];
    NSURL *url =[NSURL URLWithString:urlString];
    [obj startRequestForImageUploadingWithURL:url withRequestType:(kAPIManagerRequestTypePOST) withDataDictionary:dict arrImage:arrimg CalledforMethod:imageupload index:0 isMultiple:NO str_imagetype:@"pdf"];
    
}

#pragma mark-API Manager Delegate Method for Succes or Failure


-(void)APIManagerDidFinishRequestWithData:(id)responseData withRequestType:(APIManagerRequestType)requestType CalledforMethod:(APIManagerCalledForMethodName)APImethodName tag:(NSInteger)tag
{
    if (APImethodName ==imageupload) {
        NSDictionary *responsedata=(NSDictionary*)responseData;
        NSLog(@"data==%@",responsedata);
        
        NSString * Success= [responsedata valueForKey:@"success"];
        NSString * Message= [responseData valueForKey:@"message"];
        
        BOOL SuccessBool= [Success boolValue];
        
        if (SuccessBool)
        {
            
            //[self.navigationController popViewControllerAnimated:YES];
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
        else
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Server Error" message:Message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                      [alert dismissViewControllerAnimated:YES completion:nil];
                                                                  }];
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}

-(void)APIManagerDidFinishRequestWithError:(NSError *)error withRequestType:(APIManagerRequestType)requestType CalledforMethod:(APIManagerCalledForMethodName)APImethodName tag:(NSInteger)tag
{
    if (APImethodName ==imageupload) {
        NSLog(@"image didfailedupload");
    }
}



- (IBAction)choose:(id)sender {
    
    [self uploadimage];
}//showPdfVC

- (IBAction)showPDF:(id)sender {
    showpdfVC=[self.storyboard instantiateViewControllerWithIdentifier:@"showPdfVC"];
    [self.navigationController pushViewController:showpdfVC animated:YES];
}
@end
