//
//  FSCalendarViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/21/21.
//
#import <FSCalendar/FSCalendar.h>

#import "FSCalendarViewController.h"

@interface FSCalendarViewController ()<FSCalendarDelegate,FSCalendarDataSource>




@end

int calendarCount;

@implementation FSCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    calendarCount =0;
    self.calendar.dataSource = self;
    self.calendar.delegate = self;
    if (calendarCount <= 2){
        self.calendar.allowsMultipleSelection = YES;
    }
    

    
}


- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{
    NSLog(@"%@",date);
    calendarCount++;
    
}

- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{
    calendarCount--;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
