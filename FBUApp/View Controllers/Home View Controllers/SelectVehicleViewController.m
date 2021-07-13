//
//  SelectVehicleViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/12/21.
//

#import "SelectVehicleViewController.h"
#import <Parse/Parse.h>
#import "Vehicle.h"
#import "VehicleCell.h"
#import "ConfirmVehicleViewController.h"

@interface SelectVehicleViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *arrayOfVehicles;


@end

@implementation SelectVehicleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)onTimer {
    [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(onTimer) userInfo:nil repeats:true];
    PFQuery *query = [PFQuery queryWithClassName:@"Vehicle"];
    query.limit = 20;
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *vehicles, NSError *error) {
        if (vehicles != nil) {
            self.arrayOfVehicles=vehicles;
            [self.tableView reloadData];
            // do something with the array of object returned by the call
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
    confirmVehicleViewController.vehicle= vehicle;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
     VehicleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VehicleCell" forIndexPath:indexPath];
    Vehicle *vehicle = self.arrayOfVehicles[indexPath.section];
    cell.vehicle = vehicle;
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfVehicles.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Vehicle *vehicle = self.arrayOfVehicles[indexPath.row];
    [self performSegueWithIdentifier:@"fromSelectVehicle" sender:vehicle];
}





@end
