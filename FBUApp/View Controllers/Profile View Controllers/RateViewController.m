//
//  RateViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/15/21.
//

#import "RateViewController.h"

#import <Parse/Parse.h>

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

- (IBAction)didType:(id)sender {
    self.currentValue = [self.rateField.text intValue];
}


- (IBAction)didTapConfirm:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"Vehicle"];
    
    

    NSString *vehicleID = self.vehicle.objectId;
    [query getObjectInBackgroundWithId:vehicleID
                                 block:^(PFObject *vehicle, NSError *error) {
        if (self.currentValue != nil){
            vehicle[@"rate"] = [NSNumber numberWithInt:self.currentValue];
        }
    
        
        
        [vehicle saveInBackground];
    }];
    
    [self performSegueWithIdentifier:@"fromRate" sender:nil];
    
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
