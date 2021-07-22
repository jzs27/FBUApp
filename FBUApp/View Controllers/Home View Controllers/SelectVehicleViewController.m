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
- (void)addTypeFilter:(NSString *)type{
    PFQuery *query = [PFQuery queryWithClassName:@"Vehicle"];
    
    query.limit = 20;
    
    [query whereKey:@"type" equalTo:type];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *vehicles, NSError *error) {
        if (vehicles != nil) {
            self.arrayOfVehicles = vehicles;
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)addPriceFilter:(NSString *)price{
    PFQuery *query = [PFQuery queryWithClassName:@"Vehicle"];
    
    query.limit = 20;
    if ([price  isEqual: @"highToLow"]){
        [query orderByDescending:@"rate"];
    }
    if ([price  isEqual: @"lowToHigh"]){
        [query orderByAscending:@"rate"];
    }
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *vehicles, NSError *error) {
        if (vehicles != nil) {
            self.arrayOfVehicles = vehicles;
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)addMultiFilter:(NSArray *)filters{
    NSLog(@"%@",filters);
    self.arrayOfVehicles = [NSArray new];
    for (int i=0; i< [filters count];i++){
        PFQuery *query = [PFQuery queryWithClassName:@"Vehicle"];
        
        query.limit = 20;
        [query whereKey:@"type" equalTo:filters[i]];
        NSLog(@"%@",filters[i]);
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *vehicles, NSError *error) {
            if (vehicles != nil) {
                self.arrayOfVehicles = [vehicles arrayByAddingObjectsFromArray:self.arrayOfVehicles];
                [self.tableView reloadData];
            } else {
                NSLog(@"%@", error.localizedDescription);
            }
        }];
    }
    [self.tableView reloadData];
    
    
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
