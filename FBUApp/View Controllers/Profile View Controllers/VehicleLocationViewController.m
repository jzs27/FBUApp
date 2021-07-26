//
//  VehicleLocationViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/19/21.
//

#import "VehicleLocationViewController.h"

#import <Parse/Parse.h>

#import "LocationViewController.h"
#import "VehicleCalendarViewController.h"

@interface VehicleLocationViewController ()<ReuseLocationDelegate>

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property UIActivityIndicatorView *activityView;

@end

@implementation VehicleLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationLabel.text = @"";
}

-(void)didSetLocation:(NSString *)location;{
    self.location = location;
    self.locationLabel.text = self.location;
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
    self.activityView = [[UIActivityIndicatorView alloc]
                                             initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    self.activityView.center=self.view.center;
    [self.activityView startAnimating];
    [self.view addSubview:self.activityView];
    
    [self createVehicle:self.location];
}

-(void)createVehicle:(NSString*)location{
    Vehicle *newVehicle = [Vehicle new];
    newVehicle.location = location;
    newVehicle.owner = [PFUser currentUser];
    
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

@end
