//
//  ConfirmVehicleViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/12/21.
//

#import "ConfirmVehicleViewController.h"

// standard includes
#import "UIImageView+AFNetworking.h"

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
    
}
- (IBAction)didTapConfirmButton:(id)sender {
//    Reservation createReservation:<#(nonnull PFUser *)#> withVehicle:<#(nonnull Vehicle *)#> withStartDate:<#(nonnull NSDate *)#> withEndDate:<#(nonnull NSDate *)#> withCompletion:<#^(BOOL succeeded, NSError * _Nullable error)completion#>
    [self performSegueWithIdentifier:@"fromConfirmVehicle" sender:nil];
}

- (void)setVehicle:(Vehicle *)vehicle{
    _vehicle = vehicle;
    PFFileObject *image = self.vehicle.image;
    NSURL *imageURL = [NSURL URLWithString:image.url];
    [self.vehicleView setImageWithURL:imageURL];
    //self.rateLabel.text = [NSString stringWithFormat:@"%@",self.vehicle.rate];
    self.infoLabel.text = self.vehicle.make;
    
}



/*
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}
*/

@end
