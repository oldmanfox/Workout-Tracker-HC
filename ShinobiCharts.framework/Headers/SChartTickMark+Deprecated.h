//
//  SChartTickMark+Deprecated.h
//  ShinobiCharts
//
//  Copyright Scott Logic Ltd 2015. All rights reserved.
//
//

#import "SChartTickMark.h"

@interface SChartTickMark ()

/* Create a tick mark with a particular label. */
- (id)initWithLabel:(CGRect)labelFrame
            andText:(NSString *)text
SCHART_MSG_DEPRECATED("Use 'init'");

@end
