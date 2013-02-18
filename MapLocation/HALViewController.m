//
//  HALViewController.m
//  MapLocation
//
//  Created by Hanssen Li on 2/15/13.
//  Copyright (c) 2013 Hanssen Li. All rights reserved.
//

#import "HALViewController.h"

@interface HALViewController ()

@end

@implementation HALViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    if([CLLocationManager locationServicesEnabled] == NO)
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Services Disabled" message:@"Please enable your location services for this application" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
    
    // listen to notifications on whether the app is active
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(start) name:@"startLocation" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pause) name:@"pauseLocation" object:nil];
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.desiredAccuracy = 100;
    self.locationManager.distanceFilter = 1000;
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
    [self.mapView setCenterCoordinate:self.mapView.userLocation.coordinate animated:YES];
    MKCoordinateSpan span = MKCoordinateSpanMake(0.03, 0.03);

    MKCoordinateRegion region = MKCoordinateRegionMake(self.mapView.userLocation.coordinate,span);
    
    [self.mapView setRegion:region animated:YES];
}

- (void)start
{
    [self.locationManager startUpdatingHeading];
    [self.locationManager startUpdatingLocation];
    [self.mapView setShowsUserLocation:YES];
    self.mapView.userTrackingMode = YES;

    NSLog(@"Start");

}
- (void)pause
{
    [self.locationManager stopUpdatingHeading];
    [self.locationManager stopUpdatingLocation];
    [self.mapView setShowsUserLocation:NO];
    self.mapView.userTrackingMode = NO;

    NSLog(@"Pause");

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLLocationManagerDelegate methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    NSLog(@"lat: %f, lon:%f", location.coordinate.latitude, location.coordinate.longitude);
    [self addPinToMapAtLocation:location];
}

- (void)addPinToMapAtLocation:(CLLocation *)location
{
    MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
    pin.coordinate = location.coordinate;
    pin.title = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    pin.subtitle = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
    [self.mapView addAnnotation:pin];
    
    MKCoordinateRegion region = MKCoordinateRegionMake(pin.coordinate, self.mapView.region.span);
    [self.mapView setRegion:region animated:YES];
}


@end
