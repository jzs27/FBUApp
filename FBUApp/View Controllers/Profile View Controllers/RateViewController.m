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

@property UIActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation RateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentValue = 30;
    self.rateField.text = [NSString stringWithFormat:@"%i",self.currentValue];
    self.locationLabel.text = self.vehicle.location;
    
    self.dateLabel.text = [Vehicle createDateString:self.vehicle.availableStartDate withEndDate:self.vehicle.availableEndDate];
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
    self.activityView = [[UIActivityIndicatorView alloc]
                                             initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    self.activityView.center=self.view.center;
    [self.activityView startAnimating];
    [self.view addSubview:self.activityView];
    
    self.vehicle.rate = [NSNumber numberWithInt:self.currentValue];
    
    [self.vehicle saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error){
            NSLog(@"Error:%@",error.localizedDescription);
        }
        else{
            [self.activityView stopAnimating];
            [self performSegueWithIdentifier:@"fromRate" sender:nil];
        }
    }];
    
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"fromRate"]){
        ConfirmVehicleViewController *confirmVehicle = [segue destinationViewController];
        confirmVehicle.vehicle = self.vehicle;
    }
}

- (IBAction)didTapX:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
