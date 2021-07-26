//
//  ConfirmVehicleViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/12/21.
//

#import "ConfirmReservationViewController.h"

// standard includes
#import "UIImageView+AFNetworking.h"
#import <Parse/Parse.h>

//relative includes
#import "Vehicle.h"
#import "Reservation.h"

@interface ConfirmReservationViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *vehicleView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *vehicleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end

@implementation ConfirmReservationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setVehicle:self.reservation.vehicle];
    
}

- (IBAction)didTapConfirmButton:(id)sender {
    [self performSegueWithIdentifier:@"fromConfirmVehicle" sender:nil];
}

- (void)setVehicle:(Vehicle *)vehicle{
    
    PFFileObject *image = self.reservation.vehicle.image;
    NSURL *imageURL = [NSURL URLWithString:image.url];
    [self.vehicleView setImageWithURL:imageURL];
    
    self.priceLabel.text = [NSString stringWithFormat:@"$ %@ /day",self.reservation.vehicle.rate];
    self.locationLabel.text = self.reservation.location;
    
    self.vehicleLabel.text = [NSString stringWithFormat:@"%@ %@ %@", self.reservation.vehicle.make,self.reservation.vehicle.model,self.reservation.vehicle.year ];
    
    self.dateLabel.text = [Reservation createDateString:self.reservation.startRentDate withEndDate:self.reservation.endRentDate];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"fromConfirmVehicle"]){
        UITabBarController *tabBar = [segue destinationViewController];
        
        tabBar.selectedIndex = 1;
    }
}

@end
