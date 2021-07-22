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
#import "ConfirmReservationViewController.h"
#import "VehicleCell.h"
#import "FilterViewController.h"

@interface SelectVehicleViewController ()<UITableViewDataSource,UITableViewDelegate,FilterViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *arrayOfVehicles;
@property UIRefreshControl *refreshControl;

@end

@implementation SelectVehicleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self fetchVehicles];
    
    
    
}

- (void)fetchVehicles {    
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

-(void)addQueryFilter:(NSString *)filter{
    PFQuery *query = [PFQuery queryWithClassName:@"Vehicle"];
    NSLog(@"she's running");
    query.limit = 20;
    [query whereKey:@"type" equalTo:filter];
    [query findObjectsInBackgroundWithBlock:^(NSArray *vehicles, NSError *error) {
        if (vehicles != nil) {
            self.arrayOfVehicles = vehicles;
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"fromSelectVehicle"]){
    Vehicle *vehicle = sender;
    ConfirmReservationViewController *confirmVehicleViewController   = [segue destinationViewController];
    confirmVehicleViewController.vehicle = vehicle;
    confirmVehicleViewController.startDate = self.startDate;
    confirmVehicleViewController.endDate = self.endDate;
    }
    if ([[segue identifier] isEqualToString:@"toFilter"]){
        FilterViewController *filter = [segue destinationViewController];
        filter.delegate = self;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfVehicles.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Vehicle *vehicle = self.arrayOfVehicles[indexPath.row];
    [self performSegueWithIdentifier:@"fromSelectVehicle" sender:vehicle];
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
