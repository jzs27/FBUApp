//
//  VehicleCalendarViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/19/21.
//

#import "VehicleCalendarViewController.h"

#import "ReuseCalendarViewController.h"
#import "VehicleRegistrationViewController.h"

@interface VehicleCalendarViewController ()<ReuseCalendarViewDelegate>

@end

@implementation VehicleCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated{
    
    NSLog(@"Using vehicle: %@",self.vehicle.objectId);
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"toReuseCalendar"]){
        ReuseCalendarViewController *reuseCalendar = [segue destinationViewController];
        reuseCalendar.delegate = self;
    }
    else{
        VehicleRegistrationViewController *vehicleRegistration = [segue destinationViewController];
        vehicleRegistration.vehicle = self.vehicle;
    }
}

-(void)addDate:(NSDate *)date{
    PFQuery *query = [PFQuery queryWithClassName:@"Vehicle"];

    NSString *vehicleID = self.vehicle.objectId;
    NSLog(@"Vehicle ID,%@", vehicleID);
    self.vehicle.availableStartDate = date;
    [self.vehicle saveInBackground];
    }

- (IBAction)didTapNext:(id)sender {
    [self performSegueWithIdentifier:@"fromVehicleCalendar" sender:nil];
}

@end
