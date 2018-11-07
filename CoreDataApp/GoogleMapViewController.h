//
//  GoogleMapViewController.h
//  CoreDataApp
//
//  Created by Helina Devaraj on 11/7/18.
//  Copyright © 2018 Helina Devaraj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <GoogleMaps/GoogleMaps.h>




NS_ASSUME_NONNULL_BEGIN

@interface GoogleMapViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate>

{
    IBOutlet MKMapView *mapGView;
    CLLocation *location;
    CLLocationManager *locationManager;
    CLLocationDegrees *myLocation;
    CLLocationCoordinate2D coordinate;
    NSString *currentLat,*currentLong;
}

@end

NS_ASSUME_NONNULL_END
