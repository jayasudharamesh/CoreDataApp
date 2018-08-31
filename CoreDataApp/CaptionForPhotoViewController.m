//
//  CaptionForPhotoViewController.m
//  CoreDataApp
//
//  Created by Helina Devaraj on 8/20/18.
//  Copyright © 2018 Helina Devaraj. All rights reserved.
//

#import "CaptionForPhotoViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "BRImagePicker.h"
#import "BR_ImageInfo.h"
#import "AppDelegate.h"



API_AVAILABLE(ios(10.0))
@interface CaptionForPhotoViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    AppDelegate *appDelegate;
    NSManagedObjectContext *context;
    NSArray *arr_saveData;
    NSArray *arr_Results;
    NSManagedObject *transaction;
    NSManagedObject *transactionUser;
    NSMutableArray *arr_images;
    NSMutableArray *arr_newSavedData;
}

@property (weak, nonatomic) IBOutlet UITableView *assetsTableView;

@property (nonatomic, strong) NSArray *selectedAssetsArray;

@end

@implementation CaptionForPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.assetsTableView.delegate=self;
    self.assetsTableView.dataSource=self;
    
  
   
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    if (@available(iOS 10.0, *)) {
        appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    } else {
        // Fallback on earlier versions
    }
    context=appDelegate.persistentContainer.viewContext;
    
    
    arr_newSavedData=[[NSMutableArray alloc]init];
    
    
    NSFetchRequest *fetchResults=[NSFetchRequest fetchRequestWithEntityName:@"NewEntity"];
    self.selectedAssetsArray=[context executeFetchRequest:fetchResults error:nil];
    NSLog(@"%@",[self.selectedAssetsArray valueForKey:@"captionwithImage"]);
    NSLog(@"%@",[self.selectedAssetsArray valueForKey:@"addImage"]);
    
    arr_images=[[NSMutableArray alloc]init];
    for (int i=0;i<[[self.selectedAssetsArray valueForKey:@"captionwithImage"] count];i++) {
        NSData *data =[[self.selectedAssetsArray valueForKey:@"addImage"]objectAtIndex:i];
        UIImage *image = [UIImage imageWithData:data];
        
        NSString *str=[[self.selectedAssetsArray valueForKey:@"captionwithImage"] objectAtIndex:i];
        [arr_newSavedData addObject:str];
        [arr_images addObject:image];
    }
    
    
    NSLog(@"%@",arr_images);
    NSLog(@"%@",arr_newSavedData);
    
    //    NSLog(@"%@",[self.selectedAssetsArray valueForKey:@"selectedimage"]);
    
    
    
    if ([self.selectedAssetsArray count]==0) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Message" message:@"No data" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^ (UIAlertAction *action)
                               {
                                   [self dismissViewControllerAnimated:YES completion:nil];
                               }];
        
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        [self.assetsTableView reloadData];
    }
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

- (IBAction)selectPressed:(id)sender {
    BRImagePicker *imagePicker = [[BRImagePicker alloc] initWithPresentingController:self];
    [imagePicker showPickerWithDataBlock:^(NSArray *data) {
        
        // Each object in returned Array will be of type  "BR_ImageInfo"
        
        self.selectedAssetsArray = data;
        
//        self.infoLabel.text = [NSString stringWithFormat:@"%lu  %@ selected.",(unsigned long)self.selectedAssetsArray.count, self.selectedAssetsArray.count==1 ? @"Asset" : @"Assets"];
        
        [self.assetsTableView reloadData];
    }];
}
#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.selectedAssetsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    /*
    
    BR_ImageInfo *imageInfo = [self.selectedAssetsArray objectAtIndex:indexPath.row];
    
    cell.imageView.image = imageInfo.image;
    cell.textLabel.text = imageInfo.caption ? imageInfo.caption : @"No caption for image";
    
    */
    if ([self.selectedAssetsArray count]!=0) {
        
        cell.imageView.image =[arr_images objectAtIndex:indexPath.row];
        cell.textLabel.text=[arr_newSavedData objectAtIndex:indexPath.row];
        
    }else{
  
        
        BR_ImageInfo *imageInfo = [self.selectedAssetsArray objectAtIndex:indexPath.row];
        
        cell.imageView.image = imageInfo.image;
        cell.textLabel.text = imageInfo.caption ? imageInfo.caption : @"No caption for image";
    }
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
@end
