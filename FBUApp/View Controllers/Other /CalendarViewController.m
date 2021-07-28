//
//  ReuseCalendarViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/19/21.
//

#import "CalendarViewController.h"

@interface CalendarViewController ()<FSCalendarDelegate,FSCalendarDataSource>

@end

int calendarCount;

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    calendarCount =0;
    self.calendar.dataSource = self;
    self.calendar.delegate = self;
    if (calendarCount > 2){
        self.calendar.allowsMultipleSelection = NO;
    }
    if (calendarCount <= 2){
        self.calendar.allowsMultipleSelection = YES;
    }
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{
    calendarCount++;
    if (calendarCount == 2){
        self.calendar.allowsSelection = NO;
        
    }
    [self.delegate addDate:date];
}

- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{
    calendarCount--;
    if (calendarCount < 2){
        self.calendar.allowsSelection = YES;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

- (IBAction)didClearSelection:(id)sender {

}

/*
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}
*/

@end
