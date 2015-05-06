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

##### The Designated Initializer is the Primary Initialization Method

**designated initializer** - often the method that offers the most options for initialization. You should also typically override `init` to call your designated initializer with suitable default values.

```
- (id)initWithFirstName:(NSString *)aFirstName lastName:(NSString *)aLastName dateOfBirth:(NSDate *)aDOB;
```

```
- (id)initWithFirstName:(NSString *)aFirstName lastName:(NSString *)aLastName {
    return [self initWithFirstName:aFirstName lastName:aLastName dateOfBirth:nil ];
}
```

```
- (id)init {
    return [self initWithFirstName:@"John" lastName:@"Doe" dateOfBirth:nil];
}
```

You should call the superclass's designated initializer (int place of `[super init];`) before doing any of your own initialization.

#### You can implement Custom Accessor Methods

> Properties don't always have to be backed by their own instance variables.

```
@property (readonly) NSString *fullName;
```

```
- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}
```

```
- (XYZObject *)someImportantObject {
    if (!_someImportantObject) {
        _someImportantObject = [[XYZObject alloc] init];
    }

    return _someImportantObject;
}
```

If you implement both a getter and a setter for a `readwrite` property, or a getter for a `readonly` property, the compiler will assume that you are taking control over the property implementation and won't synthesize an instance variable automatically.
If you still need an instance variable, you'll need to request that one be synthesized.

```
@synthesized property = _property;
```

#### Properties Are Atomic by Default

```
@interface XYZObject : NSObject
@property NSObject *implicitAtomicObject;           // atomic by default
@property (atomic) NSObject *explicitAtomicObject;  // explicitly marked atomic
```

<pre>
Because the internal implementation and synchronization of atomic accessor methods is private, it's not possible to combine a synthesized accessor with an accessor method that you implement yourself. You'll get a compiler warning if you try, for example, to provide a custom setter for an `atomic, readwrite` property but leave the compiler to synthesize the getter.
</pre>

It's fine to combine a synthesized setter when using `nonatomic` property.

```
@interface XYZObject : NSObject

@property (nonatomic) NSObject *nonatomicObject;

@end
```

```
@implementation XYZObject

- (NSObject *)nonatomicObject {
    return _nonatomicObject;
}

// setter will be synthesized automicallty

@end
```

**Property atomicity is not synonymous with an object's *thread safty***

#### Manage the Object Graph through Ownership and Responsibility

##### Avoid Strong Reference Cycles

In order for a generic view class to be useful in multiple situations, it `delegates` some decisions to external objects.

<pre>strong reference cycle</pre>

##### Use Strong and Weak Declarations to Manage Ownership

```
@property (weak) id delegate
```

If you don't want a variable to maintain a strong reference, you can declare it as `__weak`, like this:

```
NSObject * __weak weakVariable;
```

#### Copy Properties Maintain Their Own Copies

```
@interface XYZBadgeView : NSView

@property (copy) NSString *firstName;
@property (copy) NSString *lastName;

@end
```

`copy` means a strong reference.

Any object that you wish to set for a `copy` property must support `NSCopying`.

``` 
- (id)initWithSomeOriginalString:(NSString *)aString {
    self = [super init];
    if (self) {
        _instanceVariableForCopyProperty = [aString copy];
    }
}
```
