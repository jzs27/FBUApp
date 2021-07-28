//
//  Vehicle.m
//  FBUApp
//
//  Created by jessicasyl on 7/12/21.
//
#import "Vehicle.h"

@implementation Vehicle

@dynamic postID;
@dynamic location;
@dynamic image;
@dynamic rate;
@dynamic owner;
@dynamic type;
@dynamic year;
@dynamic make;
@dynamic model;
@dynamic seats;
@dynamic availableEndDate;
@dynamic availableStartDate;
@dynamic geoPoint;


+ (nonnull NSString *)parseClassName {
    return @"Vehicle";
}

+(void) createVehicle: (NSString*)location withCompletion: (PFBooleanResultBlock  _Nullable)completion{
    Vehicle *newVehicle = [Vehicle new];
    newVehicle.location = location;
    newVehicle.owner = [PFUser currentUser];
    
    [newVehicle saveInBackgroundWithBlock: completion];    
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    if (!imageData) {
        return nil;
    }
    return [PFFileObject fileObjectWithName:@"image.png"  data:imageData];
}

+(NSString *)createDateString:(NSDate *)startDate withEndDate:(NSDate *)endDate {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MMM dd";
    
    NSString *startDateString = [formatter stringFromDate:startDate];
    NSString *endDateString = [formatter stringFromDate:endDate];
    
    return [NSString stringWithFormat:@"%@ - %@",startDateString,endDateString];
        
}

@end
