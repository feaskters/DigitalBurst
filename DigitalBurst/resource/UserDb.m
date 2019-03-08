//
//  UserDb.m
//  OrderCode
//
//  Created by iOS123 on 2019/2/14.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "UserDb.h"
#import "fmdb/FMDB.h"

@interface UserDb()

@property FMDatabase *db;

@end

@implementation UserDb

static UserDb *_instance;

//加载时就创建database
+ (void)load{
    _instance = [[UserDb alloc]init];
    //沙盒地址
    NSString *path  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //数据库地址
    NSString *dbPath = [path stringByAppendingString:@"/user.sqlite"];
    NSLog(@"%@",dbPath);
    //加载数据库
    _instance.db = [FMDatabase databaseWithPath:dbPath];
    //创建twoBlocks表
    if ([_instance.db open]) {
        //若表已经存在:success值为false
        BOOL success = [_instance.db executeUpdate:@"create table twoBlocks (id integer primary key autoincrement,name text not null default player,score integer default 0);"];
        if (success) {
            
        }
        
    }
    //创建threeBlocks表
    if ([_instance.db open]) {
        //若表已经存在:success值为false
        BOOL success = [_instance.db executeUpdate:@"create table threeBlocks (id integer primary key autoincrement,name text not null default player,score integer default 0);"];
        //若添加表成功，加入电脑数据
        if (success) {
           
        }
    }
}

//返回userdb
+(instancetype)sharedUserDb{
    return _instance;
}

//不允许alloc
+(instancetype)alloc{
    if (_instance) {
        NSException *exc = [NSException exceptionWithName:@"NSInternalInconsistencyException" reason:@"There can only be one UserDb instance." userInfo:nil];
        //抛出异常
        [exc raise];
    }
    return [super alloc];
}

#pragma mark - competition

/*插入twoBlocks数据
 param:name->name score->score
 return:true->success false->fail
 */
-(BOOL)inserttwoBlocksWithName:(NSString *)name score:(NSString *)score{
    BOOL state =  [_instance.db executeUpdate:@"insert into twoBlocks(name ,score) values(?,?);",name,score];
    return state;
}

/*查询twoBlocks数据
 return
 */
-(NSArray *)SelecttwoBlocks{
    NSMutableArray *mArray = [[NSMutableArray alloc]init];
    FMResultSet *set = [_instance.db executeQuery:@"select * from twoBlocks order by score desc limit 50"];
    while ([set next]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[set stringForColumnIndex:1], @"name",[[NSNumber alloc] initWithInt: [set intForColumnIndex:2]],@"score", nil];
        [mArray addObject:dic];
    }
    return mArray;
}

#pragma mark - puzzle

/*插入threeBlocks数据
 param:name->name score->score
 return:true->success false->fail
 */
-(BOOL)insertthreeBlocksWithName:(NSString *)name score:(NSString *)score{
    BOOL state =  [_instance.db executeUpdate:@"insert into threeBlocks(name ,score) values(?,?);",name,score];
    return state;
}

/*查询threeBlocks数据
 return
 */
-(NSArray *)SelectthreeBlocks{
    NSMutableArray *mArray = [[NSMutableArray alloc]init];
    FMResultSet *set = [_instance.db executeQuery:@"select * from threeBlocks order by score desc limit 50"];
    while ([set next]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[set stringForColumnIndex:1], @"name",[[NSNumber alloc] initWithInt: [set intForColumnIndex:2]],@"score", nil];
        [mArray addObject:dic];
    }
    return mArray;
}
@end
