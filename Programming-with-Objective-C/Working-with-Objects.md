### Working with Objects

#### Objects Send and Receive Messages

```
[someObject doSomething];
```

*XYZPerson.h*

```
@interface XYZPerson : NSObject

- (void)sayHello;

@end
```

*XYZPerson.m*

```
@implementation XYZPerson

- (void)sayHello {
    NSLog(@"Hello, world!");
}

@end
```

`%@` used to denote an object. At runtime, this specifier will be sustituted with the result of calling either the `descriptionWithLocale:` method (if it exists) or the `description` method on the provided object.

```
NSString *testString = @"Hello, World!";
NSString *revisedString = [testString uppercaseString];
```

```
@implementation XYZPerson
- (void)sayHello {
    [self saySomething:@"Hello, world!"];
}

- (void)saySomething:(NSString *)greeting {
    NSLog(@"%@", greeting);
}
@end
```

---

```
+(id)alloc;
```

`id` means "some kind of object", it's a pointer to an object, like (`NSObject *`).

<pre>
The `alloc` method has one other important task, which is to clear out the memory allocated for the object's properties by setting them to zero. This avoids the usual problem of memory containing garbage from whatever was stored before, but is not enough to initialize an object completely.
</pre>

```
NSNumber *magicNumber = [[NSNumber alloc] initWithInt:42];
// is effectively the same as
NSNumber *magicNumber = [NSNumber numberWithInt:42];
```

```
XYZObject *object = [XYZObject new];
// is effectively the same as
XYZObject *object = [[XYZObject alloc] init];
```

#### Literals Offer a Concise Object-Creating Syntax

```
NSString *someString = @"Hello, World!";
```

```
NSString *someString = [NSString stringWithCString:"Hello, World!"
                                          encoding:NSUTF8StringEncoding];
```

```
NSNumber *myBOOL = @YES;
NSNumber *myFloat = @3.14f;
NSNumber *myInt = @42;
NSNumber *myLong = @42L;
```

```
NSNumber *myInt = @(84 / 2);
```

> Because the class of an object is determined at runtime, it makes no difference what type you assign a variable when creating or working with an instance.

#### Determing Equality of Objects

```
if (someInteger == 42) {
    // someInteger has the value 42
}
```

```
if (firstPerson == secondPerson) {
    // firstPerson is the same object as secondPerson
}
```

```
if ([firstPerson isEqual:secondPerson]) {
    // firstPerson is identical to secondPerson
}
```

```
if ([someDate compare:anotherDate] == NSOrderedAscending) {
    // someDate is earlier 
}
```

A `nil` value is the safest way to initialize an object pointer if you don't have another value to use, because it's perfectly acceptable in Objective-C to send a message to `nil`. If you do send a message to `nil`, obviously nothing happens.

Using `self` in a class factory method means that you're referring to the class itself.


