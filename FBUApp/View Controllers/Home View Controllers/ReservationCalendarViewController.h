//
//  ReservationCalendarViewController.h
//  FBUApp
//
//  Created by jessicasyl on 7/19/21.
//

#import <UIKit/UIKit.h>

#import "Reservation.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReservationCalendarViewController : UIViewController

@property NSDate *startDate;
@property NSDate *endDate;
@property bool *firstDate;
@property NSString *location;
@property Reservation *reservation;


@end

NS_ASSUME_NONNULL_END
