//
//  RateViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/15/21.
//

#import "RateViewController.h"

#import <Parse/Parse.h>

#import "ConfirmVehicleViewController.h"

@interface RateViewController ()

@end

@implementation RateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentValue = 30;
    self.rateField.text = [NSString stringWithFormat:@"%i",self.currentValue];
}

- (IBAction)didTapPlusButton:(id)sender {
    self.currentValue = self.currentValue +5;
    self.rateField.text = [NSString stringWithFormat:@"%i",self.currentValue];
}

- (IBAction)didTapMinusButton:(id)sender {
    self.currentValue = self.currentValue -5;
    self.rateField.text = [NSString stringWithFormat:@"%i",self.currentValue];
}


- (IBAction)didTypeRate:(id)sender {
    self.currentValue = [self.rateField.text intValue];
}

- (IBAction)didTapConfirm:(id)sender {
    self.vehicle.rate = [NSNumber numberWithInt:self.currentValue];
    [self.vehicle saveInBackground];
    
    [self performSegueWithIdentifier:@"fromRate" sender:nil];
    
}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"fromRate"]){
        ConfirmVehicleViewController *confirmVehicle = [segue destinationViewController];
        confirmVehicle.vehicle = self.vehicle;
    }
}


@end
