//
//  main.m
//  CoreDataApp
//
//  Created by Helina Devaraj on 7/30/18.
//  Copyright © 2018 Helina Devaraj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        if (@available(iOS 10.0, *)) {
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        } else {
            // Fallback on earlier versions
        }
    }
}
