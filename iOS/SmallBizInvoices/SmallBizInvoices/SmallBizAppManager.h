//
//  SmallBizAppManager.h
//  SmallBizInvoices
//
//  Created by Jay Vachhani on 11/11/17.
//  Copyright © 2017 Reema Bhalani. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSInteger {
    Unknown = 0,
    Employee = 1,
    Manager = 2,
    Owner = 3
} UserType;

@interface SmallBizAppManager : NSObject

+(instancetype) sharedInstance;

@property(nonatomic, readwrite) UserType currentUserType;

@end
