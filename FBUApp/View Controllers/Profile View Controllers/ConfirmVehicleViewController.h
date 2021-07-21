//
//  ConfirmVehicleViewController.h
//  FBUApp
//
//  Created by jessicasyl on 7/16/21.
//

#import <UIKit/UIKit.h>

#import "Vehicle.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConfirmVehicleViewController : UIViewController

@property Vehicle *vehicle;
@property (weak, nonatomic) IBOutlet UIImageView *vehicleView;
@property (weak, nonatomic) IBOutlet UILabel *vehicleInfoLabel;

@end

NS_ASSUME_NONNULL_END
