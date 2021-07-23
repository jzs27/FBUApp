//
//  ReservationCalendarViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/19/21.
//

#import "ReservationCalendarViewController.h"

#import "SelectVehicleViewController.h"
#import "CalendarViewController.h"

@interface ReservationCalendarViewController ()<ReuseCalendarViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end

@implementation ReservationCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationLabel.text = self.reservation.location;
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"toCalendar"]){
        CalendarViewController *reuseCalendar = [segue destinationViewController];
        reuseCalendar.delegate = self;
    }
    if ([[segue identifier] isEqualToString:@"fromReservationCalendar"]){
        SelectVehicleViewController *selectVehicle = [segue destinationViewController];
        selectVehicle.reservation = self.reservation;
    }
}

-(void)addDate:(NSDate *)date{
    self.startDate = date;
    }

-(void)updateDates{
    self.reservation.startRentDate = self.startDate;
    self.reservation.endRentDate = self.endDate;
    [self.reservation saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error){
            
        }
        else{
            [self performSegueWithIdentifier:@"fromReservationCalendar" sender:nil];
        }
    }];
}

- (IBAction)didTapNext:(id)sender {
    [self updateDates];
    
}

@end
