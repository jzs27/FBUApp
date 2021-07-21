//
//  ReuseCalendarViewController.h
//  FBUApp
//
//  Created by jessicasyl on 7/19/21.
//

#import <UIKit/UIKit.h>

#import <FSCalendar/FSCalendar.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ReuseCalendarViewDelegate

-(void)addDate: (NSDate *)date;

@end

@interface ReuseCalendarViewController : UIViewController

@property (nonatomic,weak) id<ReuseCalendarViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *monthly;
@property (weak, nonatomic) IBOutlet FSCalendar *calendar;

@end

NS_ASSUME_NONNULL_END
