//
//  VehicleCalendarViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/19/21.
//

#import "VehicleCalendarViewController.h"

#import "CalendarViewController.h"
#import "VehicleRegistrationViewController.h"

@interface VehicleCalendarViewController ()<ReuseCalendarViewDelegate>

@end

@implementation VehicleCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstDate = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    
    }

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"toReuseCalendar"]){
        CalendarViewController *reuseCalendar = [segue destinationViewController];
        reuseCalendar.delegate = self;
    }
    if ([[segue identifier] isEqualToString:@"fromVehicleCalendar"]){
        VehicleRegistrationViewController *vehicleRegistration = [segue destinationViewController];
        vehicleRegistration.vehicle = self.vehicle;
    }
}

-(void)addDate:(NSDate *)date{
    if (self.firstDate == YES){
        self.vehicle.availableStartDate = date;
        self.firstDate = NO;
    }
    else{
        self.vehicle.availableEndDate = date;
    }
    [self.vehicle saveInBackground];
    }

- (IBAction)didTapNext:(id)sender {
    [self performSegueWithIdentifier:@"fromVehicleCalendar" sender:nil];
}

@end
