//
//  VehicleCell.m
//  FBUApp
//
//  Created by jessicasyl on 7/13/21.
//

//interface header
#import "VehicleCell.h"

//standard includes
#import "UIImageView+AFNetworking.h"

@implementation VehicleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setVehicle:(Vehicle *)vehicle{
    _vehicle = vehicle;
    
    PFFileObject *image = self.vehicle.image;
    NSURL *imageURL = [NSURL URLWithString:image.url];
    [self.vehicleView setImageWithURL:imageURL];

}

@end
