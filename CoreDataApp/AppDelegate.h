//
//  AppDelegate.h
//  CoreDataApp
//
//  Created by Helina Devaraj on 7/30/18.
//  Copyright © 2018 Helina Devaraj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

