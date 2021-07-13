//
//  LoginViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/12/21.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property UIAlertController *alert;
@property UIAlertAction *okAction;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
            [self performSegueWithIdentifier:@"fromLogin" sender:nil];
        
        }
    }];
    
}

- (void)registerUser {
//go to Sign Up Screen
    [self performSegueWithIdentifier:@"fromLoginToSignUp" sender:nil];
            
}

//creates custom error alert
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
