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
    
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UINavigationController *navController  = [segue destinationViewController];
        SelectVehicleViewController *selectVehicleViewController = [navController topViewController];
        

}

@end
