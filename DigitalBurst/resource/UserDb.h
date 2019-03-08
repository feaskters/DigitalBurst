//
//  UserDb.h
//  OrderCode
//
//  Created by iOS123 on 2019/2/14.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserDb : NSObject

+(instancetype)sharedUserDb;
-(NSArray *)SelecttwoBlocks;
-(BOOL)inserttwoBlocksWithName:(NSString *)name score:(NSString *)score;

-(NSArray *)SelectthreeBlocks;
-(BOOL)insertthreeBlocksWithName:(NSString *)name score:(NSString *)score;

@end

NS_ASSUME_NONNULL_END
