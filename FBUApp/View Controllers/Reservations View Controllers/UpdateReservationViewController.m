//
//  UpdateReservationViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/28/21.
//

#import "UpdateReservationViewController.h"

#import "UIImageView+AFNetworking.h"
#import <Parse/Parse.h>

#import "SelectVehicleViewController.h"
#import "ReservationLocationViewController.h"
#import "ReservationCalendarViewController.h"

@interface UpdateReservationViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *vehicleView;
@property (weak, nonatomic) IBOutlet UILabel *vehicleInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation UpdateReservationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setReservation:self.reservation];
    NSLog(@"At update: %@",self.reservation);
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

-(void)setReservation:(Reservation *)reservation{
    PFFileObject *image = (PFFileObject*) self.reservation.vehicle.image;
    NSURL *imageURL = [NSURL URLWithString:image.url];
    [self.vehicleView setImageWithURL:imageURL];
    
        self.locationLabel.text = self.reservation.location;
    self.vehicleInfoLabel.text = [NSString stringWithFormat:@"%@ %@ %@", self.reservation.vehicle.make,self.reservation.vehicle.model,self.reservation.vehicle.year ];
    self.dateLabel.text = [Reservation createDateString:self.reservation.startRentDate withEndDate:self.reservation.endRentDate];
    
}

@end
