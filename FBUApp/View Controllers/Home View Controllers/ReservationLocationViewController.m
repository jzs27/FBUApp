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
#import "ReuseLocationViewController.h"


@interface ReservationLocationViewController ()<ReuseLocationDelegate>

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end

@implementation ReservationLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationLabel.text = @"";
    
}

- (IBAction)didTapLogout:(id)sender {
    [self logout];
}

-(void)logout{
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error){
        [self dismissViewControllerAnimated:YES completion:nil];
        SceneDelegate *sceneDelegate = (SceneDelegate *)[UIApplication sharedApplication].connectedScenes.allObjects[0].delegate;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        sceneDelegate.window.rootViewController = loginViewController;
    }];
}

-(void)didSetLocation:(NSString *)location;{
    self.location = location;
    self.locationLabel.text = self.location;
    NSLog(@"The location: %@",self.location);
//    [Reservation createReservation:location withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
//
//        if (error) {
//            NSLog(@"Here's the error, %@",error);
//            NSLog(@"Yeah its not working lol!");
//
//        } else {
//            NSLog(@"Yo it succeeded!");
//        }
//    }];
    
}

//-(void)getReservationObject{
//    PFQuery *query = [PFQuery queryWithClassName:@"Reservation"];
//    [query orderByDescending:@"createdAt"];
//    self.reservation = [query getFirstObject];
//    NSLog(@"The reservation: %@",self.reservation);
//}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"fromReservationLocation"]){
        //[self getReservationObject];
        ReservationCalendarViewController *calendarVehicleViewController  = [segue destinationViewController];
        calendarVehicleViewController.location = self.location;
    }
    if ([[segue identifier] isEqualToString:@"fromLocation"]){
        ReuseLocationViewController *reuseLocation = [segue destinationViewController];
        reuseLocation.delegate = self;
    }
}

- (IBAction)didTapNext:(id)sender {
    [self performSegueWithIdentifier:@"fromReservationLocation" sender:nil];
}

@end
