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
#import "PopUpViewController.h"

@interface ReservationLocationViewController ()<ReuseLocationDelegate>

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property UIActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation ReservationLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationLabel.text = @"";
    
    PFUser *user = [PFUser currentUser];
    if (user != nil){
        [self.loginButton setHidden:YES];
    }
}

-(void)didSetLocation:(NSString *)location;{
    self.location = location;
    self.locationLabel.text = self.location;
}

- (void)didSetLocation:(nonnull NSString *)location withGeoPoint:(nonnull PFGeoPoint *)geoPoint {    
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

-(void)showPopUp{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PopUpViewController *popUp = (PopUpViewController*)[storyboard instantiateViewControllerWithIdentifier:@"popUp"];
    popUp.message = @"Please select your rental location.";
    [self addChildViewController:popUp];
    popUp.view.frame = self.view.frame;
    [self.view addSubview:popUp.view];
    [popUp didMoveToParentViewController:self];
}

- (IBAction)didTapNext:(id)sender {
    if (self.location == nil){
        [self showPopUp];
    }
    else{
        self.activityView = [[UIActivityIndicatorView alloc]
                             initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
        self.activityView.center=self.view.center;
        [self.activityView startAnimating];
        [self.view addSubview:self.activityView];
        [self createReservaton:self.location];
    }
}

-(void)createReservaton:(NSString*)location{
    Reservation *newReservation = [Reservation new];
    newReservation.location = self.location;
    [self.activityView startAnimating];
    
    [newReservation saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
        }
        else {
            [self.activityView stopAnimating];
            [self performSegueWithIdentifier:@"fromReservationLocation" sender:nil];
        }
    }];
    self.reservation = newReservation;
}

- (IBAction)didPressLogin:(id)sender {
    [self performSegueWithIdentifier:@"fromHomeToLogin" sender:nil];
}

@end
