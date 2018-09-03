//
//  UploadPDFViewController.h
//  CoreDataApp
//
//  Created by Helina Devaraj on 9/3/18.
//  Copyright © 2018 Helina Devaraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadPDFViewController : UIViewController
{
    int selectBtn;
    
    UITableView *tableViewList;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tblObj;

@end
