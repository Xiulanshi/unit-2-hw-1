//
//  APIManager.h
//  LearnAPI
//
//  Created by Xiulan Shi on 9/20/15.
//  Copyright © 2015 Xiulan Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIManager : NSObject

+ (void) GETRequestWithURL:(NSURL *)URL
         completionHandler:(void(^)(NSData *data, NSURLResponse *response, NSError *error))
completionBlock;

@end
