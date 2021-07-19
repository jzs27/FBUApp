//
//  ReservationCalendarViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/19/21.
//

#import "ReservationCalendarViewController.h"

#import "SelectVehicleViewController.h"

@interface ReservationCalendarViewController ()

@end

@implementation ReservationCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UINavigationController *navController  = [segue destinationViewController];
        SelectVehicleViewController *selectVehicleViewController = [navController topViewController];
        selectVehicleViewController.startDate = self.startDate;
        selectVehicleViewController.endDate = self.endDate;
        //selectVehicleViewController.location = self.location;
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    //self.arrayOfDates = sender;
//    UINavigationController *navController  = [segue destinationViewController];
//    SelectVehicleViewController *selectVehicleViewController = [navController topViewController];
//    selectVehicleViewController.startDate = self.startDate;
//    selectVehicleViewController.endDate = self.endDate;
//    selectVehicleViewController.location = self.location;
//}



@end
