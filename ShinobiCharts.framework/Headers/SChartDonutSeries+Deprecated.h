//
//  SChartDonutSeries+Deprecated.h
//  ShinobiCharts
//
//  Copyright Scott Logic Ltd 2015. All rights reserved.
//
//

#import "SChartDonutSeries.h"
#import "ShinobiHeaderMacros.h"

@interface SChartDonutSeries ()

/* DEPRECATED - This should be a private method, so will be taken off the public API in a future commit.
 
 Draw a slice of the series. */
- (void)drawSlice:(NSInteger)sliceIndex
          ofTotal:(NSInteger)totalSlices
        fromAngle:(CGFloat)startAngle
          toAngle:(CGFloat)endAngle
       fromCentre:(CGPoint)centre
  withInnerRadius:(CGFloat)innerRadius
   andOuterRadius:(CGFloat)outerRadius
       asSelected:(BOOL)sel
          inFrame:(CGRect)frame SCHART_DEPRECATED;

/* Creates the labels for the slices in the donut series, and displays them on the chart.
 
 The labels are displayed on each slice in the series.
 
 @param datasource The datasource for the chart. The series gets the labels from the datasource, then displays them in the correct position on the chart.
 @param chart The chart containing the donut series.
 */
-(void)createLabels:(id <SChartDatasource>)datasource onChart:(ShinobiChart *)chart SCHART_DEPRECATED;

@end
