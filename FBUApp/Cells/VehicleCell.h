//
//  XIBVehicleCell.h
//  FBUApp
//
//  Created by jessicasyl on 7/20/21.
//

#import <UIKit/UIKit.h>

#import "Vehicle.h"

NS_ASSUME_NONNULL_BEGIN

@interface VehicleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *vehicleView;
@property (weak, nonatomic) IBOutlet UILabel *vehicleInfoLabel;
@property (nonatomic) Vehicle *vehicle;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;

@end

NS_ASSUME_NONNULL_END
