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

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *arrayOfVehicles;
@property UIActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation SelectVehicleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self fetchVehicles];
    self.locationLabel.text = self.reservation.location;
    
    self.dateLabel.text = [Reservation createDateString:self.reservation.startRentDate withEndDate:self.reservation.endRentDate];
    
    NSLog(@"%@",self.reservation);
}

- (void)fetchVehicles {    
    PFQuery *query = [PFQuery queryWithClassName:@"Vehicle"];
    query.limit = 20;
    [query whereKey:@"location" equalTo:self.reservation.location];
    [query whereKey:@"availableStartDate" lessThan:self.reservation.startRentDate];
    [query whereKey:@"availableEndDate" greaterThan:self.reservation.endRentDate];
    
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

-(void)addMultiFilter:(NSArray *)filters{
    
    BOOL highToLow = [filters containsObject:@"highToLow"];
    BOOL lowToHigh = [filters containsObject:@"lowToHigh"];
    PFQuery *query = [PFQuery queryWithClassName:@"Vehicle"];
    
    query.limit = 20;
    [query whereKey:@"type" containedIn:filters];
    if (highToLow){
        [query orderByDescending:@"rate"];
    }
    if (lowToHigh){
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

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"fromSelectVehicle"]){
    Vehicle *vehicle = sender;
    ConfirmReservationViewController *confirmReservationViewController   = [segue destinationViewController];
    confirmReservationViewController.reservation = self.reservation;
    
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
    self.activityView = [[UIActivityIndicatorView alloc]
                                             initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    self.activityView.center=self.view.center;
    [self.activityView startAnimating];
    [self.view addSubview:self.activityView];
    
    Vehicle *vehicle = self.arrayOfVehicles[indexPath.row];
    self.reservation.vehicle = vehicle;
    self.reservation.renter = vehicle.owner;
    
    [self.reservation saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error){
            
        }
        else{
            [self.activityView stopAnimating];
            [self performSegueWithIdentifier:@"fromSelectVehicle" sender:vehicle];
        }
    }];
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

- (IBAction)didTapX:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
