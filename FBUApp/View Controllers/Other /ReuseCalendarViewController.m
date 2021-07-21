//
//  ReuseCalendarViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/19/21.
//

#import "ReuseCalendarViewController.h"



@interface ReuseCalendarViewController ()<FSCalendarDelegate,FSCalendarDataSource>

@end

int calendarCount;

@implementation ReuseCalendarViewController



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
        self.calendar.allowsMultipleSelection = NO;
    }
    [self.delegate addDate:date];
    
}

- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{
    calendarCount--;
    if (calendarCount < 2){
        self.calendar.allowsMultipleSelection = YES;
    }
    NSLog(@"%d",calendarCount);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}



/*
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}
*/

@end
