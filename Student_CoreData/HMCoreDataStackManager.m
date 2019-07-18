//
//  HMCoreDataStackManager.m
//  CoreDataLearn
//
//  Created by XianCheng Wang on 2018/7/2.
//  Copyright © 2018年 XianCheng Wang. All rights reserved.
//

#import "HMCoreDataStackManager.h"

@implementation HMCoreDataStackManager

///单例的实现
+(HMCoreDataStackManager*)shareInstance
{
    static HMCoreDataStackManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HMCoreDataStackManager alloc]init];
    });
    
    return instance;
}

-(NSURL*)getDocumentUrlPath
{
    ///获取文件位置
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]
    ;
}

//懒加载managerContenxt
-(NSManagedObjectContext *)managerContenxt
{
    if (_managerContenxt != nil) {
        
        return _managerContenxt;
    }
    
    _managerContenxt = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    ///设置存储调度器
    [_managerContenxt setPersistentStoreCoordinator:self.maagerDinator];
    
    return _managerContenxt;
}

///懒加载模型对象
-(NSManagedObjectModel *)managerModel
{
    
    if (_managerModel != nil) {
        
        return _managerModel;
    }
    
    _managerModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    return _managerModel;
}

-(NSPersistentStoreCoordinator *)maagerDinator
{
    if (_maagerDinator != nil) {
        
        return _maagerDinator;
    }
    
    _maagerDinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:self.managerModel];
    
    //添加存储器
    /**
     * type:一般使用数据库存储方式NSSQLiteStoreType
     * configuration:配置信息 一般无需配置
     * URL:要保存的文件路径
     * options:参数信息 一般无需设置
     */
    
    //拼接url路径
    NSURL *url = [[self getDocumentUrlPath]URLByAppendingPathComponent:@"sqlit.db" isDirectory:YES];
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             
                             [NSNumber numberWithBool:YES],
                             
                             NSMigratePersistentStoresAutomaticallyOption,
                             
                             [NSNumber numberWithBool:YES],
                             
                             NSInferMappingModelAutomaticallyOption, nil];
    
        [_maagerDinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:options error:nil];
    //    添加 *optionsDictionary，原来options:nil  改成options:optionsDictionary
    
    return _maagerDinator;
}

-(void)save
{  ///保存数据
    [self.managerContenxt save:nil];
}

@end
