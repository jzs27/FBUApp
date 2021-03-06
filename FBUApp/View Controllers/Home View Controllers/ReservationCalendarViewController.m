//
//  ReservationCalendarViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/19/21.
//

#import "ReservationCalendarViewController.h"

#import "SelectVehicleViewController.h"
#import "CalendarViewController.h"
#import "PopUpViewController.h"

@interface ReservationCalendarViewController ()<ReuseCalendarViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property UIActivityIndicatorView *activityView;
@property bool selectedOneDate;
@property NSDate *date1;
@property NSDate *date2;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation ReservationCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationLabel.text = self.reservation.location;
    self.locationLabel.textAlignment = NSTextAlignmentCenter;
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    self.selectedOneDate = YES;
    self.dateLabel.text = @"";
    
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
    
    if (self.selectedOneDate == YES){
        self.date1 = date;
        self.selectedOneDate = NO;
    }
    else{
        self.date2 = date;
        self.startDate = [self.date1 earlierDate:self.date2];
        self.endDate = [self.date1 laterDate:self.date2];
        
        self.dateLabel.text = [Reservation createDateString:self.startDate withEndDate:self.endDate];
    }
}

-(void)showPopUp{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PopUpViewController *popUp = (PopUpViewController*)[storyboard instantiateViewControllerWithIdentifier:@"popUp"];
    popUp.message = @"Please select both your rental start and end date";
    [self addChildViewController:popUp];
    popUp.view.frame = self.view.frame;
    [self.view addSubview:popUp.view];
    [popUp didMoveToParentViewController:self];
}

- (IBAction)didTapNext:(id)sender {
    if (self.startDate == nil || self.endDate == nil){
        [self showPopUp];
    }
    else{
        self.activityView = [[UIActivityIndicatorView alloc]
                                                 initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
        self.activityView.center=self.view.center;
        [self.activityView startAnimating];
        [self.view addSubview:self.activityView];
        [self updateDates];
    }
}

-(void)updateDates{
    self.reservation.startRentDate = self.startDate;
    self.reservation.endRentDate = self.endDate;
    [self.reservation saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error){
        }
        else{
            [self.activityView stopAnimating];
            [self performSegueWithIdentifier:@"fromReservationCalendar" sender:nil];
        }
    }];
}

- (IBAction)didTapX:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
