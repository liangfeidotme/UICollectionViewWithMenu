//
//  ToDoItem.h
//  ToDoList
//
//  Created by liangfei on 4/15/15.
//  Copyright (c) 2015 feelang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, assign)BOOL completed;
@property (readonly) NSDate *creationDate;

@end
