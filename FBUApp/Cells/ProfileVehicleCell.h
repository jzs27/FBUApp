//
//  ProfileVehicleCell.h
//  FBUApp
//
//  Created by jessicasyl on 7/14/21.
//

#import <UIKit/UIKit.h>
#import "Vehicle.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileVehicleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *vehicleView;
@property (nonatomic) Vehicle *vehicle;
@property (weak, nonatomic) IBOutlet UILabel *vehicleInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;

@end

NS_ASSUME_NONNULL_END
