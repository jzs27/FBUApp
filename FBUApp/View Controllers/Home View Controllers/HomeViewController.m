//
//  HomeViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/12/21.
//

//interface header
#import "HomeViewController.h"

// standard includes
#import <Parse/Parse.h>

// relative includes
#import "SceneDelegate.h"
#import "LoginViewController.h"
#import "CalendarViewController.h"

@interface HomeViewController ()<UIPickerViewDataSource,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *locationPickerView;
@property NSMutableArray *locations;
@property NSMutableArray *arrayOfLocations;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationPickerView.dataSource = self;
    self.locationPickerView.delegate = self;
    
    self.arrayOfLocations = [NSArray arrayWithObjects:@"Houston",@"Dallas",@"Austin", nil];
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

- (void)onTimer {
    [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(onTimer) userInfo:nil repeats:true];
    PFQuery *query = [PFQuery queryWithClassName:@"Vehicle"];
    query.limit = 20;
    [query selectKeys:[NSArray arrayWithObject:@"location"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *locations, NSError *error) {
        if (locations != nil) {
            self.locations = locations;
            NSLog(@"%@",self.locations);
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UINavigationController *navController  = [segue destinationViewController];
    CalendarViewController *calendarVehicleViewController = [navController topViewController];
    calendarVehicleViewController.location = self.location;
    
}

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.arrayOfLocations.count;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.arrayOfLocations[row]; //Or, your suitable title; like Choice-a, etc.
}

- (void)pickerView:(UIPickerView *)thePickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
 
    self.location = self.arrayOfLocations[row];
    CalendarViewController *objOtherViewController = [CalendarViewController new];
    objOtherViewController.location = self.location;
    [self performSegueWithIdentifier:@"fromHome" sender:nil];
}

@end
