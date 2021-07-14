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
#import "ProfileVehicleCell.h"

@interface ProfileViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *arrayOfVehicles;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self onTimer];
}
- (IBAction)didTapRegister:(id)sender {
    [self performSegueWithIdentifier:@"fromProfile" sender:nil];
}

- (void)onTimer {
    [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(onTimer) userInfo:nil repeats:true];
    PFQuery *query = [PFQuery queryWithClassName:@"Vehicle"];
    query.limit = 20;
    //[query whereKey:@"location" equalTo:self.location];
    [query findObjectsInBackgroundWithBlock:^(NSArray *vehicles, NSError *error) {
        if (vehicles != nil) {
            self.arrayOfVehicles = vehicles;
            [self.tableView reloadData];

        } else {
            NSLog(@"%@", error.localizedDescription);
        }
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
    ProfileVehicleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileVehicleCell" forIndexPath:indexPath];
    Vehicle *vehicle = self.arrayOfVehicles[indexPath.row];
    //cell.vehicle = vehicle;
    return cell;
}



@end
