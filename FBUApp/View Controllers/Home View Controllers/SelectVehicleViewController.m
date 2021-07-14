//
//  SelectVehicleViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/12/21.
//

// interface header
#import "SelectVehicleViewController.h"

// standard includes
#import <Parse/Parse.h>

// relative includes
#import "Vehicle.h"
#import "VehicleCell.h"
#import "ConfirmVehicleViewController.h"

@interface SelectVehicleViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *arrayOfVehicles;


@end

@implementation SelectVehicleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self onTimer];
//    NSLog(@"Dates:");
//    NSLog(@"%@", self.startDate);
//    NSLog(@"%@", self.endDate);
//    NSLog(@"%lu", (unsigned long)self.arrayOfData.count);
}

- (void)onTimer {
    [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(onTimer) userInfo:nil repeats:true];
    PFQuery *query = [PFQuery queryWithClassName:@"Vehicle"];
    query.limit = 20;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *vehicles, NSError *error) {
        if (vehicles != nil) {
            self.arrayOfVehicles = vehicles;
            [self.tableView reloadData];
            //NSLog(@"%@",self.arrayOfVehicles);

        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    Vehicle *vehicle = sender;
    UINavigationController *navController  = [segue destinationViewController];
    ConfirmVehicleViewController *confirmVehicleViewController = [navController topViewController];
    confirmVehicleViewController.vehicle = vehicle;
    confirmVehicleViewController.startDate = self.startDate;
    confirmVehicleViewController.endDate = self.endDate;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfVehicles.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Vehicle *vehicle = self.arrayOfVehicles[indexPath.row];
    [self performSegueWithIdentifier:@"fromSelectVehicle" sender:vehicle];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VehicleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VehicleCell" forIndexPath:indexPath];
    Vehicle *vehicle = self.arrayOfVehicles[indexPath.row];
    cell.vehicle = vehicle;
    return cell;
}

@end
