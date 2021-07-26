//
//  SignUpViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/12/21.
//

// interface header
#import "SignUpViewController.h"

//standard includes
#import <Parse/Parse.h>

@interface SignUpViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property UIAlertController *alert;
@property UIAlertAction *okAction;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)didTapSignUp:(id)sender {
    [self registerUser];
}

-(void)registerUser{
    PFUser *newUser = [PFUser user];

    newUser.username = self.usernameTextField.text;
    newUser.password = self.passwordTextField.text;

    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
            [self clearFields];
            [self createAlert:error.localizedDescription];

        } else {
            NSLog(@"User registered successfully");
            [self clearFields];
            [self performSegueWithIdentifier:@"fromSignUp" sender:nil];
            
        }
    }];
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
