//
//  UploadPDFViewController.m
//  CoreDataApp
//
//  Created by Helina Devaraj on 9/3/18.
//  Copyright © 2018 Helina Devaraj. All rights reserved.
//

#import "UploadPDFViewController.h"
#import "NewTableViewCell.h"

@interface UploadPDFViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSArray *arr_days,*arr_status,*arr_names;
    NewTableViewCell *tempcell;
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
        tempcell.name_Lbl.text=[arr_names objectAtIndex:indexPath.row];
        
         [tempcell.btn_days addTarget:self action:@selector(selectedDays:) forControlEvents:UIControlEventTouchUpInside];
        [tempcell.btn_status addTarget:self action:@selector(selectedstatus:) forControlEvents:UIControlEventTouchUpInside];
        
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
    if (tableView==tblObj) {
        
    }else if (tableView==tableViewList)
    {
        if (selectBtn==0) {
            selectBtn=0;
            tempcell.days_btn.text=[arr_days objectAtIndex:indexPath.row];
            
        }else
        {
             selectBtn=1;
             tempcell.status_btn.text=[arr_status objectAtIndex:indexPath.row];
        }
        
        tableViewList.hidden=YES;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==tblObj) {
    return 120;
    }else
        return 40;
}
-(IBAction)selectedDays:(id)sender
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
    
}
-(IBAction)selectedstatus:(id)sender{
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
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    tableViewList.hidden=NO;
    // Here You can do additional code or task instead of writing with keyboard
    return NO;
}

@end
