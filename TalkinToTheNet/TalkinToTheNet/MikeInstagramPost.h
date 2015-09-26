//
//  MikeInstagramPost.h
//  CustomTableViewCells
//
//  Created by Xiulan Shi on 9/24/15.
//  Copyright © 2015 Xiulan Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MikeInstagramPost : NSObject

@property (nonatomic) NSArray *tags;
@property (nonatomic) NSInteger commentCount;
@property (nonatomic) NSInteger likeCount;
@property (nonatomic) NSString *username;
@property (nonatomic) NSString *fullName;
@property (nonatomic) NSDictionary *caption;

- (instancetype)initWithJSON:(NSDictionary *)json;

@end
