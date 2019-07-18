//
//  Student+CoreDataProperties.h
//  CoreDataLearn
//
//  Created by XianCheng Wang on 2018/7/2.
//  Copyright © 2018年 XianCheng Wang. All rights reserved.
//
//

#import "Student+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest;
@property (nullable, nonatomic, copy) NSString *userId;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int16_t age;
@property (nullable, nonatomic, copy) NSString *gender;
@property (nonatomic) int16_t height;
@property (nonatomic) int16_t number;

@end

NS_ASSUME_NONNULL_END
