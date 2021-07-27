//
//  ReuseLocationViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/19/21.
//

#import "LocationViewController.h"

#import <CoreLocation/CoreLocation.h>
#import "math.h"

@interface LocationViewController () <GMSMapViewDelegate, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *arrayOfLocations;
@property (strong, nonatomic) NSMutableArray *filteredArrayOfLocations;
@property CLLocationManager *locationManager;
@property bool *mapOn;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *mapButton;

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.searchBar.delegate = self;
    [self setInitialConstraints];
    
    [self setUpMapCamera];
  
}

-(void)setInitialConstraints{
    self.searchBar.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.mapView.translatesAutoresizingMaskIntoConstraints = NO;
   
    [self.searchBar.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.searchBar.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:0.0].active = YES;
    [self.searchBar.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:0.0].active = YES;
    
    [self.tableView.topAnchor constraintEqualToAnchor:self.searchBar.bottomAnchor].active = YES;
    [self.tableView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.tableView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [self.tableView.heightAnchor constraintEqualToConstant:350.0].active = YES;
    
    [self.mapView.topAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [self.mapView.heightAnchor constraintEqualToConstant:350.0].active= YES;

}

-(void)setUpMapCamera{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:37.968599
                                                            longitude:-95.901813
                                                                 zoom:3];
      [self.mapView setCamera:camera];
      self.mapView.settings.myLocationButton = YES;
      self.mapView.settings.zoomGestures = YES;
      self.mapView.settings.scrollGestures = YES;
      self.mapView.delegate = self;
      [self createLocations];
      
}

#pragma mark - GSMapViewDelegate

-(void)mapView:(GMSMapView *)mapView didTapMarker:(nonnull GMSMarker *)marker{
    [self.delegate didSetLocation:marker.title];
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
        
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:marker.position.latitude
                                                                longitude:marker.position.longitude
                                                                     zoom:7];
          [self.mapView setCamera:camera];
        
    }];
}

-(void)createLocations{
    
    CLLocationCoordinate2D houston = CLLocationCoordinate2DMake(29.760427, -95.369803);
    CLLocationCoordinate2D austin = CLLocationCoordinate2DMake(30.267153, -97.743061);
    CLLocationCoordinate2D dallas = CLLocationCoordinate2DMake(32.776664, -96.796988);
    
    CLLocationCoordinate2D sanAntonio = CLLocationCoordinate2DMake(29.422122, -98.493628);
    
    GMSMarker *marker = [[GMSMarker alloc] init];
      marker.position = houston;
      marker.title = @"Houston";
      marker.snippet = @"Texas";
      marker.map = self.mapView;
      [self.arrayOfLocations addObject:marker];
    
      
      GMSMarker *marker2 = [[GMSMarker alloc] init];
        marker2.position = austin;
        marker2.title = @"Austin";
        marker2.snippet = @"Texas";
        marker2.map = self.mapView;
      [self.arrayOfLocations addObject:marker2];
      
      GMSMarker *marker3 = [[GMSMarker alloc] init];
        marker3.position = dallas;
        marker3.title = @"Dallas";
        marker3.snippet = @"Texas";
        marker3.map = self.mapView;
      [self.arrayOfLocations addObject:marker3];
      
      GMSMarker *marker4 = [[GMSMarker alloc] init];
        marker4.position = sanAntonio;
        marker4.title = @"San Antonio";
        marker4.snippet = @"Texas";
        marker4.map = self.mapView;
      [self.arrayOfLocations addObject:marker4];
      
    self.arrayOfLocations = [NSMutableArray arrayWithObjects:marker,marker2,marker3,marker4, nil];
    self.filteredArrayOfLocations = self.arrayOfLocations;
}

- (IBAction)didTapCurrentLocation:(id)sender {
    if (self.locationManager == nil){
        
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.desiredAccuracy =
            kCLLocationAccuracyNearestTenMeters;
        self.locationManager.delegate = self;
            }
    [self.locationManager requestWhenInUseAuthorization];
    
        [self.locationManager startUpdatingLocation];
    
    CLLocation *curPos = self.locationManager.location;
    
    CLLocationCoordinate2D currentLocation = CLLocationCoordinate2DMake(curPos.coordinate.latitude, curPos.coordinate.longitude);
    
    GMSMarker *curPosMarker = [[GMSMarker alloc] init];
      curPosMarker.position = currentLocation;
      curPosMarker.title = @"Your Current Location";
      curPosMarker.map = self.mapView;
    
    [self findClosestLocation:currentLocation];
    
}

-(void)findClosestLocation:(CLLocationCoordinate2D) currentLocation{
    float closest = -1;
    GMSMarker *closestLocation = nil;
    
    int radEarth = 6371;

    for(int i=0;i<self.arrayOfLocations.count;i++){
        GMSMarker *marker = self.arrayOfLocations[i];

        CLLocationCoordinate2D pos = marker.position;
        
        double lat = pos.latitude;
        double lng = pos.longitude;
        double mlat = currentLocation.latitude;
        double mlng = currentLocation.longitude;
        
        double chLat = mlat - lat;
        double chLng = mlng -lng;
        
        double dLat = chLat * (M_PI/180);
        double dLng = chLng * (M_PI/180);
        
        double rLat1 = mlat * (M_PI/180);
        double rLat2 = lat * (M_PI/180);

        double a = sin(dLat/2) * sin(dLat/2) + sin(dLng/2) *sin(dLng/2) * cos(rLat1) * cos(rLat2);
        
        double c = 2 * atan2(sqrt(a),sqrt(1-a));
        double d = radEarth * c;
        
        if (closest == -1 || d < closest){
            closestLocation = self.arrayOfLocations[i];
            closest = d;
        }
    }
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:closestLocation.position.latitude
                                                            longitude:closestLocation.position.longitude
                                                                 zoom:7];
      [self.mapView setCamera:camera];
    
    [self.delegate didSetLocation:closestLocation.title];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell;
    
    if (tableView == self.tableView){
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        GMSMarker *marker = [self.filteredArrayOfLocations objectAtIndex:indexPath.row] ;
        cell.textLabel.text = marker.title;
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredArrayOfLocations.count;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (searchText.length != 0) {
        
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(GMSMarker *evaluatedObject, NSDictionary *bindings) {
            GMSMarker *marker = evaluatedObject;
            NSString *title = evaluatedObject.title;
            return [title containsString:searchText];
        }];
        self.filteredArrayOfLocations = [self.arrayOfLocations filteredArrayUsingPredicate:predicate];
                
    }
    else {
        self.filteredArrayOfLocations = self.arrayOfLocations;
    }
    
    [self.tableView reloadData];
 
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = YES;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    NSString *searchText = (NSString *) self.searchBar.text;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self.delegate didSetLocation:cell.textLabel.text];
    self.searchBar.text = cell.textLabel.text;
    self.tableView.hidden = YES;
}


- (IBAction)didTapMap:(id)sender {
    if (self.mapOn == NO){
        [self raiseMap];
        self.mapOn = YES;
        [self.mapButton setTitle:@"Location List" forState:UIControlStateNormal];
        
    }
    else{
        [self lowerMap];
        self.mapOn = NO;
        [self.mapButton setTitle:@"Map" forState:UIControlStateNormal];
    }
}

-(void)raiseMap{
    [self.view layoutIfNeeded];
    
    [self.searchBar.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = NO;
    [self.mapView.topAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = NO;
    [self.searchBar.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = NO;
    [self.searchBar.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = NO;
    [self.tableView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = NO;
    [self.tableView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = NO;

    
    //[self.mapView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.mapView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.mapView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    
    //[self.searchBar.topAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        CGRect mapFrame = self.mapView.frame;
        mapFrame.origin.y -= self.view.frame.size.height;
        self.mapView.frame = mapFrame;
        
        CGRect searchFrame = self.searchBar.frame;
        searchFrame.origin.y += self.view.frame.size.height;
        self.searchBar.frame = searchFrame;
        
        CGRect tableFrame = self.tableView.frame;
        tableFrame.origin.y += self.view.frame.size.height;
        self.tableView.frame = tableFrame;
        
    }];
    
}

-(void)lowerMap{
    [self.view layoutIfNeeded];
    
    [self.mapView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = NO;
    [self.mapView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = NO;
    [self.mapView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = NO;
    [self.searchBar.topAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = NO;
   
    [self.searchBar.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.mapView.topAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [self.searchBar.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.searchBar.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [self.tableView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.tableView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
        
        CGRect mapFrame = self.mapView.frame;
        mapFrame.origin.y += self.view.frame.size.height;
        self.mapView.frame = mapFrame;

        CGRect searchFrame = self.searchBar.frame;
        searchFrame.origin.y -= self.view.frame.size.height;
        self.searchBar.frame = searchFrame;

        CGRect tableFrame = self.tableView.frame;
        tableFrame.origin.y -= self.view.frame.size.height;
        self.tableView.frame = tableFrame;
        
    }];
    
}

@end
