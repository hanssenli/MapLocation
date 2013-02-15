//
//  HALViewController.h
//  MapLocation
//
//  Created by Hanssen Li on 2/15/13.
//  Copyright (c) 2013 Hanssen Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface HALViewController : UIViewController <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end
