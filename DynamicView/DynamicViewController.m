//
//  DynamicViewController.m
//  CoreDataApp
//
//  Created by Helina Devaraj on 10/9/18.
//  Copyright © 2018 Helina Devaraj. All rights reserved.
//

#import "DynamicViewController.h"
#import "TextboxCell.h"
#import "DropdownCell.h"
#import "GPSCell.h"
#import "PhotoCell.h"
#import "RadioCell.h"
#import "CheckboxCell.h"
#import "RatingCell.h"
#import "DateCell.h"
#import "HCSStarRatingView.h"

@interface DynamicViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,CLLocationManagerDelegate>
{
    NSMutableArray *question_arr,*answerType_arr,*answerfromweb_arr,*questionID_arr,*selectedDropdownAns_arr,*validation_arr;
    NSMutableDictionary *saveallDataDic;
    int selectDropdownIndex;
    int selectGPSIndex;
    int selectImageindex;
    int imgbtn;
    int imageAssignedIndicator;
    
    
    TextboxCell *textboxCell;
    DropdownCell *dropdownCell;
    GPSCell *gpsCell;
    PhotoCell *photoCell;
    RadioCell *radioCell;
    CheckboxCell *checkboxCell;
    RatingCell *ratingCell;
    DateCell *dateCell;
    
    
    UIButton *button;
    UIButton *gpsButton;
    UIButton *photoButton;
    
    
    UITableView *tableViewList1;
    UIView *gpsLocationView;
    UILabel *latLong_Lbl;
    
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    CLLocation *location;
    NSString *strLocation;
    
    NSData* newData;
    NSData *imgdata;
    NSString *documentDir;
    NSString *ImagefilePath;
    
    NSString *labelString,*textFieldString;
}

@end

@implementation DynamicViewController
@synthesize dynamicViewTable;

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager requestAlwaysAuthorization];
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
    
    [dynamicViewTable reloadData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    question_arr=[[NSMutableArray alloc]init];
    answerType_arr=[[NSMutableArray alloc]init];
    answerfromweb_arr=[[NSMutableArray alloc]init];
    questionID_arr=[[NSMutableArray alloc]init];
    selectedDropdownAns_arr=[[NSMutableArray alloc]init];
    validation_arr=[[NSMutableArray alloc]init];
    saveallDataDic=[[NSMutableDictionary alloc]init];
    
    dynamicViewTable.delegate=self;
    dynamicViewTable.dataSource=self;
    
    NSError *error;
    NSString *url_string = [NSString stringWithFormat: @"http://52.74.228.143:808/ActivityServices/ActivityService.svc/GetActivityDetails?CustomerId=CUSBFL1&ActivityId=2281"];
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSLog(@"json: %@", jsonDic);
    
    titleLbl.text=_titleLabel;
    question_arr=[jsonDic objectForKey:@"Question"];
    questionID_arr=[jsonDic objectForKey:@"ActivityQuestionId"];
    answerfromweb_arr=[jsonDic objectForKey:@"lstArrAnswer"];
    answerType_arr=[jsonDic objectForKey:@"AnswerFieldType"];
    validation_arr=[jsonDic objectForKey:@"ValidationType"];
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==dynamicViewTable) {
        if([[answerType_arr objectAtIndex:indexPath.row]isEqualToString:@"Date"])
        {
            return 180;
        }else
          return 100;
       
    }else
        return 30;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==dynamicViewTable) {
          return question_arr.count;
    }else
    return selectedDropdownAns_arr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==dynamicViewTable) {
        
    
    if([[answerType_arr objectAtIndex:indexPath.row]isEqualToString:@"Textbox"] ||
       [[answerType_arr objectAtIndex:indexPath.row]isEqualToString:@"Checkbox"]||
       [[answerType_arr objectAtIndex:indexPath.row]isEqualToString:@"Radio"])
    {
        static NSString *CellIdentifier = @"textboxCell";
        static NSString *CellNib = @"TextboxCell";
        textboxCell = (TextboxCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!textboxCell)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
            textboxCell = (TextboxCell *)[nib objectAtIndex:0];
            
        }
        textboxCell.textAnswer_txt.tag=indexPath.row;
        textboxCell.textBoxQuest_Lbl.tag=indexPath.row;
        textboxCell.textquestID.tag=indexPath.row;
        textboxCell.textquestID.hidden=YES;
        
        textboxCell.textBoxQuest_Lbl.text=[question_arr objectAtIndex:indexPath.row];
        
        
        
        //Numbers
        
        if ([[validation_arr objectAtIndex:indexPath.row] isEqualToString:@"NoValidation"]) {
            textboxCell.textAnswer_txt.keyboardType=UIKeyboardTypeDefault;
            
        }
        else if ([[validation_arr objectAtIndex:indexPath.row]isEqualToString:@"Numbers"])
        {
            textboxCell.textAnswer_txt.keyboardType=UIKeyboardTypeNumberPad;
            
        }
       
        UILabel* lblname  = (UILabel *)    [textboxCell textquestID];
        lblname.tag =100;
        
        UITextField *ans_text=(UITextField *)    [textboxCell textAnswer_txt];
        ans_text.tag =indexPath.row;
        
        [ans_text addTarget:self  action:@selector(textFieldDidChange:)  forControlEvents:UIControlEventEditingChanged];
        lblname.text = questionID_arr[indexPath.row];
        textboxCell.textAnswer_txt.delegate=self;
        textboxCell.textAnswer_txt.tag=indexPath.row;
        
        if ([saveallDataDic valueForKey:lblname.text] != nil) {
            ans_text.text = [saveallDataDic valueForKey:lblname.text];
            NSLog(@"%@",saveallDataDic);
            
        } else {
            ans_text.text = @"";
            
        }
        
        
        return textboxCell;
        
    }else if([[answerType_arr objectAtIndex:indexPath.row]isEqualToString:@"Dropdown"]){
        static NSString *CellIdentifier = @"dropdownViewCell";
        static NSString *CellNib = @"DropdownCell";
        dropdownCell = (DropdownCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!dropdownCell)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
            dropdownCell = (DropdownCell *)[nib objectAtIndex:0];
            
        }
        
        dropdownCell.dropdownQuest_Lbl.tag=indexPath.row;
        dropdownCell.dropdownAnswer_btn.tag=indexPath.row;
        dropdownCell.dropdownID.tag=indexPath.row;
        dropdownCell.dropdownID.hidden=YES;
        
        
        
        dropdownCell.dropdownQuest_Lbl.text=[question_arr objectAtIndex:indexPath.row];
        
        selectedDropdownAns_arr=[[answerfromweb_arr valueForKey:@"lstOption"]objectAtIndex:[dropdownCell.dropdownQuest_Lbl tag]];
        NSLog(@"dropdown index %@",selectedDropdownAns_arr);
        
        UILabel* lblname  = (UILabel *)    [dropdownCell dropdownID];
        lblname.tag =200;
        
        button = (UIButton *)[dropdownCell dropdownAnswer_btn];
        button.tag =indexPath.row;
        
        dropdownCell.dropdownAnswer_btn.enabled = YES;
        
        [button addTarget:self action:@selector(selectedDropdown:) forControlEvents:UIControlEventTouchUpInside];
        lblname.text=[questionID_arr objectAtIndex:indexPath.row];
        
        if ([saveallDataDic valueForKey:lblname.text] != nil) {
            [button setTitle:[saveallDataDic valueForKey:lblname.text] forState:UIControlStateNormal];
            NSLog(@"%@",saveallDataDic);
            
            
        } else {
            
            [button setTitle:@"" forState:UIControlStateNormal];
            
        }
        return dropdownCell;
    }else if([[answerType_arr objectAtIndex:indexPath.row]isEqualToString:@"GPS"]){
        static NSString *CellIdentifier = @"gpsViewCell";
        static NSString *CellNib = @"GPSCell";
        gpsCell = (GPSCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!gpsCell)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
            gpsCell = (GPSCell *)[nib objectAtIndex:0];
            
        }
        
        gpsCell.gpsQuest_Lbl.tag=indexPath.row;
        gpsCell.gpsAnswer_btn.tag=indexPath.row;
        gpsCell.gpsQuesID.tag=indexPath.row;
        gpsCell.gpsQuesID.hidden=YES;
        
        
        
        gpsCell.gpsQuest_Lbl.text=[question_arr objectAtIndex:indexPath.row];
        
        
        UILabel* lblname  = (UILabel *)    [gpsCell gpsQuesID];
        lblname.tag =300;
        
        gpsButton = (UIButton *)[gpsCell gpsAnswer_btn];
        gpsButton.tag =indexPath.row;
        
        gpsCell.gpsAnswer_btn.enabled = YES;
        
        [gpsButton addTarget:self action:@selector(selectedGPS:) forControlEvents:UIControlEventTouchUpInside];
        lblname.text=[questionID_arr objectAtIndex:indexPath.row];
        
        if ([saveallDataDic valueForKey:lblname.text] != nil) {
//            [gpsButton setTitle:[saveallDataDic valueForKey:lblname.text] forState:UIControlStateNormal];
            NSLog(@"%@",saveallDataDic);
            [gpsButton setTitle:@"" forState:UIControlStateNormal];
            
        } else {
            
            [gpsButton setTitle:@"" forState:UIControlStateNormal];
            
        }
        return gpsCell;
    }else if([[answerType_arr objectAtIndex:indexPath.row]isEqualToString:@"Image"]){
        static NSString *CellIdentifier = @"photoViewCell";
        static NSString *CellNib = @"PhotoCell";
        photoCell = (PhotoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!photoCell)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
            photoCell = (PhotoCell *)[nib objectAtIndex:0];
            
        }
        
        photoCell.photoQuest_Lbl.tag=indexPath.row;
        photoCell.photoAnswer_Btn.tag=indexPath.row;
        photoCell.photoQuesID.tag=indexPath.row;
        photoCell.photoQuesID.hidden=YES;
        
        
        
        photoCell.photoQuest_Lbl.text=[question_arr objectAtIndex:indexPath.row];
        
        
        UILabel* lblname  = (UILabel *)    [photoCell photoQuesID];
        lblname.tag =400;
        
        photoButton = (UIButton *)[photoCell photoAnswer_Btn];
        photoButton.tag =indexPath.row;
        
        photoCell.photoAnswer_Btn.enabled = YES;
        
        [photoButton addTarget:self action:@selector(selectedPhoto:) forControlEvents:UIControlEventTouchUpInside];
        lblname.text=[questionID_arr objectAtIndex:indexPath.row];
        
        if ([saveallDataDic valueForKey:lblname.text] != nil) {
            [photoButton setTitle:[saveallDataDic valueForKey:lblname.text] forState:UIControlStateNormal];
            NSLog(@"%@",saveallDataDic);
            
            [photoButton setTitle:@"" forState:UIControlStateNormal];
            
        } else {
            
            [photoButton setTitle:@"" forState:UIControlStateNormal];
            
        }
        return photoCell;
    }else if([[answerType_arr objectAtIndex:indexPath.row]isEqualToString:@"Date"]){
        static NSString *CellIdentifier = @"datePickerCell";
        static NSString *CellNib = @"DateCell";
        dateCell = (DateCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!dateCell)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
            dateCell = (DateCell *)[nib objectAtIndex:0];
            
        }
        
        dateCell.datePickerQuest_Lbl.tag=indexPath.row;
        dateCell.dateQuestID.tag=indexPath.row;
        dateCell.datePickerAnswer.tag=indexPath.row;
        dateCell.dateQuestID.hidden=YES;
        
        
        
        dateCell.datePickerQuest_Lbl.text=[question_arr objectAtIndex:indexPath.row];
        dateCell.dateQuestID.text=[questionID_arr objectAtIndex:indexPath.row];
        
        [dateCell.datePickerAnswer addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        return dateCell;
    }else if([[answerType_arr objectAtIndex:indexPath.row]isEqualToString:@"Rating"]){
        static NSString *CellIdentifier = @"datePickerCell";
        static NSString *CellNib = @"RatingCell";
        ratingCell = (RatingCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!ratingCell)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
            ratingCell = (RatingCell *)[nib objectAtIndex:0];
            
        }
        
        ratingCell.ratingQues_Lb.tag=indexPath.row;
        ratingCell.ratingQuestID.tag=indexPath.row;
        ratingCell.ratingQuestID.hidden=YES;
        
      
        [ratingCell.starRatingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
        ratingCell.starRatingView.tag=indexPath.row;
        
        ratingCell.ratingQues_Lb.text=[question_arr objectAtIndex:indexPath.row];
        ratingCell.ratingQuestID.text=[questionID_arr objectAtIndex:indexPath.row];
       
        return ratingCell;
    }
    }
    else if (tableView==tableViewList1)
    {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        cell.textLabel.text=[selectedDropdownAns_arr objectAtIndex:indexPath.row];
        return cell;
    }
    
        return 0;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==dynamicViewTable) {
        
    }else if (tableView==tableViewList1)
    {
        
        [dropdownCell.dropdownAnswer_btn setTitle:[selectedDropdownAns_arr objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        NSString* buttonTitle=dropdownCell.dropdownAnswer_btn.currentTitle;
        NSLog(@"Button Title: %@", buttonTitle);
        [saveallDataDic  setObject:buttonTitle forKey:[questionID_arr objectAtIndex:selectDropdownIndex]];
        
        NSLog(@"status %@",saveallDataDic);
        tableViewList1.hidden=YES;
        [dynamicViewTable reloadData];
        dynamicViewTable.hidden=NO;
        
    }
    
}

-(void)textFieldDidChange:(UITextField *)txtField
{
    
    
    UILabel *label = (UILabel *)[txtField.superview viewWithTag:100];
    labelString = label.text;
    textFieldString=txtField.text;
    if ([textFieldString isEqualToString:@""]) {
        [saveallDataDic removeObjectForKey:labelString];
    }else{
        [saveallDataDic setObject:textFieldString forKey:labelString];
    }
   
}
- (IBAction)selectedDropdown:(UIButton*)sender
{
    
    tableViewList1=[[UITableView alloc]init];
    tableViewList1.frame = CGRectMake(150,200,150,200);
    tableViewList1.dataSource=self;
    tableViewList1.delegate=self;
    tableViewList1.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [tableViewList1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    tableViewList1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    tableViewList1.layer.borderWidth = 0.8;
    
    [self.view addSubview:tableViewList1];
    
    
    tableViewList1.hidden=NO;
    [tableViewList1 reloadData];
    
    selectDropdownIndex=(int)[sender tag];
    NSLog(@"dropdown index :%d",selectDropdownIndex);
  
}
- (IBAction)selectedGPS:(UIButton*)sender
{
    selectGPSIndex=(int)[sender tag];
    NSLog(@"gps index :%d",selectGPSIndex);
    
    gpsLocationView=[[UIView alloc]initWithFrame:CGRectMake(50, 200, 220, 130)];
    [gpsLocationView setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:gpsLocationView];
    
    UILabel *gpsTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, 5, 200, 40)];
    gpsTitle.backgroundColor = [UIColor clearColor];
    gpsTitle.textAlignment = NSTextAlignmentCenter;
    gpsTitle.textColor = [UIColor blackColor];
    gpsTitle.text=@"Fetch Location";
    [gpsLocationView addSubview:gpsTitle];
    
    latLong_Lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 200, 100)];
    latLong_Lbl.backgroundColor = [UIColor clearColor];
    latLong_Lbl.textAlignment = NSTextAlignmentLeft;
    latLong_Lbl.textColor = [UIColor blackColor];
    latLong_Lbl.numberOfLines = 0;
    latLong_Lbl.lineBreakMode = UILineBreakModeWordWrap;
   
    [gpsLocationView addSubview:latLong_Lbl];
   
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Are you sure want to add outlet to current location" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelButton=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:cancelButton];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                   
                                    [gpsLocationView setHidden:NO];
                                    [self performSelector:@selector(popupHide) withObject:self afterDelay:2.5];
                                    location = [locationManager location];
                                    // Configure the new event with information from the location
                                    
                                    
                                    CLLocationCoordinate2D coordinate = [location coordinate];
                                    NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
                                    NSString * longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
                                    
                                   
                                    NSString *str_Location = [NSString stringWithFormat: @"Latitude:%@\n\nLongitude:%@", latitude, longitude];
                                    
                                    UIButton *btn=[[UIButton alloc]init];
                                    UILabel *label1 = (UILabel *)[btn viewWithTag:400];
                                    NSString* labelString = label1.text;
                                    textFieldString = gpsCell.gpsAnswer_btn.currentTitle;
                                    
                                    [saveallDataDic setObject:str_Location forKey:[questionID_arr objectAtIndex:selectGPSIndex]];
                                    latLong_Lbl.text=str_Location;
                                    
                                    NSLog(@"loc1ation %@",str_Location);
                                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Outlet added Successfully" preferredStyle:UIAlertControllerStyleAlert];
                                    
                                    
                                    UIAlertAction* yesButton = [UIAlertAction
                                                                actionWithTitle:@"Ok"
                                                                style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction * action)
                                                                {
                                                                }];
                                    
                                    [alertController addAction:yesButton];
                                    [self presentViewController:alertController animated:YES completion:nil];
                                    
                                }];
    
    [alertController addAction:yesButton];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
-(void)popupHide{
    gpsLocationView.hidden=YES;
}
- (void)datePickerValueChanged:(id)sender {
    
    int selectDate;
    selectDate=(int)[sender tag];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *str_date = [dateFormatter stringFromDate:dateCell.datePickerAnswer.date];
    [saveallDataDic  setObject:str_date forKey:[questionID_arr objectAtIndex:selectDate]];
}
- (IBAction)didChangeValue:(HCSStarRatingView *)sender {
    
    int selectRating;
    selectRating=(int)sender.tag;
    
    NSLog(@"Changed rating to %.1f", sender.value);
    int starvalue = sender.value;
    
    NSString *str_rateforSepActivity= [NSString stringWithFormat:@"%d", starvalue];
    
    [saveallDataDic  setObject:str_rateforSepActivity forKey:[questionID_arr objectAtIndex:selectRating]];
}
- (IBAction)selectedPhoto:(UIButton*)sender
{
    selectImageindex=(int)[sender tag];
    NSLog(@"camera index :%d",selectImageindex);
    
    if (! [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        
        UIAlertController *devicealert=[UIAlertController alertControllerWithTitle:@"Message" message:@"Camera Not Available" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                {
                                    [devicealert dismissViewControllerAnimated:YES completion:nil];
                                    
                                }];
        [devicealert addAction:action1];
        [self presentViewController:devicealert animated:YES completion:nil];
        
    } else {
        
        UIImagePickerController *cameraPicker = [[UIImagePickerController alloc] init];
        cameraPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        cameraPicker.allowsEditing=YES;
        cameraPicker.delegate =self;
        // Show image picker
        [self presentViewController:cameraPicker animated:YES completion:nil];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    chosenImage = [UIImage imageWithCGImage:chosenImage.CGImage scale:chosenImage.scale orientation:UIImageOrientationUp];
    NSData *imageCheckDataUnscale = UIImageJPEGRepresentation(chosenImage,1.0);
    
    CGSize newSize = CGSizeMake(200.0f, 200.0f);
    
    UIGraphicsBeginImageContext(newSize);
    [chosenImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    newData =UIImageJPEGRepresentation(newImage, 1.0);
    
    NSString *str_quesID=[questionID_arr objectAtIndex:selectImageindex];
    
    
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd_HH-mm-ss";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSString *gmtTime = [dateFormatter stringFromDate:now];
    NSLog(@"The Current Time is :%@", gmtTime);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentDir=[paths objectAtIndex:0];
    ImagefilePath =[NSString stringWithFormat:@"%@/%@_%@_checkingImage.png",documentDir,str_quesID,gmtTime];
    [newData writeToFile:ImagefilePath atomically:YES];
    
    
    unsigned  long long size= ([[[NSFileManager defaultManager] attributesOfItemAtPath:ImagefilePath error:nil] fileSize]);
    
    if(imgbtn == 1){
        imgdata = newData;
        [photoCell.photoAnswer_Btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        NSLog(@"image %@",ImagefilePath);
    }
    
    
    
    imageAssignedIndicator=1;
    [picker dismissViewControllerAnimated:YES completion:NULL];
//
//    UIButton *btn=[[UIButton alloc]init];
//    UILabel *label1 = (UILabel *)[btn viewWithTag:400];
//    labelString = label1.text;
    [saveallDataDic setObject:ImagefilePath forKey:[questionID_arr objectAtIndex:selectImageindex]];
    
    NSLog(@"photo path:%@",saveallDataDic);
    
//    fileURL = [NSURL fileURLWithPath:ImagefilePath];
    
}
- (IBAction)submitButton:(id)sender {
    
    NSLog(@"%@",saveallDataDic);
}
@end
