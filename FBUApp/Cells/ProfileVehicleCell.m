//
//  ProfileVehicleCell.m
//  FBUApp
//
//  Created by jessicasyl on 7/14/21.
//

#import "ProfileVehicleCell.h"

@implementation ProfileVehicleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [self setVehicle:self.vehicle];
}

- (void)setVehicle:(Vehicle *)vehicle{
    _vehicle = vehicle;
}

@end
