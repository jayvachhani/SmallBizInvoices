//
//  JBBarChartViewController.h
//  JBChartViewDemo
//
//  Created by Terry Worona on 11/5/13.
//  Copyright (c) 2013 Jawbone. All rights reserved.
//

#import "JBBaseChartViewController.h"

typedef enum : NSInteger {
    DateRange = 0,
    Item = 1,
    Day = 2,
    Price = 3,
    Location = 4
} ChartFilter;

@interface JBBarChartViewController : JBBaseChartViewController

@property(nonatomic, readwrite) ChartFilter currentFilter;

-(instancetype) initWithFilter:(ChartFilter) filter;

-(void) reloadChart;

@end
