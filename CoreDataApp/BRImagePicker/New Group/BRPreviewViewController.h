//
//  BRPreviewViewController.h
//  AssetsLibraryDemo
//
//  Created by Brammanand Soni on 5/1/15.
//  Copyright (c) 2015 Brammanand Soni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@class BRPreviewViewController;

@protocol BRPreviewViewControllerDelegate <NSObject>

- (void)previewViewDidCancel:(BRPreviewViewController *)previewViewController;

@end

API_AVAILABLE(ios(10.0))
@interface BRPreviewViewController : UIViewController
{
    AppDelegate *appDelegate;
    NSManagedObjectContext *newcontext;
    NSArray *arr_saveData;
    NSArray *arr_Results;
    NSManagedObject *newtransaction;
    NSManagedObject *newtransactionUser;
}

@property (nonatomic,strong) void(^block)(NSArray * data);
@property (nonatomic, weak) id <BRPreviewViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray *selectedAssets;

@end
