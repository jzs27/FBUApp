//
//  VehicleLocationViewController.h
//  FBUApp
//
//  Created by jessicasyl on 7/19/21.
//

#import <UIKit/UIKit.h>

#import "Vehicle.h"
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface VehicleLocationViewController : UIViewController

@property Vehicle *vehicle;
@property (nonatomic) NSString *location;
@property (nonatomic) PFGeoPoint *geoPoint;

@end

NS_ASSUME_NONNULL_END
