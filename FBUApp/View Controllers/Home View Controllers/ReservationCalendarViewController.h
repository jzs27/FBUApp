//
//  ReservationCalendarViewController.h
//  FBUApp
//
//  Created by jessicasyl on 7/19/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReservationCalendarViewController : UIViewController

@property NSDate *startDate;
@property NSDate *endDate;
@property bool *firstDate;

@end

NS_ASSUME_NONNULL_END