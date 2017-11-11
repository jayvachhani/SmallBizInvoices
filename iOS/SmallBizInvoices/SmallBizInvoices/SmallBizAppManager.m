//
//  SmallBizAppManager.m
//  SmallBizInvoices
//
//  Created by Jay Vachhani on 11/11/17.
//  Copyright © 2017 Reema Bhalani. All rights reserved.
//

#import "SmallBizAppManager.h"

@implementation SmallBizAppManager

static SmallBizAppManager* sharedInstance = nil;

+(instancetype) sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self alloc];
    });
    
    return sharedInstance;
}

- (instancetype) init {
    @throw [NSException
            exceptionWithName:NSInternalInconsistencyException
            reason:@"Use -[SmallBizAppManager sharedInstance]"
            userInfo:nil
            ];
}


@end
