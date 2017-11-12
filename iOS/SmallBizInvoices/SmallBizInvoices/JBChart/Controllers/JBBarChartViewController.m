//
//  JBBarChartViewController.m
//  JBChartViewDemo
//
//  Created by Terry Worona on 11/5/13.
//  Copyright (c) 2013 Jawbone. All rights reserved.
//

#import "JBBarChartViewController.h"

// Views
#import "JBBarChartView.h"
#import "JBChartHeaderView.h"
#import "JBBarChartFooterView.h"
#import "JBChartInformationView.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JBConstants.h"

// Numerics
CGFloat const kJBBarChartViewControllerChartHeight = 350.0f;
CGFloat const kJBBarChartViewControllerChartPadding = 10.0f;
CGFloat const kJBBarChartViewControllerChartHeaderHeight = 120.0f;
CGFloat const kJBBarChartViewControllerChartHeaderPadding = 20.0f;
CGFloat const kJBBarChartViewControllerChartFooterHeight = 25.0f;
CGFloat const kJBBarChartViewControllerChartFooterPadding = 5.0f;
CGFloat const kJBBarChartViewControllerBarPadding = 1.0f;

NSInteger const kJBBarChartViewControllerNumBars = 7;
NSInteger const kJBBarChartViewControllerMaxBarHeight = 12;
NSInteger const kJBBarChartViewControllerMinBarHeight = 5;

// Strings
NSString * const kJBBarChartViewControllerNavButtonViewKey = @"view";

@interface JBBarChartViewController () <JBBarChartViewDelegate, JBBarChartViewDataSource>

@property (nonatomic, strong) JBBarChartView *barChartView;
@property (nonatomic, strong) JBChartInformationView *informationView;
@property (nonatomic, strong) NSArray *chartData;
@property (nonatomic, strong) NSArray *monthlySymbols;

// Buttons
- (void)chartToggleButtonPressed:(id)sender;

// Data
- (void)initFakeData;

@end

@implementation JBBarChartViewController

@synthesize currentFilter;

#pragma mark - Alloc/Init

- (id)init
{
    self = [super init];
    if (self)
    {
        [self initFakeData];
    }
    return self;
}

-(instancetype) initWithFilter:(ChartFilter) filter {
    
    self = [super init];
    if (self)
    {
        currentFilter = filter;
        [self initFakeData];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initFakeData];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self initFakeData];
    }
    return self;
}

- (void)dealloc
{
    _barChartView.delegate = nil;
    _barChartView.dataSource = nil;
}

#pragma mark - Date

- (NSArray *) locations {
    return [NSArray arrayWithObjects:@"Mountain View",@"",@"Sunnyvale",@"San Jose",@"San Mateo",@"Gilroy",@"Oakland",@"Belmont", nil];
    
}

- (NSArray *) itemQuantities {
    return [NSArray arrayWithObjects:@"10",@"20",@"60",@"10",@"25",@"60",@"12", nil];
}

- (NSArray *) items {
    return [NSArray arrayWithObjects:@"Wipers",@"Axels",@"Floor Sheets",@"Door Locks",@"Tiers",@"BreakPads",@"Battery", nil];
}


- (NSArray *) prices {
    return [NSArray arrayWithObjects:@"$250",@"$1000",@"$2000",@"@2500",@"$500",@"$1200",@"$2250", nil];
    
}

- (NSArray *) pricesLocations {
    return [NSArray arrayWithObjects:@"$250",@"$800",@"$2000",@"@500",@"$1500",@"$1900",@"$2500", nil];
    
}

- (NSArray *) dates {
    return [NSArray arrayWithObjects:@"10/26",@"11/02",@"11/04",@"11/05",@"11/09",@"11/11",@"11/12", nil];
}

- (NSArray *) days {
    return [NSArray arrayWithObjects:@"Mon",@"Tue",@"Wed",@"Thu",@"Fri",@"Sat", @"Sun", nil];
}

- (void)initFakeData
{
    NSMutableArray *mutableChartData = [NSMutableArray array];
    for (int i=0; i<kJBBarChartViewControllerNumBars; i++)
    {
        NSInteger delta = (kJBBarChartViewControllerNumBars - labs((kJBBarChartViewControllerNumBars - i) - i)) + 2;
        
        [mutableChartData addObject:[NSNumber numberWithFloat:10*i*delta]];
        
//        [mutableChartData addObject:[NSNumber numberWithFloat:MAX((delta * kJBBarChartViewControllerMinBarHeight), arc4random() % (delta * kJBBarChartViewControllerMaxBarHeight))]];

    }

    switch (currentFilter) {
        case DateRange:
            _monthlySymbols = [self dates];
            _chartData = [self prices];
            break;
        case Location:
            _monthlySymbols = [self locations];
            _chartData = [self prices];
            break;
        case Item:
            _chartData = [self itemQuantities];
            _monthlySymbols = [self items];
            break;
        case Price:
            _chartData = [self prices];
            _monthlySymbols = [self days];
            break;
        case Day:
            _monthlySymbols = [self days];
            _chartData = [self prices];
            break;
        default:
            _monthlySymbols = [self days];
            _chartData = [self prices];
            break;
    }
    
}

- (NSString *) title {
    switch (currentFilter) {
        case DateRange:
            return @"Date range";
            break;
        case Location:
            return @"Location";
            break;
        case Item:
            return @"Item Quantities";
            break;
        case Price:
            return @"Price range";
            break;
        case Day:
            return @"Days";
            break;
        default:
            return @"Date range";
            break;
    }
}

-(void) reloadChart {
    [self.barChartView reloadData];
}

#pragma mark - View Lifecycle

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = kJBColorBarChartControllerBackground;
    self.navigationItem.rightBarButtonItem = [self chartToggleButtonWithTarget:self action:@selector(chartToggleButtonPressed:)];

    self.barChartView = [[JBBarChartView alloc] init];
    self.barChartView.frame = CGRectMake(kJBBarChartViewControllerChartPadding, kJBBarChartViewControllerChartPadding, self.view.bounds.size.width - (kJBBarChartViewControllerChartPadding * 2), kJBBarChartViewControllerChartHeight);
    self.barChartView.delegate = self;
    self.barChartView.dataSource = self;
    self.barChartView.headerPadding = kJBBarChartViewControllerChartHeaderPadding;
    self.barChartView.minimumValue = 0.0f;
    self.barChartView.inverted = NO;
    self.barChartView.backgroundColor = kJBColorBarChartBackground;
    
    JBChartHeaderView *headerView = [[JBChartHeaderView alloc] initWithFrame:CGRectMake(kJBBarChartViewControllerChartPadding, ceil(self.view.bounds.size.height * 0.6) - ceil(kJBBarChartViewControllerChartHeaderHeight * 0.5), self.view.bounds.size.width - (kJBBarChartViewControllerChartPadding * 2), kJBBarChartViewControllerChartHeaderHeight)];
    headerView.titleLabel.text = [kJBStringLabelAverageMonthlyTemperature uppercaseString];
    headerView.subtitleLabel.text = kJBStringLabel2012;
    headerView.separatorColor = kJBColorBarChartHeaderSeparatorColor;
    self.barChartView.headerView = headerView;
    
    JBBarChartFooterView *footerView = [[JBBarChartFooterView alloc] initWithFrame:CGRectMake(kJBBarChartViewControllerChartPadding, ceil(self.view.bounds.size.height * 0.5) - ceil(kJBBarChartViewControllerChartFooterHeight * 0.5), self.view.bounds.size.width - (kJBBarChartViewControllerChartPadding * 2), kJBBarChartViewControllerChartFooterHeight)];
    footerView.padding = kJBBarChartViewControllerChartFooterPadding;
    footerView.leftLabel.text = [[self.monthlySymbols firstObject] uppercaseString];
    footerView.leftLabel.textColor = [UIColor whiteColor];
    footerView.rightLabel.text = [[self.monthlySymbols lastObject] uppercaseString];
    footerView.rightLabel.textColor = [UIColor whiteColor];
    self.barChartView.footerView = footerView;
    
    self.informationView = [[JBChartInformationView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, CGRectGetMaxY(self.barChartView.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.barChartView.frame) - CGRectGetMaxY(self.navigationController.navigationBar.frame))];
    [self.view addSubview:self.informationView];

    [self.view addSubview:self.barChartView];
    [self.barChartView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.barChartView setState:JBChartViewStateExpanded];
    
    self.navigationItem.title = [self title];
}

#pragma mark - JBChartViewDataSource

- (BOOL)shouldExtendSelectionViewIntoHeaderPaddingForChartView:(JBChartView *)chartView
{
    return YES;
}

- (BOOL)shouldExtendSelectionViewIntoFooterPaddingForChartView:(JBChartView *)chartView
{
    return NO;
}

#pragma mark - JBBarChartViewDataSource

- (NSUInteger)numberOfBarsInBarChartView:(JBBarChartView *)barChartView
{
	return [self.chartData count];
}

- (void)barChartView:(JBBarChartView *)barChartView didSelectBarAtIndex:(NSUInteger)index touchPoint:(CGPoint)touchPoint
{
    NSNumber *valueNumber = [self.chartData objectAtIndex:index];
    NSString* strVal = @"";
    if ( currentFilter != Item ) {
        strVal = @"$";
    }
    else{
        strVal = @"#";
    }
    
    strVal = [strVal stringByAppendingFormat:@"%d", [valueNumber intValue]];
    
    // Price Or Quantity
    [self.informationView setValueText:strVal unitText:nil];
    
    // Price or Quantity
    [self.tooltipView setText:[strVal uppercaseString]];

    // Location, Item Name, Date, Day
    [self.informationView setTitleText:[[self.monthlySymbols objectAtIndex:index] uppercaseString]];
    
    [self.informationView setHidden:NO animated:YES];
    [self setTooltipVisible:YES animated:YES atTouchPoint:touchPoint];
}

- (void)didDeselectBarChartView:(JBBarChartView *)barChartView
{
    [self.informationView setHidden:NO animated:YES];
    [self setTooltipVisible:NO animated:YES];
}

#pragma mark - JBBarChartViewDelegate

- (CGFloat)barChartView:(JBBarChartView *)barChartView heightForBarViewAtIndex:(NSUInteger)index
{
    return [[self.chartData objectAtIndex:index] floatValue];
}

- (UIColor *)barChartView:(JBBarChartView *)barChartView colorForBarViewAtIndex:(NSUInteger)index
{
    return (index % 2 == 0) ? kJBColorBarChartBarBlue : kJBColorBarChartBarGreen;
}

- (UIColor *)barSelectionColorForBarChartView:(JBBarChartView *)barChartView
{
    return [UIColor whiteColor];
}

- (CGFloat)barPaddingForBarChartView:(JBBarChartView *)barChartView
{
    return kJBBarChartViewControllerBarPadding;
}

#pragma mark - Buttons

- (void)chartToggleButtonPressed:(id)sender
{
	UIView *buttonImageView = [self.navigationItem.rightBarButtonItem valueForKey:kJBBarChartViewControllerNavButtonViewKey];
	buttonImageView.userInteractionEnabled = NO;
	
	CGAffineTransform transform = self.barChartView.state == JBChartViewStateExpanded ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformMakeRotation(0);
	buttonImageView.transform = transform;
	
	[self.barChartView setState:self.barChartView.state == JBChartViewStateExpanded ? JBChartViewStateCollapsed : JBChartViewStateExpanded animated:YES callback:^{
		buttonImageView.userInteractionEnabled = YES;
	}];
}

#pragma mark - Overrides

- (JBChartView *)chartView
{
    return self.barChartView;
}

@end
