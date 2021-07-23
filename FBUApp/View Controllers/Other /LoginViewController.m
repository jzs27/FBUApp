//
//  LoginViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/12/21.
//

//interface header
#import "LoginViewController.h"

//standard includes
#import <Parse/Parse.h>

//relative includes
#import "Vehicle.h"
#import "Reservation.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property UIAlertController *alert;
@property UIAlertAction *okAction;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)didTapLogin:(id)sender {
    [self loginUser];
    
}

- (IBAction)didTapSignUp:(id)sender {
    [self registerUser];
}

- (void)loginUser {
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
            [self createAlert:error.localizedDescription];
            [self clearFields];
        } else {
            NSLog(@"User logged in successfully");
            [self clearFields];
            [self performSegueWithIdentifier:@"fromLoginToHome" sender:nil];
        }
    }];
}

- (void)registerUser {
    [self performSegueWithIdentifier:@"fromLoginToSignUp" sender:nil];
            
}

-(void) createAlert:(NSString *)error{
    self.alert = [UIAlertController alertControllerWithTitle:@"Error" message:error preferredStyle:(UIAlertControllerStyleAlert)];
    self.okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                             
                                                     }];
    [self.alert addAction:self.okAction];
    [self presentViewController:self.alert animated:YES completion:^{
    }];
}

-(void)clearFields{
    self.usernameTextField.text = @"";
    self.passwordTextField.text=@"";
}

/*
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
}
*/

@end
