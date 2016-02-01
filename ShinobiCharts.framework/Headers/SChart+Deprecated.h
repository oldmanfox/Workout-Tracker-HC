//
//  SChart+Deprecated.h
//  ShinobiCharts
//
//  Copyright 2015 Scott Logic Ltd. All rights reserved.
//
//

#import "SChart.h"

/* The methods and attributes below are deprecated.
 */
@interface ShinobiChart ()

/* Specifies whether the chart auto-calculates its axis ranges when it reloads its data.
 By default, this property is set to `YES`.
 */
@property (nonatomic, assign) BOOL autoCalculateAxisRanges DEPRECATED_MSG_ATTRIBUTE("set autoCalculateRange per axis instead");

/* The general styling configuration for the whole chart.
 */
@property (nonatomic, retain) SChartTheme *theme DEPRECATED_MSG_ATTRIBUTE("use `applyTheme:`");

/* A reference to the chart object
 */
- (ShinobiChart *)getChart DEPRECATED_ATTRIBUTE;

/* The area rendered by the openGL functions
 */
- (CGRect)getGLFrame DEPRECATED_MSG_ATTRIBUTE("Use 'getPlotAreaFrame' instead.");

/* Apply the current chart theme to the chart.
 */
- (void)applyTheme DEPRECATED_MSG_ATTRIBUTE("use `applyTheme:`");

- (void)redrawChartAndGL:(BOOL)redrawGL DEPRECATED_MSG_ATTRIBUTE("See 'redrawChartIncludePlotArea'");

/* Returns a string describing the version of the Charts framework being used.
 
 This includes a version number, the type of framework (Premium, Standard, or Trial) and the date upon which the version was released.
 */
-(NSString *)getInfo DEPRECATED_MSG_ATTRIBUTE("Use `[ShinobiCharts getInfo]` instead");

/* Returns a string describing the version of the Charts framework being used.
 
 This includes a version number, the type of framework (Premium, Standard, or Trial) and the date upon which the version was released.
 */
+(NSString *)getInfo DEPRECATED_MSG_ATTRIBUTE("Use `[ShinobiCharts getInfo]` instead");

@end
