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

@end

@implementation VehicleLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)didSetLocation:(NSString *)location;{
    self.location = location;
    
}

-(void)createVehicle:(NSString*)location{
    Vehicle *newVehicle = [Vehicle new];
    newVehicle.location = location;
    newVehicle.owner = [PFUser currentUser];
    
    [newVehicle saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (error) {
                NSLog(@"Here's the error, %@",error);
                
            } else {
                NSLog(@"Yo it succeeded!");
            }
    }];
    self.vehicle = newVehicle;
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
    [self createVehicle:self.location];
    [self performSegueWithIdentifier:@"fromVehicleLocation" sender:nil];
}

@end
