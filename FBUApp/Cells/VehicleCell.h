//
//  VehicleCell.h
//  FBUApp
//
//  Created by jessicasyl on 7/13/21.
//

#import <UIKit/UIKit.h>

// relative includes
#import "Vehicle.h"

NS_ASSUME_NONNULL_BEGIN

@interface VehicleCell : UITableViewCell

@property (nonatomic) Vehicle *vehicle;
@property (weak, nonatomic) IBOutlet UIImageView *vehicleView;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

NS_ASSUME_NONNULL_END
