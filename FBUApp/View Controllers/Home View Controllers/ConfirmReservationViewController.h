//
//  ConfirmVehicleViewController.h
//  FBUApp
//
//  Created by jessicasyl on 7/12/21.
//

#import <UIKit/UIKit.h>
#import "Vehicle.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConfirmReservationViewController : UIViewController

@property (nonatomic) Vehicle *vehicle;
@property NSDate *startDate;
@property NSDate *endDate;

@end

NS_ASSUME_NONNULL_END
