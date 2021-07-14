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
    [self setVehicle:self.vehicle];
}

- (void)setVehicle:(Vehicle *)vehicle{
    _vehicle = vehicle;
    
    PFFileObject *image = self.vehicle.image;
    NSURL *imageURL = [NSURL URLWithString:image.url];
    [self.vehicleView setImageWithURL:imageURL];
    self.rateLabel.text = [NSString stringWithFormat:@"%@",self.vehicle.rate];
    self.infoLabel.text = self.vehicle.make;
}

@end
