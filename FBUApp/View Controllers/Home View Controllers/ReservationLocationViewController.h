//
//  HomeViewController.h
//  FBUApp
//
//  Created by jessicasyl on 7/12/21.
//

#import <UIKit/UIKit.h>

#import "Reservation.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReservationLocationViewController : UIViewController

@property NSString *location;
@property Reservation *reservation;

@end

NS_ASSUME_NONNULL_END
