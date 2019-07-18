//
//  HMCoreDataStackManager.h
//  CoreDataLearn
//
//  Created by XianCheng Wang on 2018/7/2.
//  Copyright © 2018年 XianCheng Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define KXBCoreManagerInstance [HMCoreDataStackManager shareInstance]

@interface HMCoreDataStackManager : NSObject

///单例
+(HMCoreDataStackManager*)shareInstance;

///管理对象上下文
@property(strong,nonatomic)NSManagedObjectContext *managerContenxt;

///模型对象
@property(strong,nonatomic)NSManagedObjectModel *managerModel;

///存储调度器
@property(strong,nonatomic)NSPersistentStoreCoordinator *maagerDinator;

//保存数据的方法
-(void)save;

@end
