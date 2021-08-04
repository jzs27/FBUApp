//
//  VehicleLocationViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/19/21.
//

#import "VehicleLocationViewController.h"

#import "LocationViewController.h"
#import "VehicleCalendarViewController.h"
#import "PopUpViewController.h"

@interface VehicleLocationViewController ()<ReuseLocationDelegate>

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property UIActivityIndicatorView *activityView;

@end

@implementation VehicleLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationLabel.text = @"";
    self.locationLabel.textAlignment = NSTextAlignmentCenter;
}

-(void)didSetLocation:(NSString *)location;{
    self.location = location;
    self.locationLabel.text = self.location;
}

-(void)didSetLocation:(NSString *)location withGeoPoint:(PFGeoPoint *)geoPoint{
    self.location = location;
    self.geoPoint = geoPoint;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"toReuseLocation"]){
        LocationViewController *reuseLocation = [segue destinationViewController];
        reuseLocation.delegate = self;
    }
    if ([[segue identifier] isEqualToString:@"fromVehicleLocation"]){
        VehicleCalendarViewController *vehicleCalendar = [segue destinationViewController];
        vehicleCalendar.vehicle = self.vehicle;
    }    
}

- (IBAction)didTapNext:(id)sender {
    if (self.location == nil){
        [self showPopUp];
    }
    else{
        self.activityView = [[UIActivityIndicatorView alloc]
                                                 initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
        self.activityView.center=self.view.center;
        [self.activityView startAnimating];
        [self.view addSubview:self.activityView];
        
        [self createVehicle:self.location];
    }
}

-(void)createVehicle:(NSString*)location{
    Vehicle *newVehicle = [Vehicle new];
    newVehicle.location = location;
    
    if (self.geoPoint != nil){
        newVehicle.geoPoint = self.geoPoint;
    }
    
    [newVehicle saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (error) {
                NSLog(@"Error:, %@",error);
                
            } else {
                [self.activityView stopAnimating];
                [self performSegueWithIdentifier:@"fromVehicleLocation" sender:nil];
            }
    }];
    self.vehicle = newVehicle;
}

- (IBAction)didTapx:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)showPopUp{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PopUpViewController *popUp = (PopUpViewController*)[storyboard instantiateViewControllerWithIdentifier:@"popUp"];
    popUp.message = @"Please select your vehicle location.";
    [self addChildViewController:popUp];
    popUp.view.frame = self.view.frame;
    [self.view addSubview:popUp.view];
    [popUp didMoveToParentViewController:self];
}

@end
