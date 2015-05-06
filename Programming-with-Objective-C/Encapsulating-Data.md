## Encapsulating Data

### Properties Encapsulate an Object's Values

Some objects are designed to model one or more values.

#### Declare Public Properties for Exposed Data

```
@interface XYZPerson : NSObject

@property NSString *firstName;
@property NSString *lastName;

@end
```

#### Use Accessor Methods to Get or Set Property Values

**synthesized methods**

```
NSString *firstName = [somePerson firstName];
[somePerson setFirstName:@"Jonny"];
```

*By default, these accessor methods are synthesized automatically for you by the compiler, so you don't need to do anything other than declare the property using `@property` in the class interface.*

**readonly** <=> **readwrite (default)**

```
@property (readonly) NSString *fullName;
```

*in the case below, the compiler will synthesize only an `isFinished` method, but not a `setFinished:` method.*

```
@property (getter=isFinished) BOOL finished;
```

```
@property (readonly, getter=isFinished) BOOL finished;
```

#### Dot Syntax Is a Concise Alternative to Accessor Method Calls

**Dot syntax**

```
NSString *firstName = somePerson.firstName; // [somePerson firstName]
somePerson.firstName = @"Johnny"; // [somePerson setFirstName:@"Johnny"]
```

##### Most Properties Are Backed by Instance Variables

Unless you specify otherwise, the synthesized instance variable has the same name as the property, but with an underscore prefix.

For a property called `firstName`, for example, the synthesized instance variables will be called `_firstName`.

```
- (void)someMethod {
    NSString *myString = @"An interesting string";

    _someString = myString;
}
```

**In general, you should use accessor methods or dot syntax for property access even if you're accessing an object's properties from within its own implementation, in which case you should use `self:`**

```
- (void)someMethod {
    NSString *myString = @"An interesting string";

    self.someString = myString;

    // or

    [self setSomeString:myString];
}
```

##### You can Customize Synthesized Instance Variable Names

```
@implementation YouClass

@synthesize propertyName = instanceVariableName;

@end
```

**The `firstName` property will be backed by an instance variable called `ivar_firstName`**

```
@synthesize firstName = ivar_firstName;
```

**The instance variable will bear the same name as the property.**

```
@synthesized firstName;
```

##### You Can Define Instance Variables without Properties

```
@interface SomeClass : NSObject

    NSString *_myNonPropertyInstanceVariable;

@end
```

```
@implementation SomeClass {

    NSString *_anotherCustomInstanceVariable;

}
@end
```

#### Access Instance Variables Directly from Initializer Methods

You should always access the instance variable directly from within an initialization method.

```
- (void)init {
    self = [super init];

    if (self) {
        // initialize instance variable here
    }

    return self;
}
```
