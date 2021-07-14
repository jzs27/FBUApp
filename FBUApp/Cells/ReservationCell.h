//
//  ReservationCell.h
//  FBUApp
//
//  Created by jessicasyl on 7/14/21.
//

#import <UIKit/UIKit.h>

// relative includes
#import "Reservation.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReservationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *vehicleView;
@property (weak, nonatomic) IBOutlet UILabel *vehicleInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (nonatomic) Reservation *reservation;

@end

NS_ASSUME_NONNULL_END
