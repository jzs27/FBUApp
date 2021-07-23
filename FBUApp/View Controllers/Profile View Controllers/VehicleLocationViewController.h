//
//  VehicleLocationViewController.h
//  FBUApp
//
//  Created by jessicasyl on 7/19/21.
//

#import <UIKit/UIKit.h>

#import "Vehicle.h"

NS_ASSUME_NONNULL_BEGIN

@interface VehicleLocationViewController : UIViewController

@property Vehicle *vehicle;
@property (nonatomic) NSString *location;

@end

NS_ASSUME_NONNULL_END
