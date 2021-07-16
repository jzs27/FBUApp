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
  GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:31.968599
                                                          longitude:-99.901813
                                                               zoom:5];
  GMSMapView *mapView = [GMSMapView mapWithFrame:self.view.frame camera:camera];
  mapView.myLocationEnabled = YES;
    mapView.settings.myLocationButton = YES;
  //[self.view addSubview:mapView];
    
    CLLocationCoordinate2D houston = CLLocationCoordinate2DMake(29.760427, -95.369803);
    CLLocationCoordinate2D austin = CLLocationCoordinate2DMake(30.267153, -97.743061);
    CLLocationCoordinate2D dallas = CLLocationCoordinate2DMake(32.776664, -96.796988);
    
    CLLocationCoordinate2D sanAntonio = CLLocationCoordinate2DMake(29.422122, -98.493628);

  // Creates a marker in the center of the map.
  GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = houston;
    marker.title = @"Houston";
    marker.snippet = @"Texas";
    marker.map = mapView;
    
    GMSMarker *marker2 = [[GMSMarker alloc] init];
      marker2.position = austin;
      marker2.title = @"Austin";
      marker2.snippet = @"Texas";
      marker2.map = mapView;
    
    GMSMarker *marker3 = [[GMSMarker alloc] init];
      marker3.position = dallas;
      marker3.title = @"Dallas";
      marker3.snippet = @"Texas";
      marker3.map = mapView;
    
    GMSMarker *marker4 = [[GMSMarker alloc] init];
      marker4.position = sanAntonio;
      marker4.title = @"San Antonio";
      marker4.snippet = @"Texas";
      marker4.map = mapView;
    
//  marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
//  marker.title = @"Sydney";
//  marker.snippet = @"Australia";
//  marker.map = mapView;
}

@end
