//
//  PdfViewController.h
//  CoreDataApp
//
//  Created by Helina Devaraj on 7/31/18.
//  Copyright © 2018 Helina Devaraj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QuickLook.h>
#import <QuartzCore/QuartzCore.h>

@interface PdfViewController : UIViewController<QLPreviewControllerDelegate,QLPreviewControllerDataSource>
@property (weak, nonatomic) IBOutlet UIView *animationView;

@property (weak, nonatomic) IBOutlet UIButton *animateButton;

- (IBAction)animate:(id)sender;

@end
