//
//  Student+CoreDataProperties.m
//  CoreDataLearn
//
//  Created by XianCheng Wang on 2018/7/2.
//  Copyright © 2018年 XianCheng Wang. All rights reserved.
//
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Student"];
}
@dynamic userId;
@dynamic name;
@dynamic age;
@dynamic gender;
@dynamic height;
@dynamic number;

@end
