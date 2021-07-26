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
    
    //self.mapView.constraints = self.view.frame.size.height;
    self.mapOn = NO;
  
  GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:31.968599
                                                          longitude:-99.901813
                                                               zoom:5];
    [self.mapView setCamera:camera];
    self.mapView.settings.myLocationButton = YES;
    self.mapView.settings.zoomGestures = YES;
    self.mapView.settings.scrollGestures = YES;
    self.mapView.delegate = self;
    [self createLocations];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.searchBar.delegate = self;
}

#pragma mark - GSMapViewDelegate

-(void)mapView:(GMSMapView *)mapView didTapMarker:(nonnull GMSMarker *)marker{
    [self.delegate didSetLocation:marker.title];
    NSLog(@"Tapped on marker");
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
    [UIView animateWithDuration:0.5 animations:^{
            CGRect mapFrame = self.mapView.frame;
            mapFrame.origin.y -= 448;
            self.mapView.frame = mapFrame;

        CGRect tableFrame = self.tableView.frame;
        tableFrame.origin.y += 404;
        self.tableView.frame = tableFrame;
        
        CGRect searchFrame = self.searchBar.frame;
        searchFrame.origin.y += 448;
        self.searchBar.frame = searchFrame;
    }];

}

-(void)lowerMap{
    [UIView animateWithDuration:0.5 animations:^{
            CGRect mapFrame = self.mapView.frame;
            mapFrame.origin.y += 448;
            self.mapView.frame = mapFrame;

        CGRect tableFrame = self.tableView.frame;
        tableFrame.origin.y -= 404;
        self.tableView.frame = tableFrame;
        
        CGRect searchFrame = self.searchBar.frame;
        //searchFrame.origin.y = 0;
        searchFrame.origin.y -= 448;
        self.searchBar.frame = searchFrame;
    }];
}

@end
