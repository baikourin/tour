//
//  NSObject+AsrManager.h
//  Runner
//
//  Created by guanglin on 2020/02/15.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface AsrManager:NSObject
typedef void(^AsrCallback)(NSString* message);
+(instancetype)initWith:(AsrCallback)success failure:
(AsrCallback)failure;
- (void)start;
- (void)stop;
- (void)cancel;
@end

