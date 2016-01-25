//
//  ExerciseChartViewController.m
//  90 DWT BB
//
//  Created by Grant, Jared on 1/16/15.
//  Copyright (c) 2015 Jared Grant. All rights reserved.
//

#import "ExerciseChartViewController.h"
#import <ShinobiCharts/ShinobiCharts.h>
#import "CoreDataHelper.h"

@interface ExerciseChartViewController () <SChartDatasource>

@end

@implementation ExerciseChartViewController
{
    ShinobiChart *chart;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    //CGFloat margin = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) ? 10.0 : 50.0;
    chart = [[ShinobiChart alloc] initWithFrame:CGRectInset(self.view.bounds, 0, 0)];
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //NSLog(@"Clicked Workout Index = %@", self.appDelegate.index);
    
    // Only show the graph title for iOS 8 and above.  iOS 7 get the title in the navigation bar.
    float sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (sysVer >= 8.0) {
        
        chart.title = self.appDelegate.graphTitle;
        chart.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
        chart.titleCentresOn = SChartTitleCentresOnChart;
    }
    
    chart.autoresizingMask = ~UIViewAutoresizingNone;

    // Add a pair of axes
    SChartCategoryAxis *xAxis = [[SChartCategoryAxis alloc] init];
    xAxis.title = [self findXAxisTitle];
    xAxis.style.titleStyle.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    //xAxis.rangePaddingLow = @(0.05);
    //xAxis.rangePaddingHigh = @(0.3);
    chart.xAxis = xAxis;

    SChartNumberAxis *yAxis = [[SChartNumberAxis alloc] init];
    yAxis.title = [self findYAxisTitle];
    yAxis.style.titleStyle.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    //yAxis.rangePaddingLow = @(1.0);
    //yAxis.rangePaddingHigh = @(1.0);
    chart.yAxis = yAxis;
    
    // Add the chart to the view controller
    [self.view addSubview:chart];
    
    chart.datasource = self;
    
    // Show legend only on iPad
    //chart.legend.hidden = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
    chart.legend.hidden = NO;
    chart.legend.style.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    chart.legend.placement = SChartLegendPlacementOutsidePlotArea;
    chart.legend.position = SChartLegendPositionBottomMiddle;
    
    // Enable gestures
    yAxis.enableGesturePanning = YES;
    yAxis.enableGestureZooming = YES;
    xAxis.enableGesturePanning = YES;
    xAxis.enableGestureZooming = YES;
    
    // Show the x and y axis gridlines
    xAxis.style.majorGridLineStyle.showMajorGridLines = YES;
    yAxis.style.majorGridLineStyle.showMajorGridLines = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Shinobi Controls

-(NSInteger)numberOfSeriesInSChart:(ShinobiChart *)chart {
    
    NSInteger highestIndexFound = [self GetHighestDatabaseIndex];
    
    /*
    if (highestIndexFound == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Graph Data Error"
                                                        message:@"All Rep/Weight fields for this exercise must have a number in order to display the graph data."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        
        [alert show];
    }
     */
    
    
    return highestIndexFound;
}

-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(NSInteger)index {
    /*
    NSString *tempString = [NSString stringWithFormat:@"%@ - %@", self.appDelegate.graphWorkout, self.appDelegate.graphTitle];
    
    NSArray *columnSeriesWorkouts = @[@"B1: Chest+Tri - Dips",
                                      @"B1: Chest+Tri - Abs",
                                      @"B1: Back+Bi - Close-Grip Chin-Up",
                                      @"B2: Chest - Incline Dumbbell Press 2"];
    int numMatches = 0;
    for (int i = 0; i < columnSeriesWorkouts.count; i++) {
        
        if ([tempString isEqualToString:columnSeriesWorkouts[i]]) {
            
            numMatches++;
        }
    }
    
    if (numMatches == 1) {
        
        // Match - ColumnSeries
        SChartColumnSeries *columnSeries = [[SChartColumnSeries alloc] init];
        
        // Enable area fill
        //columnSeries.style.areaColorGradient = [UIColor clearColor];
        
        NSNumber *tryNumber = [NSNumber numberWithInteger:index + 1];
        
        self.matches = nil;
        self.matches = [self.objects objectAtIndex:index * 6];
        NSString *tempNote = self.matches.notes;
        
        columnSeries.title = [NSString stringWithFormat:@"Try %@ - %@", tryNumber, tempNote];
        
        return columnSeries;
    }
    else {
        
        // No Match - LineSeries
        SChartLineSeries *lineSeries = [[SChartLineSeries alloc] init];
        
        // Enable area fill
        //lineSeries.style.showFill = YES;
        //lineSeries.style.fillWithGradient = YES;
        //lineSeries.style.areaColorLowGradient = [UIColor clearColor];
        
        lineSeries.style.lineWidth = @(2.0);
        lineSeries.style.pointStyle.showPoints = YES;
        NSNumber *tryNumber = [NSNumber numberWithInteger:index + 1];
        
        self.matches = nil;
        self.matches = [self.objects objectAtIndex:index * 6];
        NSString *tempNote = self.matches.notes;
        
        lineSeries.title = [NSString stringWithFormat:@"Try %@ - %@", tryNumber, tempNote];
        
        //series.style.dataPointLabelStyle.showLabels = YES;
        
        return lineSeries;
    }
     */
    
    // ColumnSeries
    SChartColumnSeries *columnSeries = [[SChartColumnSeries alloc] init];
    
    // Enable area fill
    //columnSeries.style.areaColorGradient = [UIColor clearColor];
    
    NSNumber *tryNumber = [NSNumber numberWithInteger:index + 1];
    
    self.matches = nil;
    
    if ([self ColumnSeriesMatchAtIndex:index]) {
        
        self.matches = [self.objects objectAtIndex:0];
        //self.matches = [self.objects objectAtIndex:[self.objects count] - 1];
        NSString *tempNote = self.matches.notes;
        
        columnSeries.title = [NSString stringWithFormat:@"Try %@ - %@", tryNumber, tempNote];
    }
    else {
        
        columnSeries.title = [NSString stringWithFormat:@"Try %@ -  ", tryNumber];
    }

    return columnSeries;
}

-(NSInteger)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(NSInteger)seriesIndex {
    
    NSNumber *tempNumber = [NSNumber numberWithInteger:self.appDelegate.graphDataPoints.count];
    return [tempNumber integerValue];
}

-(id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(NSInteger)dataIndex forSeriesAtIndex:(NSInteger)seriesIndex {
    
    SChartDataPoint *dataPoint = [[SChartDataPoint alloc] init];
    
    self.matches = nil;
    
    [self matchAtIndex:dataIndex :seriesIndex];
    
    NSString *tempReps = self.appDelegate.graphDataPoints[dataIndex];
    NSString *tempString1 = @"";
    NSString *tempString2 = @"";
    
    int duplicate = 0;
    
    for (int i = 0; i <= dataIndex; i++) {
        
        tempString1 = self.appDelegate.graphDataPoints[i];
        
        if ([tempReps isEqualToString:tempString1]) {
            duplicate ++;
            
            if (duplicate > 1) {
                
                tempString2 = [self createXAxisString:tempReps :[NSNumber numberWithInt:duplicate - 1]];
                
            }else {
                
                tempString2 = tempString1;
            }
        }
    }
    
    tempReps = tempString2;
    dataPoint.xValue = tempReps;
    
    if (self.objects.count == 0) {
        
        // No Matches
        dataPoint.yValue = [NSNumber numberWithDouble:0.0];
    }
    else {
        
        // Found a match
        //self.matches = [self.objects objectAtIndex:0];
        self.matches = [self.objects objectAtIndex:[self.objects count] - 1];
        double yValue = [self.matches.weight doubleValue];
        dataPoint.yValue = [NSNumber numberWithDouble:yValue];
    }

    return dataPoint;
}

#pragma mark - Utility Methods

-(NSInteger)GetHighestDatabaseIndex {
    
    // Get Data from the database.
    self.context = [[CoreDataHelper sharedHelper] context];
    
    // Fetch current session data.
    NSString *currentSessionString = [self.appDelegate getCurrentSession];
    
    self.entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:self.context];
    self.request = [[NSFetchRequest alloc] init];
    [self.request setEntity:self.entityDesc];
    self.pred = [NSPredicate predicateWithFormat:@"(session = %@) AND (routine = %@) AND (workout = %@) AND (exercise = %@)",
                         currentSessionString,
                         self.appDelegate.graphRoutine,
                         self.appDelegate.graphWorkout,
                         self.appDelegate.graphTitle];
    [self.request setPredicate:self.pred];
    
    NSError *error;
    self.objects = [self.context executeFetchRequest:self.request error:&error];
    
    NSNumber *highestDatabaseIndex = 0;
    
    for (int i = 0; i < self.objects.count / 6; i++) {
        
        self.matches = nil;
        self.matches = [self.objects objectAtIndex:i * 6];
        NSNumber *objectIndex = self.matches.index;
        //NSLog(@"objectIndex = %@", objectIndex);
        
        if ([objectIndex integerValue] > [highestDatabaseIndex integerValue]) {
            highestDatabaseIndex = objectIndex;
        }
    }
    
    //NSLog(@"Highest Database Index = %@", highestDatabaseIndex);
    
    return [highestDatabaseIndex integerValue];
}

-(BOOL)ColumnSeriesMatchAtIndex :(NSUInteger)workoutIndex {
    
    NSNumber *tempWorkoutIndex = [NSNumber numberWithInteger:workoutIndex + 1];
    
    // Get Data from the database.
    self.context = [[CoreDataHelper sharedHelper] context];
    
    // Fetch current session data.
    NSString *currentSessionString = [self.appDelegate getCurrentSession];
    
    self.entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:self.context];
    self.request = [[NSFetchRequest alloc] init];
    [self.request setEntity:self.entityDesc];
    self.pred = [NSPredicate predicateWithFormat:@"(session = %@) AND (routine = %@) AND (workout = %@) AND (exercise = %@) AND (index == %@)",
                 currentSessionString,
                 self.appDelegate.graphRoutine,
                 self.appDelegate.graphWorkout,
                 self.appDelegate.graphTitle,
                 tempWorkoutIndex];
    [self.request setPredicate:self.pred];
    
    NSError *error;
    self.objects = [self.context executeFetchRequest:self.request error:&error];
    
    if (self.objects.count == 0) {
        
        return FALSE;
    }
    
    else {
        
        return TRUE;
    }
}

-(void)matchAtIndex :(NSInteger)round :(NSUInteger)workoutIndex{
    
    NSNumber *roundConverted = [NSNumber numberWithInteger:round];
    
    NSNumber *tempWorkoutIndex = [NSNumber numberWithInteger:workoutIndex + 1];
    
    // @"B2: Chest - Russian Twist" is the only one that starts out in the second index of an array.
    NSString *tempString = [NSString stringWithFormat:@"%@ - %@", self.appDelegate.graphWorkout, self.appDelegate.graphTitle];
    if ([tempString isEqualToString:@"B2: Chest - Russian Twist"]) {
        
        roundConverted = [NSNumber numberWithInteger:round + 1];
    }
    
    // Get Data from the database.
    self.context = [[CoreDataHelper sharedHelper] context];
    
    // Fetch current session data.
    NSString *currentSessionString = [self.appDelegate getCurrentSession];
    
    self.entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:self.context];
    self.request = [[NSFetchRequest alloc] init];
    [self.request setEntity:self.entityDesc];
    self.pred = [NSPredicate predicateWithFormat:@"(session = %@) AND (routine = %@) AND (workout = %@) AND (exercise = %@) AND (round == %@) AND (index == %@)",
                 currentSessionString,
                 self.appDelegate.graphRoutine,
                 self.appDelegate.graphWorkout,
                 self.appDelegate.graphTitle,
                 roundConverted,
                 tempWorkoutIndex];
    [self.request setPredicate:self.pred];
    
    NSError *error;
    self.objects = [self.context executeFetchRequest:self.request error:&error];
}

-(NSString*)createXAxisString :(NSString*) initialString :(NSNumber*) spacesToAdd {
    //
    NSString *tempString = initialString;
    NSString *spacesString = @" ";
    
    for (int i = 0; i < [spacesToAdd intValue]; i++) {
        tempString = [tempString stringByAppendingString:spacesString];
    }
    return tempString;
}

-(NSString*)findXAxisTitle {
    
    NSArray *xAxisSecArray = @[@"Bulk Plyometrics - Vertical Jump",
                               @"Bulk Plyometrics - Burpee Pull-Up",
                               @"Bulk Plyometrics - Leg In and Outs",
                               @"Bulk Plyometrics - Plyo Push-Up Slaps",
                               @"Bulk Plyometrics - Leg Side to Sides",
                               @"Bulk Plyometrics - Chin-Up Crunch Squat Jump",
                               @"Bulk Plyometrics - Knee Driver",
                               @"Bulk Plyometrics - Sumo Tuck Jump",
                               @"Bulk Plyometrics - Lunge Lunge Squat",
                               @"Max Bulk Strength - Reverse Lunge - R",
                               @"Max Bulk Strength - Reverse Lunge - L",
                               @"Max Bulk Strength - Push-Up",
                               @"Max Bulk Strength - Squat",
                               @"Max Bulk Strength - Pull-Up",
                               @"Max Bulk Strength - Good Morning",
                               @"Max Bulk Strength - Chin-Up",
                               @"Max Bulk Strength - Stay Low Sumo",
                               @"Max Bulk Strength - Band Military Press",
                               @"Max Bulk Strength - Split Squat - R",
                               @"Max Bulk Strength - Split Squat - L",
                               @"Max Bulk Strength - Ledge Calf Raise",
                               @"Tone Cardio - Over The Top",
                               @"Tone Cardio - Pull-Up",
                               @"Tone Cardio - Dumbbell Swing",
                               @"Tone Cardio - Figure 8",
                               @"Tone Cardio - Burpee",
                               @"Tone Cardio - Sword Pull - L",
                               @"Tone Cardio - Sword Pull - R",
                               @"Tone Cardio - Forearm Plank Kick",
                               @"Tone Cardio - Side Step-Up Kick - R",
                               @"Tone Cardio - Side Step-Up Kick - L",
                               @"Tone Endurance - Bench Run Ups - L",
                               @"Tone Endurance - Bench Run Ups - R",
                               @"Tone Endurance - Negative Pull-Ups",
                               @"Tone Endurance - Step-Up Cross Over - R",
                               @"Tone Endurance - Step-Up Cross Over - L",
                               @"Tone Endurance - Decline Push-Up",
                               @"Tone Endurance - 1-Hand Row Leg Ext - R",
                               @"Tone Endurance - 1-Hand Row Leg Ext - L",
                               @"Tone Endurance - Incline Press",
                               @"Tone Endurance - Plank Hold Knee Drop",
                               @"Bulk Build Up - Squat",
                               @"Bulk Build Up - Front Back Lunge - R",
                               @"Bulk Build Up - Front Back Lunge - L",
                               @"Bulk Build Up - Step-Up - R",
                               @"Bulk Build Up - Step-Up - L",
                               @"Bulk Build Up - Pull-Up",
                               @"Bulk Build Up - Reverse Grip Row",
                               @"Bulk Build Up - Pullover",
                               @"Bulk Build Up - Reverse Fly",
                               @"Bulk Build Up - 1-Hand Push-Up - R",
                               @"Bulk Build Up - 1-Hand Push-Up - L",
                               @"Bulk Build Up - Bench Fly",
                               @"Bulk Build Up - Feet on Ball Push-Up",
                               @"Bulk Build Up - Incline Press",
                               @"Bulk Build Up - Ball Military Press",
                               @"Bulk Build Up - Lateral Raise",
                               @"Bulk Build Up - Upright Row",
                               @"Bulk Build Up - Anterior Raise",
                               @"Bulk Build Up - Standard Curl",
                               @"Bulk Build Up - Hammer Curl",
                               @"Bulk Build Up - Concentration Curl - L",
                               @"Bulk Build Up - Concentration Curl - R",
                               @"Bulk Build Up - Rotation Curl",
                               @"Bulk Build Up - Dips",
                               @"Bulk Build Up - Kickbacks - R",
                               @"Bulk Build Up - Kickbacks - L",
                               @"Bulk Build Up - Skull Crusher",
                               @"Bulk Build Up - Ball Plank Hold",
                               @"Bulk Build Up - Ball Mountain Climber",
                               @"Bulk Build Up - Windshield Wipers - R",
                               @"Bulk Build Up - Windshield Wipers - L"];
    
    NSString *tempString = [NSString stringWithFormat:@"%@ - %@", self.appDelegate.graphWorkout, self.appDelegate.graphTitle];
    
    for (int i = 0; i <xAxisSecArray.count; i++) {
        
        if ([tempString isEqualToString:xAxisSecArray[i]]) {
            
            return @"Sec";
        }
    }
    
    return @"Reps";
}

-(NSString*)findYAxisTitle {
    
    NSArray *yAxisRepsArray = @[@"Tone Balance - Up-Down",
                                @"Tone Balance - Split Squat Jump",
                                @"Total Body Bulk - Wide Pull-Up",
                                @"Bulk Conditioning - Clock Push-Up Crunch",
                                @"Bulk Conditioning - Plank Raise Tap Crunch",
                                @"Bulk Plyometrics - Vertical Jump",
                                @"Bulk Plyometrics - Burpee Pull-Up",
                                @"Bulk Plyometrics - Leg In and Outs",
                                @"Bulk Plyometrics - Plyo Push-Up Slaps",
                                @"Bulk Plyometrics - Leg Side to Sides",
                                @"Bulk Plyometrics - Chin-Up Crunch Squat Jump",
                                @"Bulk Plyometrics - Knee Driver",
                                @"Bulk Plyometrics - Sumo Tuck Jump",
                                @"Bulk Plyometrics - Lunge Lunge Squat",
                                @"Iso Speed Bulk - Push-Up",
                                @"Iso Speed Bulk - Chin-Ups",
                                @"Max Bulk Strength - Reverse Lunge - R",
                                @"Max Bulk Strength - Reverse Lunge - L",
                                @"Max Bulk Strength - Push-Up",
                                @"Max Bulk Strength - Squat",
                                @"Max Bulk Strength - Pull-Up",
                                @"Max Bulk Strength - Good Morning",
                                @"Max Bulk Strength - Chin-Up",
                                @"Max Bulk Strength - Stay Low Sumo",
                                @"Max Bulk Strength - Band Military Press",
                                @"Max Bulk Strength - Split Squat - R",
                                @"Max Bulk Strength - Split Squat - L",
                                @"Max Bulk Strength - Ledge Calf Raise",
                                @"Tone Cardio - Pull-Up",
                                @"Tone Cardio - Burpee",
                                @"Tone Cardio - Forearm Plank Kick",
                                @"Tone Endurance - Bench Run Ups - L",
                                @"Tone Endurance - Bench Run Ups - R",
                                @"Tone Endurance - Negative Pull-Ups",
                                @"Tone Endurance - Decline Push-Up",
                                @"Tone Endurance - Plank Hold Knee Drop",
                                @"Iso Strength Tone - Push-Up",
                                @"Iso Strength Tone - Pull-Up",
                                @"Bulk Build Up - Pull-Up",
                                @"Bulk Build Up - 1-Hand Push-Up - R",
                                @"Bulk Build Up - 1-Hand Push-Up - L",
                                @"Bulk Build Up - Feet on Ball Push-Up",
                                @"Bulk Build Up - Dips",
                                @"Bulk Build Up - Ball Plank Hold",
                                @"Bulk Build Up - Ball Mountain Climber",
                                @"Bulk Build Up - Windshield Wipers - R",
                                @"Bulk Build Up - Windshield Wipers - L",
                                @"Power Tone - Pull-Up",
                                @"Power Tone - Hanging Knee Curl",
                                @"Power Tone - Plyo Push-Up",
                                @"Power Tone - Half Spiderman",
                                @"Total Body Tone - Bench Dips"];
    
    NSString *tempString = [NSString stringWithFormat:@"%@ - %@", self.appDelegate.graphWorkout, self.appDelegate.graphTitle];
    
    for (int i = 0; i < yAxisRepsArray.count; i++) {
        
        if ([tempString isEqualToString:yAxisRepsArray[i]]) {
            
            return @"Reps";
        }
    }
    
    return @"Weight";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
