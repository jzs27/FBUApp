//
//  VehicleCalendarViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/19/21.
//

#import "VehicleCalendarViewController.h"

#import "CalendarViewController.h"
#import "VehicleRegistrationViewController.h"
#import "PopUpViewController.h"

@interface VehicleCalendarViewController ()<ReuseCalendarViewDelegate>

@property UIActivityIndicatorView *activityView;
@property NSDate *startDate;
@property NSDate *endDate;
@property NSDate *date1;
@property NSDate *date2;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation VehicleCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedOneDate = YES;
    self.locationLabel.text = self.vehicle.location;
    self.locationLabel.textAlignment = NSTextAlignmentCenter;
    self.dateLabel.text = @"";
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"toReuseCalendar"]){
        CalendarViewController *reuseCalendar = [segue destinationViewController];
        reuseCalendar.delegate = self;
    }
    if ([[segue identifier] isEqualToString:@"fromVehicleCalendar"]){
        VehicleRegistrationViewController *vehicleRegistration = [segue destinationViewController];
        vehicleRegistration.vehicle = self.vehicle;
    }
}

-(void)addDate:(NSDate *)date{
    if (self.selectedOneDate == YES){
        self.date1 = date;
        self.selectedOneDate = NO;
    }
    else{
        self.date2 = date;
        self.startDate = [self.date1 earlierDate:self.date2];
        self.endDate = [self.date1 laterDate:self.date2];
        
        self.dateLabel.text = [Vehicle createDateString:self.startDate withEndDate:self.endDate];
    }
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
    self.vehicle.availableStartDate = self.startDate;
    self.vehicle.availableEndDate  = self.endDate;
    [self.vehicle saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error){
            NSLog(@"Error:%@",error.localizedDescription);
        }
        else{
            [self.activityView stopAnimating];
            [self performSegueWithIdentifier:@"fromVehicleCalendar" sender:nil];
        }
    }];
}

- (IBAction)didTapX:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)showPopUp{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PopUpViewController *popUp = (PopUpViewController*)[storyboard instantiateViewControllerWithIdentifier:@"popUp"];
    popUp.message = @"Please select your vehicle availability dates.";
    [self addChildViewController:popUp];
    popUp.view.frame = self.view.frame;
    [self.view addSubview:popUp.view];
    [popUp didMoveToParentViewController:self];
}

@end
