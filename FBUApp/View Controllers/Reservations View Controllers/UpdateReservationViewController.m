//
//  UpdateReservationViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/28/21.
//

#import "UpdateReservationViewController.h"

#import "SelectVehicleViewController.h"
#import "ReservationLocationViewController.h"
#import "ReservationCalendarViewController.h"

@interface UpdateReservationViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *vehicleView;

@end

@implementation UpdateReservationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.reservation);
}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"updateVehicle"]){
        SelectVehicleViewController *selectVehicle = [segue destinationViewController];
        selectVehicle.reservation = self.reservation;
    }
    if ([[segue identifier] isEqualToString:@"updateLocation"]){
        SelectVehicleViewController *selectVehicle = [segue destinationViewController];
        selectVehicle.reservation = self.reservation;
    }
    if ([[segue identifier] isEqualToString:@"updateDates"]){
        SelectVehicleViewController *selectVehicle = [segue destinationViewController];
        selectVehicle.reservation = self.reservation;
    }
}
    
- (IBAction)didTapVehicle:(id)sender {
    [self performSegueWithIdentifier:@"updateVehicle" sender:nil];
}

- (IBAction)didTapRentalDates:(id)sender {
    [self performSegueWithIdentifier:@"updateDates" sender:nil];
}

- (IBAction)didTapLocation:(id)sender {
    [self performSegueWithIdentifier:@"updateLocation" sender:nil];
}

@end
