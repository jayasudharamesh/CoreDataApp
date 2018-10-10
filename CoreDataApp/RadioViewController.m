//
//  RadioViewController.m
//  CoreDataApp
//
//  Created by Helina Devaraj on 10/10/18.
//  Copyright © 2018 Helina Devaraj. All rights reserved.
//

#import "RadioViewController.h"
#import "RadioButton.h"

@interface RadioViewController ()

@end

@implementation RadioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(20, 80, 280, 400)];
    container.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:container];
    
    UILabel *questionText = [[UILabel alloc] initWithFrame:CGRectMake(0,0,280,20)];
    questionText.backgroundColor = [UIColor clearColor];
    questionText.text = @"Which color do you like?";
    [container addSubview:questionText];
    
    RadioButton *rb1 = [[RadioButton alloc] initWithGroupId:@"first group" index:0];
    RadioButton *rb2 = [[RadioButton alloc] initWithGroupId:@"first group" index:1];
    RadioButton *rb3 = [[RadioButton alloc] initWithGroupId:@"first group" index:2];
    
    rb1.frame = CGRectMake(10,30,22,22);
    rb2.frame = CGRectMake(10,60,22,22);
    rb3.frame = CGRectMake(10,90,22,22);
    
    [container addSubview:rb1];
    [container addSubview:rb2];
    [container addSubview:rb3];
   
    
    UILabel *label1 =[[UILabel alloc] initWithFrame:CGRectMake(40, 30, 60, 20)];
    label1.backgroundColor = [UIColor clearColor];
    label1.text = @"Red";
    [container addSubview:label1];
   
    
    UILabel *label2 =[[UILabel alloc] initWithFrame:CGRectMake(40, 60, 60, 20)];
    label2.backgroundColor = [UIColor clearColor];
    label2.text = @"Green";
    [container addSubview:label2];
   
    
    UILabel *label3 =[[UILabel alloc] initWithFrame:CGRectMake(40, 90, 60, 20)];
    label3.backgroundColor = [UIColor clearColor];
    label3.text = @"Blue";
    [container addSubview:label3];
   
    
    [RadioButton addObserverForGroupId:@"first group" observer:self];
    
   
    [super viewDidLoad];
}
-(void)radioButtonSelectedAtIndex:(NSUInteger)index inGroup:(NSString *)groupId{
    NSLog(@"changed to %d in %@",index,groupId);
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

@end
