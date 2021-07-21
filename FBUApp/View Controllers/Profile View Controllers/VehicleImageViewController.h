//
//  VehicleImageViewController.h
//  FBUApp
//
//  Created by jessicasyl on 7/21/21.
//

#import <UIKit/UIKit.h>

#import "Vehicle.h"

NS_ASSUME_NONNULL_BEGIN

@interface VehicleImageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *vehicleView;
@property (strong, nonatomic) UIImage *image;
@property Vehicle *vehicle;

@end

NS_ASSUME_NONNULL_END
