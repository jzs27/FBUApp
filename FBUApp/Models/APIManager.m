//
//  APIManager.m
//  FBUApp
//
//  Created by jessicasyl on 7/26/21.
//

#import "APIManager.h"

@interface APIManager()
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation APIManager

- (id)init {
    self = [super init];

    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];

    return self;
}

- (void)fetchNowPlaying:(void(^)(NSArray *movies, NSError *error))completion {
    
    NSURL *url = [NSURL URLWithString:@"https://stage.abgapiservices.com:443/cars/catalog/v1/vehicles/rates?brand=Avis&country_code=US&discount_code=K8166000&dropoff_date=2020-12-31T00%3A00%3A00&dropoff_location=EWR&iata_number=0104724P&loyalty_code=M21R322&loyalty_company_id=AD&membership_code=S3Z91K&pickup_date=2020-12-30T00%3A00%3A00&pickup_location=EWR&rate_code=G3&transaction_id=23492034738&vehicle_class_code=A"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);

            // The network request has completed, but failed.
            // Invoke the completion block with an error.
            // Think of invoking a block like calling a function with parameters
            completion(nil, error);
        }
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            NSArray *dictionaries = dataDictionary[@"results"];
            NSLog (@"%@",dictionaries);
            //NSArray *movies = [Movie moviesWithDictionaries:dictionaries];

            // The network request has completed, and succeeded.
            // Invoke the completion block with the movies array.
            // Think of invoking a block like calling a function with parameters
            //completion(movies, nil);
        }
    }];
    [task resume];
}

@end
