//
//  Reservation.m
//  FBUApp
//
//  Created by jessicasyl on 7/12/21.
//

#import "Reservation.h"

@implementation Reservation

@dynamic vehicle;
@dynamic endRentDate;
@dynamic rentee;
@dynamic renter;
@dynamic startRentDate;

+ (nonnull NSString *)parseClassName {
    return @"Reservation";
}

+ (void) createReservation:( PFUser*)renter withVehicle:(Vehicle*)vehicle withStartDate:(NSDate*)startDate withEndDate:(NSDate*)endDate withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Reservation *newReservation = [Reservation new];
    newReservation.vehicle = vehicle;
    newReservation.rentee = [PFUser currentUser];
    newReservation.renter = renter;
    newReservation.startRentDate =startDate;
    newReservation.endRentDate = endDate;
    
    [newReservation saveInBackgroundWithBlock: completion];
}

@end
