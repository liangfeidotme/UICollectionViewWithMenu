A class `interface` defines the ways in which others are expected to interact with an object to help it accomplish those tasks.

Objective-C allows you to add own methods to existing classes through categories and class extensions.

Categories Add Methods to Existing Classes
---

```
@interface ClassName (CategoryName)

@end
```

```
#import "XYZPerson.h"

@interface XYZPerson (XYZPersonNameDisplayAdditions)

- (NSString *)lastNameFirstNameString;

@end
```

You might declare the category in a header file called `XYZPerson+XYZPersonNameDisplayAdditions.h`.

*XYZPerson+XYZPersonNameDisplayAdditions.m*

```
#import "XYZPerson+XYZPersonNameDisplayAdditions.h"

@implementaion XYZPerson (XYZPersonNameDisplayAdditions)

- (NSString *)lastNameFirstNameString {
    return [NSString stringWithFormat:@"%@, %@", self.lastName, self.firstName];
}

@end
```
```
#import "XYZPerson+XYZPersonNameDisplayAdditions.h"
@implementation SomeObject
- (void)someMethod {
    XYZPerson *person = [[XYZPerson alloc] initWithFirstName:@"John"
                                                    lastName:@"Doe"];
    XYZShoutingPerson *shoutingPerson = 
                        [[XYZShoutingPerson alloc] initWithFirstName:@"Monica"
                                                            lastName:@"Robinson"];
    NSLog(@"The two people are %@ and %@",
        [person lastNameFirstNameString], [shoutingPerson lastNameFirstNameString]);
@end
```

The only way to add a traditional property - backed by a new instance variable - to an exsiting class is to use a class extension;

**It's best practice to add a prefix to method names in categories on framework classes**

```
@interface NSSortDescriptor (XYZAdditions)

+ (id)xyz_sortDescriptorWithKey:(NSString *)key ascending:(BOOL)ascending;

@end
```

Class Extensions Extend the Internal Implementation
---

A class extension can only be added to a class for which you have the source code at compile time (the class is compiled at the same time as the class extendsion).

---

```
@interface ClassName ()

@end
```

Because no name is given in the parentheses, class extentions are often referred to as *anonymous categories*.

**Use Class Extensions to Hide Private Information**

*The primary interface for a class is used to define the way that other classes are expected to interact with it. In other words, it's the public interface to the class*

```
@interface XYZPerson : NSObject

@property (readonly) NSString *uniqueIdentifier;
- (void)assignUniqueIdentifier;
@end
```

```objective-c
@interface XYZPerson()
@property (readwrite) NSString *uniqueIdentifier;
@end

@implementation XYZPerson
// ...
@end
```

Consider Other Alternatives for Class Customization
---

Any decisions that might limit reusability can be delegated to another object, which is left to make those decisions at runtime.

*associative reference*


