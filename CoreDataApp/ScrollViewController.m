//
//  ScrollViewController.m
//  CoreDataApp
//
//  Created by Helina Devaraj on 9/3/18.
//  Copyright © 2018 Helina Devaraj. All rights reserved.
//

#import "ScrollViewController.h"

@interface ScrollViewController ()<UIScrollViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>

{
    UIButton *button1;
    UIButton *button2;
    
    UITextField *textfield1;
    UITextField *textfield2;
    
    UILabel *fromLabel;
    UILabel *dojLabel;
    
    NSArray *arr_names;
    
    NSMutableArray *array;
    NSMutableArray *dojArray;
    
    NSMutableDictionary *totalCount;
    int i;
    int selectBtn;
    UITableView *tableViewList;
     NSArray *arr_days,*arr_status;
    
    NSMutableArray *labelarr;
    NSMutableArray *daystextarr;
    
    int selectbuttonIndex;
    NSMutableArray *arr_selectedDate;
    
    UIToolbar *accessoryToolbar;
    UIPickerView *attendancePicker;
    int selectedTypeattn,*selectList;
}

@end

@implementation ScrollViewController
@synthesize scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    scrollView.delegate=self;
    scrollView.contentSize=CGSizeMake(320, 760);
    totalCount=[[NSMutableDictionary alloc]init];
    labelarr=[[NSMutableArray alloc]init];
    daystextarr=[[NSMutableArray alloc]init];
    arr_selectedDate=[[NSMutableArray alloc]init];
   
    arr_days=[[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4", nil];
    arr_status=[[NSArray alloc]initWithObjects:@"resigned",@"inactive", nil];
    
    arr_names=[[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4", nil];
    
        array = [[ NSMutableArray alloc]initWithObjects:@"aaa",@"bbb",@"ccc",@"ddd",@"aaa",@"bbb",@"ccc",@"ddd",nil];
        dojArray= [[ NSMutableArray alloc]initWithObjects:@"01/09/2018",@"02/09/2018",@"03/09/2018",@"04/09/2018",@"05/09/2018",@"06/09/2018",@"07/09/2018",@"08/09/2018",nil];
        for( i=0;i<[array count];i++)
        {
            UILabel *label = [[UILabel alloc]init];
            label.text = [array objectAtIndex:i];
            label.backgroundColor = [UIColor clearColor];
            
            label.frame = CGRectMake(5, (i*80)+5, 100, 30); // here height is 30 and width is 100;
            [scrollView addSubview:label];
            
            dojLabel = [[UILabel alloc]init];
            dojLabel.text = [dojArray objectAtIndex:i];
            dojLabel.backgroundColor = [UIColor clearColor];
            dojLabel.font=[UIFont systemFontOfSize:12];
            
            dojLabel.frame = CGRectMake(5, (i*80)+35, 100, 30); // here height is 30 and width is 100;
            [scrollView addSubview:dojLabel];
            [labelarr addObject:dojLabel];
            
            button1=[[UIButton alloc]initWithFrame:CGRectMake(100, (i*80)+35, 90, 30)];
            button1.titleLabel.font = [UIFont systemFontOfSize:13.0];
            [button1 addTarget:self action:@selector(clickButton1:) forControlEvents:UIControlEventTouchUpInside];
            [button1 setBackgroundColor:[UIColor lightGrayColor]];
            [scrollView addSubview:button1];
            [daystextarr addObject:button1];
            
            button2=[[UIButton alloc]initWithFrame:CGRectMake(200, (i*80)+35, 90, 30)];
            button2.titleLabel.font = [UIFont systemFontOfSize:13.0];
            [button2 addTarget:self action:@selector(clickButton2:) forControlEvents:UIControlEventTouchUpInside];
            [button2 setBackgroundColor:[UIColor lightGrayColor]];
            [scrollView addSubview:button2];
            
            
            textfield1 = [[UITextField alloc] initWithFrame:CGRectMake(100, (i*80)+35, 90, 30)];
            textfield1.borderStyle = UITextBorderStyleRoundedRect;
            textfield1.textColor = [UIColor blackColor];
            textfield1.font = [UIFont systemFontOfSize:14.0];
            textfield1.placeholder = @"days";
            textfield1.backgroundColor = [UIColor clearColor];
            textfield1.autocorrectionType = UITextAutocorrectionTypeYes;
            textfield1.keyboardType = UIKeyboardTypeDefault;
            textfield1.clearButtonMode = UITextFieldViewModeWhileEditing;
            textfield1.delegate = self;
            
//            [scrollView addSubview:textfield1];
            
            textfield2 = [[UITextField alloc] initWithFrame:CGRectMake(200, (i*80)+35, 90, 30)];
            textfield2.borderStyle = UITextBorderStyleRoundedRect;
            textfield2.textColor = [UIColor blackColor];
            textfield2.font = [UIFont systemFontOfSize:14.0];
            textfield2.placeholder = @"status";
            textfield2.backgroundColor = [UIColor clearColor];
            textfield2.autocorrectionType = UITextAutocorrectionTypeYes;
            textfield2.keyboardType = UIKeyboardTypeDefault;
            textfield2.clearButtonMode = UITextFieldViewModeWhileEditing;
            textfield2.delegate = self;
            
//            [scrollView addSubview:textfield2];
            
        }
    
    attendancePicker = [UIPickerView new];
    attendancePicker.delegate=self;
    attendancePicker.dataSource=self;//0, 412, 320, 216
    //    [self.view addSubview:attendancePicker];
    //    attendancePicker.backgroundColor=[UIColor lightGrayColor];
    
    //    accessoryToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0,0.0, 320.0,20.0 )];
    accessoryToolbar = [UIToolbar new];
    accessoryToolbar.barStyle = UIBarStyleBlackTranslucent;
    [accessoryToolbar sizeToFit];
    NSMutableArray *barItemsBeat = [[NSMutableArray alloc] init];
    UIBarButtonItem *btnCancelBeat = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelClickedinPicker)];
    [barItemsBeat addObject:btnCancelBeat];
    UIBarButtonItem *flexSpaceBeat = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItemsBeat addObject:flexSpaceBeat];
    UIBarButtonItem *btnDoneBeat = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneClickedinPicker)];
    [barItemsBeat addObject:btnDoneBeat];
    [accessoryToolbar setItems:barItemsBeat animated:YES];
    textfield1.inputView=attendancePicker;
    textfield1.inputAccessoryView=accessoryToolbar;
    textfield1.delegate=self;
 
    
}
-(void)cancelClickedinPicker
{
    
    [textfield1 resignFirstResponder];
}


-(void)doneClickedinPicker{
    
    textfield1.text=[arr_days objectAtIndex:selectedTypeattn];
    [textfield1 resignFirstResponder];
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

-(IBAction)clickButton1:(id)sender
{
    
    int seletag=(int)[sender tag];
    NSLog(@"%d",seletag);
    
    selectBtn=0;
    tableViewList=[[UITableView alloc]init];
    tableViewList.frame = CGRectMake(80,200,80,150);
    tableViewList.dataSource=self;
    tableViewList.delegate=self;
    tableViewList.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [tableViewList registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    tableViewList.layer.borderColor = [UIColor lightGrayColor].CGColor;
    tableViewList.layer.borderWidth = 0.8;
    
//    [self.view addSubview:tableViewList];
    
    
    tableViewList.hidden=NO;
    [tableViewList reloadData];
    
    selectbuttonIndex=(int)[sender tag];
    
}
-(IBAction)clickButton2:(id)sender
{
    selectBtn=1;
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [scrollView setContentOffset:CGPointMake(0,textField.center.y-80) animated:NO];
    [textField resignFirstResponder];
    for(int j=0;j<[array count];j++)
    {
         [totalCount setObject:textfield1.text forKey:dojLabel.text];
    }
   
    
    NSLog(@"%@",totalCount);
    
     return [textField resignFirstResponder];
    
}
- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    [scrollView setContentOffset:CGPointMake(0,textField.center.y-80) animated:YES];
    
    // here '80' can be any number which decide the height that textfiled     should move
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
        if (selectBtn==0) {
            selectBtn=0;
            return arr_days.count;
        }else
            selectBtn=1;
    return arr_status.count;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        if (selectBtn==0) {
            cell.textLabel.text=[arr_days objectAtIndex:indexPath.row];
        }else if (selectBtn==1)
        {
            cell.textLabel.text=[arr_status objectAtIndex:indexPath.row];
        }
        return cell;
   
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    
        if (selectBtn==0) {
            selectBtn=0;
           
            NSString *str;
            int select;
            
            
            for (select=0; select<[labelarr count]; select++) {
                
                [button1 setTitle:[arr_days objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                str=button1.currentTitle;
                
//                [arr addObject:str];
                
//                [totalCount setObject:str forKey:[dojArray objectAtIndex:selectbuttonIndex]];
            }
//
            
        }else
        {
            selectBtn=1;
//            tempcell.status_btn.text=[arr_status objectAtIndex:indexPath.row];
        }
        
        tableViewList.hidden=YES;
    
        [arr addObject:[arr_days objectAtIndex:indexPath.row]];
//    [totalCount setObject:[arr_days objectAtIndex:indexPath.row] forKey:@"text"];
          NSLog(@"%@",totalCount);
}

#pragma mark - UIPickerView Delegates

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [arr_days count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return [arr_days objectAtIndex:row];
    
    
}



- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
     selectedTypeattn=(int)row;
    
    if ([arr_selectedDate containsObject:[arr_days objectAtIndex:selectedTypeattn]]) {
        [arr_selectedDate removeObjectIdenticalTo:[arr_days objectAtIndex:selectedTypeattn]];
        //        [arr_selectedStatus removeObjectIdenticalTo:[arr_attnStatus objectAtIndex:selectList]];
        
        
    } else {
        
        
       
        [arr_selectedDate addObject:[arr_days objectAtIndex:selectedTypeattn]];
        
       
        NSMutableDictionary *mydict=[[NSMutableDictionary alloc]init];
//        [mydict setObject:button1.currentTitle forKey:[NSString stringWithFormat:@"Text"]];
        NSLog(@"%@",mydict);
        
     
    }
}
@end
