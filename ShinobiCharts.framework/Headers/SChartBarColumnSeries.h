//
//  SChartBarColumnSeries.h
//  SChart
//
//  Copyright 2011 Scott Logic Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SChartCartesianSeries.h"
#import "SChartBarColumnSeriesStyle.h"

/** This is the base class for column and bar series - containing all of the common functions between the two. To display a bar or column series on the chart init and use one of the classes `SChartBarSeries` or `SChartColumnSeries` respectively. 
 
 @available Standard
 @available Premium
 @sample BarChart
 @sample ColumnChart
 @sa ChartsUserGuide
 */
@interface SChartBarColumnSeries : SChartCartesianSeries

#pragma mark -
#pragma mark Config settings

/** The orientation of the axis with which this series is associated.
 
 SChartSeriesOrientation is defined as follows:
 
 - SChartSeriesOrientationHorizontal: Configures the orientation of the axis with which this series is associated to be horizontal. Thus the controlled variable will be drawn on the x-axis, while the measured variable will be drawn on the y-axis.
 - SChartSeriesOrientationVertical: Configures the orientation of the axis with which this series is associated to be vertical. Thus the controlled variable will be drawn on the y-axis, while the measured variable will be drawn on the x-axis.
 
 The orientation for bar series is vertical, and the orientation for column series is horizontal.
 */
@property (nonatomic, assign) SChartSeriesOrientation orientation;
/*
 The number of edges used to create a rounded corner.
 The default value is 15.

 This value can be lowered to reduce the amount of memory used when creating bars & columns with rounded corners.
 However, this will impacts the smoothness of the rounded corners.

 This value can be raised to increase the smoothness of the rounded corners on bars & columns.
 However, this will impacts performance and increase memory usage.
 */
@property (nonatomic, assign) NSUInteger numberOfCornerEdges;

@end
