//
//  JBStringConstants.h
//  JBChartViewDemo
//
//  Created by Terry Worona on 11/6/13.
//  Copyright (c) 2013 Jawbone. All rights reserved.
//

#define localize(key, default) NSLocalizedStringWithDefaultValue(key, nil, [NSBundle mainBundle], default, nil)

#pragma mark - Labels

#pragma mark - Labels (Bar Chart)

#define kJBStringLabel2012 localize(@"label.2012", @"2012")
#define kJBStringLabelAverageMonthlyTemperature localize(@"label.average.monthly.temperature", @"Average Monthly Temperature")
#define kJBStringLabelWorldwide2012 localize(@"label.worldwide.2013", @"Worldwide - 2012")
#define kJBStringLabelWorldwide2011 localize(@"label.worldwide.2013", @"Worldwide - 2011")
#define kJBStringLabelWorldwideAverage localize(@"label.worldwide.average", @"Worldwide Average")

