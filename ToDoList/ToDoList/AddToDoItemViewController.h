//
//  AddToDoItemViewController.h
//  ToDoList
//
//  Created by liangfei on 4/15/15.
//  Copyright (c) 2015 feelang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoItem.h"

@interface AddToDoItemViewController : UIViewController

@property (nonatomic, strong)ToDoItem *toDoItem;

- (void)textField:(NSString *)text;


@end
