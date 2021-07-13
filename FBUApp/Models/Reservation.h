//
//  Reservation.h
//  FBUApp
//
//  Created by jessicasyl on 7/12/21.
//

#import <Parse/Parse.h>
#import "Vehicle.h"

NS_ASSUME_NONNULL_BEGIN

@interface Reservation : PFObject<PFSubclassing>
@property (nonatomic, strong) PFUser *rentee;
@property (nonatomic, strong) PFUser *renter;
@property (nonatomic,strong) NSDate *startRentDate;
@property (nonatomic,strong) NSDate *endRentDate;
@property (nonatomic,strong) Vehicle *vehicle;

@end

NS_ASSUME_NONNULL_END
