//
//  ReservationCell.m
//  FBUApp
//
//  Created by jessicasyl on 7/14/21.
//

#import "ReservationCell.h"

//standard includes
#import "UIImageView+AFNetworking.h"

@implementation ReservationCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [self setReservation:self.reservation];
}

- (void)setReservation:(Reservation *)reservation{
    _reservation=reservation;
    
    PFFileObject *image = self.reservation.vehicle.image;
    NSURL *imageURL = [NSURL URLWithString:image.url];
    [self.vehicleView setImageWithURL:imageURL];
    self.locationLabel.text = self.reservation.vehicle.location;
    
}

@end
