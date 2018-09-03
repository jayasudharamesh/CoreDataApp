//
//  ScrollViewController.m
//  CoreDataApp
//
//  Created by Helina Devaraj on 9/3/18.
//  Copyright © 2018 Helina Devaraj. All rights reserved.
//

#import "ScrollViewController.h"

@interface ScrollViewController ()

{
    UIButton *button1;
    UIButton *button2;
    
    UITextField *textfield1;
    UITextField *textfield2;
    
    UILabel *fromLabel;
    
    NSArray *arr_names;
    
    NSMutableArray *array;
}

@end

@implementation ScrollViewController
@synthesize scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    arr_names=[[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4", nil];
    
        array = [[ NSMutableArray alloc]initWithObjects:@"aaa",@"bbb",@"ccc",@"ddd",nil];
        for( int i=0;i<[array count];i++)
        {
            UILabel *label = [[UILabel alloc]init];
            label.text = [array objectAtIndex:i];
            label.backgroundColor = [UIColor clearColor];
            
            label.frame = CGRectMake(10, (i*30)+40, 100, 30); // here height is 30 and width is 100;
            [scrollView addSubview:label];
            
            button1=[[UIButton alloc]initWithFrame:CGRectMake(10, (i*30)+60, 100, 30)];
            button1.titleLabel.font = [UIFont systemFontOfSize:13.0];
            [button1 addTarget:self action:@selector(clickButton1:) forControlEvents:UIControlEventTouchUpInside];
            [button1 setBackgroundColor:[UIColor lightGrayColor]];
            [scrollView addSubview:button1];
            
            button2=[[UIButton alloc]initWithFrame:CGRectMake(10, (i*30)+60, 100, 30)];
            button2.titleLabel.font = [UIFont systemFontOfSize:13.0];
            [button2 addTarget:self action:@selector(clickButton2:) forControlEvents:UIControlEventTouchUpInside];
            [button2 setBackgroundColor:[UIColor lightGrayColor]];
            [scrollView addSubview:button2];
            
        }
 
   /*
    arr_names = [[ NSMutableArray alloc]initWithObjects:@"aaa",@"bbb",@"ccc",@"ddd",nil];
    UILabel *label;
    int y =10;
    for( int i=0;i<[arr_names count];i++)
    {
        
    NSString *theText = [arr_names objectAtIndex:i];
    label = [[UILabel alloc]init];
    label.text = theText;
    label.backgroundColor = [UIColor clearColor];
    label = [[UILabel alloc]initWithFrame:CGRectMake(scrollView.frame.origin.x + 10, scrollView.frame.origin.y + 45, 100, 25)];
    
    y = y +label.frame.size.height+5;
    [scrollView addSubview:label];
        
    }
   
    
   

    for (int i=0; i<[arr_names count]; i++) {
        
        
        
        UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(scrollView.frame.origin.x + 10, scrollView.frame.origin.y + 45, 100, 25)];
        
        fromLabel.numberOfLines = 1;
        fromLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
        fromLabel.adjustsFontSizeToFitWidth = YES;
        fromLabel.minimumScaleFactor = 10.0f/12.0f;
        fromLabel.clipsToBounds = YES;
        fromLabel.backgroundColor = [UIColor clearColor];
        fromLabel.textColor = [UIColor blackColor];
        fromLabel.textAlignment = NSTextAlignmentLeft;
        [scrollView addSubview:fromLabel];
        fromLabel.text=[arr_names objectAtIndex:i];
        
        button1=[[UIButton alloc]initWithFrame:CGRectMake(scrollView.frame.origin.x + 10, scrollView.frame.origin.y + 55, 100, 25)];
        button1.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [button1 addTarget:self action:@selector(clickButton1:) forControlEvents:UIControlEventTouchUpInside];
        [button1 setBackgroundColor:[UIColor lightGrayColor]];
        [scrollView addSubview:button1];
        
        button2=[[UIButton alloc]initWithFrame:CGRectMake(scrollView.frame.origin.x + 120, scrollView.frame.origin.y + 55, 100, 25)];
        button2.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [button2 addTarget:self action:@selector(clickButton2:) forControlEvents:UIControlEventTouchUpInside];
        [button2 setBackgroundColor:[UIColor lightGrayColor]];
        [scrollView addSubview:button2];
        
        
    }
    */
    
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
-(IBAction)clickButton1:(id)sender{
    
}
-(IBAction)clickButton2:(id)sender{
    
}
@end
