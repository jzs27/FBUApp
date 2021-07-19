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
#import "CalendarViewController.h"

@interface ReservationLocationViewController ()

@property NSMutableArray *locations;


@end

@implementation ReservationLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"fromReservationLocation"]){
        UINavigationController *navController  = [segue destinationViewController];
        CalendarViewController *calendarVehicleViewController = [navController topViewController];
        calendarVehicleViewController.location = self.location;
    }
    
    
}



@end
