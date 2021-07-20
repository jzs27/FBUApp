//
//  VehicleLocationViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/19/21.
//

#import "VehicleLocationViewController.h"

#import <Parse/Parse.h>

#import "ReuseLocationViewController.h"
#import "VehicleCalendarViewController.h"

@interface VehicleLocationViewController ()<ReuseLocationDelegate>

@end

@implementation VehicleLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)didSetLocation:(NSString *)location;{
    [Vehicle createVehicle:location withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Here's the error, %@",error);
            NSLog(@"Yeah its not working lol!");
            
        } else {
            NSLog(@"Yo it succeeded!");
        }
    }];
}

-(void)getVehicleObject{
    PFQuery *query = [PFQuery queryWithClassName:@"Vehicle"];
    [query orderByDescending:@"createdAt"];
    self.vehicle = [query getFirstObject];
    }

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"toReuseLocation"]){
        ReuseLocationViewController *reuseLocation = [segue destinationViewController];
        reuseLocation.delegate = self;
    }
    else{
        VehicleCalendarViewController *vehicleCalendar = [segue destinationViewController];
        [self getVehicleObject];
        vehicleCalendar.vehicle = self.vehicle;
    }    
}

- (IBAction)didTapNext:(id)sender {
    [self performSegueWithIdentifier:@"fromVehicleLocation" sender:nil];
}

@end
