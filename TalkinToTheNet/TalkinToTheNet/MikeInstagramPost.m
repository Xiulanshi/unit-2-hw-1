//
//  MikeInstagramPost.m
//  CustomTableViewCells
//
//  Created by Xiulan Shi on 9/24/15.
//  Copyright © 2015 Xiulan Shi. All rights reserved.
//

#import "MikeInstagramPost.h"

@implementation MikeInstagramPost


- (instancetype)initWithJSON:(NSDictionary *)json {
    // If you need to overwrite initialize, this is the code you need
    if (self = [super init]) {
        
        self.tags = json[@"tags"];
        
        //self.commentCount = [[[json objectForKey:@"comments"] objectForKey:@"count"] integerValue];
        self.commentCount = [json [@"comments"][@"count"] integerValue];
        self.likeCount = [json [@"likes"][@"count"] integerValue];
        self.caption = json[@"caption"];
        self.username = json[@"user"][@"username"];
        self.fullName = json[@"user"][@"full_name"];
        
        return self;
    }
    return nil;
}


@end
