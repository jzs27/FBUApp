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
    self.locationLabel.text = self.location;
    
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"toCalendar"]){
        CalendarViewController *reuseCalendar = [segue destinationViewController];
        reuseCalendar.delegate = self;
    }
    if ([[segue identifier] isEqualToString:@"fromReservationCalendar"]){
        SelectVehicleViewController *selectVehicle = [segue destinationViewController];
        selectVehicle.startDate= self.startDate;
        selectVehicle.endDate = self.endDate;
        selectVehicle.location = self.location;
    }
        

}

-(void)addDate:(NSDate *)date{
    self.startDate = date;
    }

- (IBAction)didTapNext:(id)sender {
    [self performSegueWithIdentifier:@"fromReservationCalendar" sender:nil];
}

@end
