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

@end

@implementation ConfirmReservationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setVehicle:self.vehicle];
    NSLog(@"Date at confirm vehicle:");
    NSLog(@"%@",self.startDate);
    
}

- (IBAction)didTapConfirmButton:(id)sender {
//    PFUser *renter = self.vehicle.owner;
//    [Reservation createReservation:renter withVehicle:self.vehicle withStartDate:self.startDate withEndDate:self.endDate withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
//        if (error) {
//
//        } else {
//            NSLog(@"Yo it succeeded!");
//        }
//    }];
    
    [self performSegueWithIdentifier:@"fromConfirmVehicle" sender:nil];
}

- (void)setVehicle:(Vehicle *)vehicle{
    _vehicle = vehicle;
    
    PFFileObject *image = self.vehicle.image;
    NSURL *imageURL = [NSURL URLWithString:image.url];
    [self.vehicleView setImageWithURL:imageURL];
    
    self.priceLabel.text = [NSString stringWithFormat:@"%@",self.vehicle.rate];
    
    self.vehicleLabel.text = [NSString stringWithFormat:@"%@/%@/%@", self.vehicle.make,self.vehicle.model,self.vehicle.year ];
    
    
    NSDate *date= self.startDate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    formatter.dateFormat = @"MMM dd";
    //formatter.dateStyle = NSDateFormatterShortStyle;
    //formatter.timeStyle = NSDateFormatterNoStyle;
    self.dateLabel.text = [formatter stringFromDate:date];
 
    //[dateFormat setDateFormat:@"MMM dd"];
}

/*
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}
*/

@end
