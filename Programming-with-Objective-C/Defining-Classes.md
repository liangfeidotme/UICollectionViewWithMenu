> The Objects package data with related behavior.

Classes Are Blueprints for Objects
---

The *interface* in Objective-C is used as its literal meaning, not like the `interface` keyword in Java or something else.

Mutibility Determines Whether a Represented Value Can Be Changed.
---

* `NSString` vs `NSMutableString`
* `NSObject` is the root class of all classes.
* `NSObject` -> `UIResponder` -> `UIView` -> `UIControl` -> `UIButton`
    * behaved like a button
    * display itself on screen
    * respond to user input
    * communicate with any other basic Cocoa Touch object.

The interface For a Class Defines Expected Interactions
---

An object should be designed to hide the details of its internal implementation.

Use *header file* to describe the *interface* for a class.

---

**Properties Control Access to an Objects Value**

```
@interface Person : NSObject

    @property NSString *firstName;
    @property NSString *lastName;
    @property int yearOfBirth;

@end
```

---

**Property Attributes Indicate Data Accessibility and Storage Considerations**

```
@interface Person : NSObject

    @property (readonly) NSString *firstName;
    @property (readonly) NSString *lastName;

@end
```

---

**Method Declarations Indicate the Messages an Object Can Receive**

*model object* -> an object designed primarily to encapsulate data.

```
- (void)someMethod;
```

*The minus sign (-) at the front of the method name indicates that it is an instance method*

---

**Methods**

```
- (void)someMethodWithValue:(SomeType)value;
- (void)someMethodWithFirstValue:(SomeType)value1 secondValue:(AnotherType)value2;
```

**NOT** *named argments*, the order of the paramters in a method call must match the method declaration, so the name of the method is:

```
someMethodWithFirstValue:secondValue:;
```

---

**The implementation of a Class Provides Its Internal Behavior.**

```
#import "XYZPerson.h"

@implementation XYZPerson

@end
```

*The preprocessor directive, `#import`, is similar to the C `#include` directive, but makes sure that a file only included once during compilation.*
**NOT**: `#import` does not use a terminating semi-colon.

---

**Implementing Methods**

*XYZPerson.h*

```
@interface XYZPerson : NSObject

- (void)sayHello;

@end
```

*XYZPerson.m*

```
#import "XYZPerson.h"

@implementation 

- (void)sayHello {
    NSLog(@"Hello, World!");
}

@end
```

---

**class factory methods**

```
+ (id)string;
+ (id)stringWithString:(NSString *)aString;
+ (id)stringWithFormat:(NSString *)format, ...;
+ (id)stringWithContentsOfFile:(NSString *)path encoding:(NSStringEncoding *)enc error:(NSError **)error;
+ (id)stringWithCString:(const char *)cString encoding:(NSStringEncoding *)enc;
```

---



