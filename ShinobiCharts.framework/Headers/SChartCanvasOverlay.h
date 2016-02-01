//
//  SChartCanvasOverlay.h
//  SChart
//
//  Copyright 2011 Scott Logic Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SChartLayer.h"

@class ShinobiChart;
@class SChartCanvas;

/**
 The canvas overlay is responsible for drawing objects that appear over the
 plot area - such as crosshairs.  It's a transparent layer that is rendered
 _above_ the openGL layer.
 */
@interface SChartCanvasOverlay : UIView <SChartLayer>

/** @name Initializing the overlay */
#pragma mark - Init

/**
 The chart owner - available to let us access the chart objects when we need
 */
@property (nonatomic, assign) ShinobiChart *chart;

/**
 Initialize a canvas-overlay
 */
-(id)initWithFrame:(CGRect)frame usingChart:(ShinobiChart *)parentChart andCanvas:(SChartCanvas *)parentCanvas;

@end
