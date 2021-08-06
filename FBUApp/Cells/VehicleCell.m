//
//  XIBVehicleCell.m
//  FBUApp
//
//  Created by jessicasyl on 7/20/21.
//

#import "VehicleCell.h"
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
    
    PFFileObject *image = (PFFileObject*) self.vehicle.image;
    NSURL *imageURL = [NSURL URLWithString:image.url];
    [self.vehicleView setImageWithURL:imageURL];
    self.rateLabel.text = [NSString stringWithFormat:@"$%@ / day",self.vehicle.rate];
    
    self.vehicleInfoLabel.text = [NSString stringWithFormat:@"%@ %@ %@", self.vehicle.make,self.vehicle.model,self.vehicle.year ];
    
    self.typeLabel.text = self.vehicle.type;
}

@end
