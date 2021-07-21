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

@end

@implementation ConfirmVehicleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PFFileObject *image = self.vehicle.image;
    NSURL *imageURL = [NSURL URLWithString:image.url];
    [self.vehicleView setImageWithURL:imageURL];
    
    //self.priceLabel.text = [NSString stringWithFormat:@"%@",self.vehicle.rate];
    
    self.vehicleInfoLabel.text = [NSString stringWithFormat:@"%@/%@/%@", self.vehicle.make,self.vehicle.model,self.vehicle.year ];
    
    
//    NSDate *date= self.startDate;
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//
//    formatter.dateFormat = @"MMM dd";
//
//    self.dateLabel.text = [formatter stringFromDate:date];
    
    
}

- (IBAction)didTapConfirm:(id)sender {
    [self performSegueWithIdentifier:@"backToProfile" sender:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
