//
//  VehicleCalendarViewController.h
//  FBUApp
//
//  Created by jessicasyl on 7/19/21.
//

#import <UIKit/UIKit.h>

#import "Vehicle.h"

NS_ASSUME_NONNULL_BEGIN

@interface VehicleCalendarViewController : UIViewController

@property Vehicle *vehicle;
@property bool *firstDate;

@end

NS_ASSUME_NONNULL_END
