//
//  ProfileViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/12/21.
//

// interface header
#import "ProfileViewController.h"

#import <Parse/Parse.h>

#import "Vehicle.h"
#import "VehicleCell.h"
#import "SceneDelegate.h"
#import "LoginViewController.h"

@interface ProfileViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *arrayOfVehicles;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self fetchVehicles];
    PFUser *currentUser = [PFUser currentUser];
    
    self.usernameLabel.text = [NSString stringWithFormat:@"%@ %@!",@"Hi",currentUser.username];
}

- (IBAction)didTapRegister:(id)sender {
    [self performSegueWithIdentifier:@"fromProfile" sender:nil];
}

- (void)fetchVehicles {
    PFQuery *query = [PFQuery queryWithClassName:@"Vehicle"];
    query.limit = 20;
    [query findObjectsInBackgroundWithBlock:^(NSArray *vehicles, NSError *error) {
        if (vehicles != nil) {
            self.arrayOfVehicles = vehicles;
            [self.tableView reloadData];

        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
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


/*
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}
*/

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfVehicles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VehicleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myXIBCell"];
    
    if (!cell){
        [tableView registerNib:[UINib nibWithNibName:@"XIBVehicleCell" bundle:nil] forCellReuseIdentifier:@"myXIBCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"myXIBCell"];
    }
    Vehicle *vehicle = self.arrayOfVehicles[indexPath.row];
    cell.vehicle = vehicle;
    
    return cell;
}

@end
