//
//  LocationViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/15/21.
//

#import "LocationViewController.h"

#import <GoogleMaps/GoogleMaps.h>

@interface LocationViewController ()

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  // Do any additional setup after loading the view.
  // Create a GMSCameraPosition that tells the map to display the
  // coordinate -33.86,151.20 at zoom level 6.
  GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                          longitude:151.20
                                                               zoom:6];
  GMSMapView *mapView = [GMSMapView mapWithFrame:self.view.frame camera:camera];
  mapView.myLocationEnabled = YES;
  [self.view addSubview:mapView];

  // Creates a marker in the center of the map.
  GMSMarker *marker = [[GMSMarker alloc] init];
  marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
  marker.title = @"Sydney";
  marker.snippet = @"Australia";
  marker.map = mapView;
}

@end
