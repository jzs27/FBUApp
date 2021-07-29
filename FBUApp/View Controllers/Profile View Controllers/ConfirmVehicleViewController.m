//
//  ConfirmVehicleViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/16/21.
//

#import "ConfirmVehicleViewController.h"

#import "UIImageView+AFNetworking.h"
#import <Parse/Parse.h>

#import "PopUpViewController.h"
#import "LoginViewController.h"

@interface ConfirmVehicleViewController ()<PopViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *vehicleView;
@property (weak, nonatomic) IBOutlet UILabel *vehicleInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation ConfirmVehicleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    PFFileObject *image = (PFFileObject*) self.vehicle.image;
    NSURL *imageURL = [NSURL URLWithString:image.url];
    [self.vehicleView setImageWithURL:imageURL];
    
    self.vehicleInfoLabel.text = [NSString stringWithFormat:@"%@ %@ %@", self.vehicle.make,self.vehicle.model,self.vehicle.year ];
    self.priceLabel.text = [NSString stringWithFormat:@"$ %@ /day",self.vehicle.rate];
    self.locationLabel.text = self.vehicle.location;
    self.dateLabel.text = [Vehicle createDateString:self.vehicle.availableStartDate withEndDate:self.vehicle.availableEndDate];
}

- (IBAction)didTapConfirm:(id)sender {
    PFUser *user = [PFUser currentUser];
        if (user != nil) {
            self.vehicle.owner = [PFUser currentUser];
            [self.vehicle saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (error){
                }
                else{
                    [self performSegueWithIdentifier:@"backToProfile" sender:nil];
                }
            }];
        }
        else{
            [self showPopUp];
        }
}

-(void)showPopUp{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PopUpViewController *popUp = (PopUpViewController*)[storyboard instantiateViewControllerWithIdentifier:@"popUp"];
    popUp.delegate = self;
    popUp.returnToLogin = YES;
    popUp.message = @"To register your vehicle, please login.";
    [self addChildViewController:popUp];
    popUp.view.frame = self.view.frame;
    [self.view addSubview:popUp.view];
    [popUp didMoveToParentViewController:self];
}

- (void)returnToLogin{
    [self performSegueWithIdentifier:@"fromConfirmVehicletoLogin" sender:nil];
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"backToProfile"]){
        UITabBarController *tabBar = [segue destinationViewController];
        tabBar.selectedIndex = 2;
    }
    
    if ([[segue identifier] isEqualToString:@"fromConfirmVehicletoLogin"]){
        UINavigationController *navigationController = [segue destinationViewController];
        LoginViewController *login = (LoginViewController*)navigationController.topViewController;
        login.vehicle = self.vehicle;
    }
}

@end
