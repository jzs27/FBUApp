//
//  ReservationsViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/12/21.
//

// interface header
#import "ReservationsViewController.h"

// standard includes
#import <Parse/Parse.h>

// relative includes
#import "Reservation.h"
#import "ReservationCell.h"

@interface ReservationsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *arrayOfReservations;

@end

@implementation ReservationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource=self;
    self.tableView.delegate = self;
    [self onTimer];

}

- (void)onTimer {
    //[NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(onTimer) userInfo:nil repeats:true];
    PFQuery *query = [PFQuery queryWithClassName:@"Reservation"];
    query.limit = 20;
    [query includeKey:@"vehicle"];
    
    [query whereKey:@"rentee" equalTo:[PFUser currentUser]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *reservations, NSError *error) {
        if (reservations != nil) {
            self.arrayOfReservations = reservations;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReservationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReservationCell" forIndexPath:indexPath];
    Reservation *reservation = self.arrayOfReservations[indexPath.row];
    cell.reservation = reservation;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfReservations.count;
}

@end
