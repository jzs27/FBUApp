//
//  VehicleCell.m
//  FBUApp
//
//  Created by jessicasyl on 7/13/21.
//

#import "VehicleCell.h"
#import "UIImageView+AFNetworking.h"

@implementation VehicleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setVehicle:(Vehicle *)vehicle{
    _vehicle = vehicle;
    
    PFFileObject *image = self.vehicle.image;
    NSURL *imageURL = [NSURL URLWithString:image.url];
    [self.vehicleView setImageWithURL:imageURL];

}

@end
