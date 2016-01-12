//
//  WorkoutCompleteDate+CoreDataProperties.h
//  60 DWT HC
//
//  Created by Grant, Jared on 1/7/16.
//  Copyright © 2016 Grant, Luana. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "WorkoutCompleteDate.h"

NS_ASSUME_NONNULL_BEGIN

@interface WorkoutCompleteDate (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *workoutCompleted;
@property (nullable, nonatomic, retain) NSString *workout;
@property (nullable, nonatomic, retain) NSString *session;
@property (nullable, nonatomic, retain) NSNumber *index;
@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSString *routine;

@end

NS_ASSUME_NONNULL_END
