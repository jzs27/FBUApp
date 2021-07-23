//
//  VehicleRegistrationViewController.h
//  FBUApp
//
//  Created by jessicasyl on 7/13/21.
//

#import <UIKit/UIKit.h>

#import "Vehicle.h"

NS_ASSUME_NONNULL_BEGIN

@interface VehicleRegistrationViewController : UIViewController

@property (strong, nonatomic) NSArray *typeData;
@property (strong, nonatomic) NSArray *yearData;
@property (strong, nonatomic) NSString *make;
@property (strong, nonatomic) NSString *model;
@property (strong, nonatomic) NSString *year;
@property (strong, nonatomic) NSString *type;
@property Vehicle *vehicle;

@end

NS_ASSUME_NONNULL_END
