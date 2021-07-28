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
#import "PopUpViewController.h"
#import "UpdateReservationViewController.h"

@interface ReservationsViewController ()<UITableViewDelegate,UITableViewDataSource, PopViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *arrayOfReservations;

@end

@implementation ReservationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PFUser *user = [PFUser currentUser];
    if (user == nil){
        [self showPopUp];
    }
    self.tableView.dataSource=self;
    self.tableView.delegate = self;
    
    if (user != nil){
        [self fetchReservations];
    }
}

-(void)showPopUp{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PopUpViewController *popUp = (PopUpViewController*)[storyboard instantiateViewControllerWithIdentifier:@"popUp"];
    popUp.delegate = self;
    popUp.message = @"To view your current reservation, please login.";
    [self addChildViewController:popUp];
    popUp.view.frame = self.view.frame;
    [self.view addSubview:popUp.view];
    [popUp didMoveToParentViewController:self];
}

-(void)returnToLogin{
    [self performSegueWithIdentifier:@"fromReservationToLogin" sender:self];
}

- (void)fetchReservations{
    PFQuery *query = [PFQuery queryWithClassName:@"Reservation"];
    query.limit = 40;
    [query includeKey:@"vehicle"];
    [query orderByDescending:@"createdAt"];
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


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"toUpdateReservation"]){
        UpdateReservationViewController *updateReservation = [segue destinationViewController];
        updateReservation.reservation = self.reservation;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReservationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReservationCell" forIndexPath:indexPath];
    Reservation *reservation = self.arrayOfReservations[indexPath.row];
    cell.reservation = reservation;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfReservations.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Reservation *reservation = self.arrayOfReservations[indexPath.row];
    self.reservation = reservation;
    [self performSegueWithIdentifier:@"toUpdateReservation" sender:nil];
}

@end
