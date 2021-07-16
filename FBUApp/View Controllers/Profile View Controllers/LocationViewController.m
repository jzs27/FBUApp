//
//  LocationViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/15/21.
//

#import "LocationViewController.h"

#import <GoogleMaps/GoogleMaps.h>

@interface LocationViewController () <GMSMapViewDelegate>

@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (strong, nonatomic) NSMutableArray *arrayOfLocations;

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:31.968599
                                                          longitude:-99.901813
                                                               zoom:5];
    [self.mapView setCamera:camera];
    self.mapView.settings.myLocationButton = YES;
    self.mapView.settings.zoomGestures = YES;
    self.mapView.settings.scrollGestures = YES;
    self.mapView.delegate = self;
  
    CLLocationCoordinate2D houston = CLLocationCoordinate2DMake(29.760427, -95.369803);
    CLLocationCoordinate2D austin = CLLocationCoordinate2DMake(30.267153, -97.743061);
    CLLocationCoordinate2D dallas = CLLocationCoordinate2DMake(32.776664, -96.796988);
    
    CLLocationCoordinate2D sanAntonio = CLLocationCoordinate2DMake(29.422122, -98.493628);

  GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = houston;
    marker.title = @"Houston";
    marker.snippet = @"Texas";
    marker.map = self.mapView;
    
    GMSMarker *marker2 = [[GMSMarker alloc] init];
      marker2.position = austin;
      marker2.title = @"Austin";
      marker2.snippet = @"Texas";
      marker2.map = self.mapView;
    
    GMSMarker *marker3 = [[GMSMarker alloc] init];
      marker3.position = dallas;
      marker3.title = @"Dallas";
      marker3.snippet = @"Texas";
      marker3.map = self.mapView;
    
    GMSMarker *marker4 = [[GMSMarker alloc] init];
      marker4.position = sanAntonio;
      marker4.title = @"San Antonio";
      marker4.snippet = @"Texas";
      marker4.map = self.mapView;
}

#pragma mark - GSMapViewDelegate

-(void)mapView:(GMSMapView *)mapView didTapMarker:(nonnull GMSMarker *)marker{
    self.location = marker.title;
}

@end
