//
//  APIManager.h
//  FBUApp
//
//  Created by jessicasyl on 7/26/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface APIManager : UIViewController

- (void)fetchNowPlaying:(void(^)(NSArray *movies, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
