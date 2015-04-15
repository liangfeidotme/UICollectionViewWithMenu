//
//  ToDoItem.h
//  ToDoList
//
//  Created by liangfei on 4/15/15.
//  Copyright (c) 2015 feelang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject

@property NSString *itemName;
@property BOOL completed;
@property (readonly) NSDate *creationDate;

@end
