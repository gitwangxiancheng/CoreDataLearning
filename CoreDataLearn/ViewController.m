//
//  ViewController.m
//  CoreDataLearn
//
//  Created by XianCheng Wang on 2018/7/2.
//  Copyright © 2018年 XianCheng Wang. All rights reserved.
//

#import "ViewController.h"
#import "Student+CoreDataClass.h"
#import "HMCoreDataStackManager.h"
#import "StudentTableViewCell.h"
#import "JXSegment.h"


#define getCurentTime [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]]
#define SafeAreaTopHeight ([[UIScreen mainScreen] bounds].size.height == 812.0 ? 88 : 64)

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,JXSegmentDelegate>
@property (nonatomic,retain)JXSegment *segment;
@property (nonatomic,retain)NSMutableArray *dataMuArr;
@property (nonatomic,retain)UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    // 设置导航默认标题的颜色及字体大小
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"coreData简单实用";
    [self segment];
    // 查询数据
    [self queryStudentData];
    


}

// 增加数据
-(void)addStudentData{
    // 1、查询数据
    Student *stu = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:KXBCoreManagerInstance.managerContenxt];
    stu.userId = [NSString stringWithFormat:@"%u%@",arc4random()%1000,getCurentTime];
    stu.age = arc4random()%20;
    stu.gender = arc4random()%2 == 0 ?  @"美女" : @"帅哥" ;
    if ([stu.gender isEqualToString:@"美女"]) {
        stu.name = [NSString stringWithFormat:@"李%u美",arc4random()%100];
    }else{
        stu.name = [NSString stringWithFormat:@"张%u哥",arc4random()%100];
    }
    stu.height = arc4random()%180;
    stu.number = arc4random()%100;
    [KXBCoreManagerInstance save];
    // 2、查询数据
    [self queryStudentData];
}

// 删除数据
-(void)delectStudentData:(NSString *)userId{
    // 1、创建一个查询请求
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Student"];
    // 2、创建查询谓词
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId = %@",userId];
     //  3、给查询结果设置谓词
    request.predicate = predicate;
    // 4、查询数据
    NSArray<Student *> *dataArr = [KXBCoreManagerInstance.managerContenxt executeFetchRequest:request error:nil];
    if (dataArr.count != 0) {
    // 5、删除数据
     [KXBCoreManagerInstance.managerContenxt deleteObject:dataArr.firstObject];
    // 6、同步到数据库
     [KXBCoreManagerInstance save];
    }
    // 7、查询数据
    [self queryStudentData];
}

// 修改数据
-(void)replaceStudentData{
    // 1、创建一个查询请求
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Student"];
    // 2、创建查询谓词
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@",@"张三"];
    // 3、给查询结果设置谓词
    request.predicate = predicate;
    // 4、查询数据
    NSArray<Student *> *dataArr = [KXBCoreManagerInstance.managerContenxt executeFetchRequest:request error:nil];
    // 5、修改数据
    dataArr.firstObject.name = @"李四";
    dataArr.firstObject.age = 9999;
    // 6、同步到数据库
    [KXBCoreManagerInstance save];
    // 7、查询数据
    [self queryStudentData];
}

// 查询数据
-(void)queryStudentData{
    // 1、创建一个查询请求
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Student"];
//    // 2、创建查询谓词
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@",@"张三"];
//    // 3、给查询结果设置谓词
//    request.predicate = predicate;
    // 4、查询数据
    NSArray<Student *> *dataArr = [KXBCoreManagerInstance.managerContenxt executeFetchRequest:request error:nil];
    // 5、刷新app
    [self.dataMuArr removeAllObjects];
    for (Student *stu in dataArr) {
        NSLog(@"stu.name == %@,stu.age == %hd",stu.name,stu.age);
        [self.dataMuArr addObject:stu];
    }
    [self.tableView reloadData];
}

-(void)sortStudentData{
    // 1、创建排序请求
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    // 2、实例化排序对象
    NSSortDescriptor *ageSort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
    NSSortDescriptor *numberSort = [NSSortDescriptor sortDescriptorWithKey:@"number" ascending:YES];
    request.sortDescriptors = @[ageSort,numberSort];
    // 发送请求
    NSError *error = nil;
    
    NSArray *resArry = [KXBCoreManagerInstance.managerContenxt executeFetchRequest:request error:&error];
    if (error == nil) {
        NSLog(@"按照age和number排序");
    }else{
        NSLog(@"排序失败");
    }
    // 移除数据
    [self.dataMuArr removeAllObjects];
    for (Student *stu in resArry) {
        NSLog(@"stu.name == %@,stu.age == %hd",stu.name,stu.age);
        [self.dataMuArr addObject:stu];
    }
    [self.tableView reloadData];
    
}



- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataMuArr.count;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Student *stu = self.dataMuArr[indexPath.row];
    StudentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"stu" forIndexPath:indexPath];
    NSString *imageName = [stu.gender isEqualToString:@"美女"] ? @"0.jpeg":@"1.jpg";
    cell.iconImageView.image = [UIImage imageNamed:imageName];;
    cell.nameLabel.text = [NSString stringWithFormat:@"姓名: %@",stu.name];
    cell.ageLabel.text = [NSString stringWithFormat:@"年龄: %hd",stu.age];
    cell.genderLabel.text = [NSString stringWithFormat:@"性别: %@",stu.gender];
    cell.numberLabel.text = [NSString stringWithFormat:@"分数: %hd",stu.number];
    return cell;
}

-(NSMutableArray *)dataMuArr{
    if (!_dataMuArr) {
        _dataMuArr = [[NSMutableArray alloc] init];
    }return _dataMuArr;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //消除cell选择痕迹
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

#pragma mark ---------------------批量下单--------------------------
// E快送
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0,SafeAreaTopHeight + 50,[[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 50 - SafeAreaTopHeight)];
        [_tableView registerClass:[StudentTableViewCell class] forCellReuseIdentifier:@"stu"];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame: CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }return _tableView;
}
-(JXSegment *)segment{
    if (!_segment) {
        _segment = [[JXSegment alloc] initWithFrame:CGRectMake(0,SafeAreaTopHeight,[[UIScreen mainScreen] bounds].size.width, 50)];
        [_segment updateChannels:@[@"插入",@"删除",@"修改",@"查询",@"排序"]];
        _segment.delegate = self;
        [self.view addSubview:_segment];
    }return _segment;
}

#pragma mark - JXSegmentDelegate
- (void)JXSegment:(JXSegment*)segment didSelectIndex:(NSInteger)index{
    switch (index) {
        case 0:{
            // 增加数据
            [self addStudentData];

            break;
        }
        case 1:{
            // 删除数据
            [self delectStudentData:nil];

            
            break;
        }
        case 2:{
            // 修改数据
            //  [self replaceStudentData];

            
            break;
        }
        case 3:{
            // 查询数据
            [self queryStudentData];
            break;
        }
        case 4:{
            // 排序
            [self sortStudentData];
            break;
        }
        default:
            break;
    }
}


//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
//设置进入编辑状态时，Cell不会缩进
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}
//点击删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //在这里实现删除操作
    Student *stu = self.dataMuArr[indexPath.row];
    NSLog(@"%@%@%@",stu.name,stu.userId,stu.gender);
    [self delectStudentData:stu.userId];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
