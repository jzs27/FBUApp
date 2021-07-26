//
//  HomeViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/12/21.
//

//interface header
#import "ReservationLocationViewController.h"

// standard includes
#import <Parse/Parse.h>

// relative includes
#import "SceneDelegate.h"
#import "LoginViewController.h"
#import "ReservationCalendarViewController.h"
#import "LocationViewController.h"

@interface ReservationLocationViewController ()<ReuseLocationDelegate>

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property UIActivityIndicatorView *activityView;

@end

@implementation ReservationLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationLabel.text = @"";
}

-(void)didSetLocation:(NSString *)location;{
    self.location = location;
    self.locationLabel.text = self.location;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"fromReservationLocation"]){
        ReservationCalendarViewController *calendarVehicleViewController  = [segue destinationViewController];
        calendarVehicleViewController.reservation = self.reservation;
    }
    if ([[segue identifier] isEqualToString:@"fromLocation"]){
        LocationViewController *reuseLocation = [segue destinationViewController];
        reuseLocation.delegate = self;
    }
}

- (IBAction)didTapNext:(id)sender {
    self.activityView = [[UIActivityIndicatorView alloc]
                                             initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    self.activityView.center=self.view.center;
    [self.activityView startAnimating];
    [self.view addSubview:self.activityView];
    [self createReservaton:self.location];
}

-(void)createReservaton:(NSString*)location{
    Reservation *newReservation = [Reservation new];
    newReservation.location = self.location;
    newReservation.rentee = [PFUser currentUser];
    [self.activityView startAnimating];
    
    [newReservation saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (error) {
                NSLog(@"Here's the error, %@",error);
                
            } else {
                NSLog(@"Yo it succeeded!");
                [self.activityView stopAnimating];
                [self performSegueWithIdentifier:@"fromReservationLocation" sender:nil];
            }
    }];
    self.reservation = newReservation;
}

@end
