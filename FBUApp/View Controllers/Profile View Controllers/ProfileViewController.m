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

@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *arrayOfVehicles;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    PFUser *currentUser = [PFUser currentUser];
    
    if (currentUser != nil){
        self.usernameLabel.text = [NSString stringWithFormat:@"%@ %@!",@"Hi",currentUser.username];
        [self fetchVehicles];
        [self.logoutButton setTitle:@"Logout" forState:UIControlStateNormal];
    }
    else{
        [self.tableView setHidden:YES];
        [self createNoVehiclesView];
        [self.logoutButton setTitle:@"Login" forState:UIControlStateNormal];
    }
}

-(void)createNoVehiclesView{
    CGRect frame = self.tableView.frame;
    UIView *noVehicleView = [[UIView alloc]initWithFrame:frame];
    [noVehicleView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:noVehicleView];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 25, 50)];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:25.0f];
    label.backgroundColor = [UIColor systemGray5Color];
    label.text = @"Login To View Listed Vehicles";
    [noVehicleView addSubview:label];

    [label.topAnchor constraintEqualToAnchor:noVehicleView.topAnchor constant:200.0].active = YES;
    [label.leftAnchor constraintEqualToAnchor:noVehicleView.leftAnchor constant:0.0].active = YES;
    [label.rightAnchor constraintEqualToAnchor:noVehicleView.rightAnchor constant:0.0].active = YES;
}

- (IBAction)didTapRegister:(id)sender {
    [self performSegueWithIdentifier:@"fromProfile" sender:nil];
}

- (void)fetchVehicles {
    PFQuery *query = [PFQuery queryWithClassName:@"Vehicle"];
    query.limit = 40;
    [query orderByDescending:@"createdAt"];
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
