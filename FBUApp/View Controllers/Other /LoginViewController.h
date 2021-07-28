//
//  LoginViewController.h
//  FBUApp
//
//  Created by jessicasyl on 7/12/21.
//

#import <UIKit/UIKit.h>

#import "Reservation.h"
#import "Vehicle.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController

@property Reservation *reservation;
@property Vehicle *vehicle;

@end

NS_ASSUME_NONNULL_END
