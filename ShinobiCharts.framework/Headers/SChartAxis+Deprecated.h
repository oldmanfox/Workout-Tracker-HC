//
//  SChartAxis+Deprecated.h
//  ShinobiCharts
//
//  Created by Andrew Polkinghorn on 28/05/2014.
//
//

#import "SChartAxis.h"
#import "ShinobiHeaderMacros.h"

@class SChartMappedSeries;
@class SChartBarColumnSeries;

@interface SChartAxis ()


/* The current _displayed_  range of the axis.
 
 This property is the actual range currently displayed on the visible area of the chart- which may not be the range that was explicitly set. The axis may make small adjustments to the range to make sure that whole bars are displayed etc. This is a `readonly` property - explicit requests to change the axis range should be made through the method `setRangeWithMinimum:andMaximum:`
 
 @see SChartRange
 @see SChartNumberRange
 @see SChartDateRange */
@property (nonatomic, retain, readonly) SChartRange *axisRange SCHART_MSG_DEPRECATED("use 'range' instead");

#pragma mark -
#pragma mark BarColumn Series
/* The smallest change in value between any adjacent bars or columns.
 
 Specifying this can improve the render time of the chart - it will not have to traverse all of the data to compare differences. */
@property (nonatomic) double barColSpacing SCHART_DEPRECATED;

/* Provide bounds and spacing data for column series within the chart to improve performance
 
 @param colSpacing the minimum distance between any two columns along the axis, in data terms.
 @param minX the smallest `xValue` of any column on the axis.
 @param maxX the largest `xValue` of any column on the axis.
 */
- (void)configureColumns:(double) colSpacing withMinX:(NSNumber *)minX withMaxX:(NSNumber *)maxX SCHART_DEPRECATED;

/* Provide bounds and spacing data for bar series within the chart to improve performance
 
 @param barSpacing the minimum distance between any two bars along the axis, in data terms.
 @param minY the smallest `yValue` of any bar on the axis.
 @param maxY the largest `yValue` of any bar on the axis.
 */
- (void)configureBars:(double) barSpacing withMinY:(NSNumber *)minY withMaxY:(NSNumber *)maxY SCHART_DEPRECATED;

@end
