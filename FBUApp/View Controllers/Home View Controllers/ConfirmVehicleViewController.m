//
//  ConfirmVehicleViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/12/21.
//

#import "ConfirmVehicleViewController.h"

// standard includes
#import "UIImageView+AFNetworking.h"
#import <Parse/Parse.h>

//relative includes
#import "Vehicle.h"
#import "Reservation.h"

@interface ConfirmVehicleViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *vehicleView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation ConfirmVehicleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setVehicle:self.vehicle];
    
    NSLog(@"Dates:");
    NSLog(@"%@", self.startDate);
    NSLog(@"%@", self.endDate);
    
}
- (IBAction)didTapConfirmButton:(id)sender {
    PFUser *renter = self.vehicle.owner;
    [Reservation createReservation:renter withVehicle:self.vehicle withStartDate:self.startDate withEndDate:self.endDate withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            
        } else {
            NSLog(@"Yo it succeeded!");
        }
    }];
    
    [self performSegueWithIdentifier:@"fromConfirmVehicle" sender:nil];
}

- (void)setVehicle:(Vehicle *)vehicle{
    _vehicle = vehicle;
    PFFileObject *image = self.vehicle.image;
    NSURL *imageURL = [NSURL URLWithString:image.url];
    [self.vehicleView setImageWithURL:imageURL];
    self.infoLabel.text = self.vehicle.make;
    
}



/*
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}
*/

@end
