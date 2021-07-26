//
//  ConfirmVehicleViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/16/21.
//

#import "ConfirmVehicleViewController.h"

#import "UIImageView+AFNetworking.h"
#import <Parse/Parse.h>

@interface ConfirmVehicleViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *vehicleView;
@property (weak, nonatomic) IBOutlet UILabel *vehicleInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation ConfirmVehicleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    PFFileObject *image = self.vehicle.image;
    NSURL *imageURL = [NSURL URLWithString:image.url];
    [self.vehicleView setImageWithURL:imageURL];
    
    self.vehicleInfoLabel.text = [NSString stringWithFormat:@"%@ %@ %@", self.vehicle.make,self.vehicle.model,self.vehicle.year ];
    
    self.priceLabel.text = [NSString stringWithFormat:@"$ %@ /day",self.vehicle.rate];
    self.locationLabel.text = self.vehicle.location;
    
    self.dateLabel.text = [Vehicle createDateString:self.vehicle.availableStartDate withEndDate:self.vehicle.availableEndDate];
}

- (IBAction)didTapConfirm:(id)sender {
    [self performSegueWithIdentifier:@"backToProfile" sender:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"backToProfile"]){
        UITabBarController *tabBar = [segue destinationViewController];
        
        tabBar.selectedIndex = 2;
    }
}

@end
