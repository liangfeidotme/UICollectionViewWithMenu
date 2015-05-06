Basic C Primitive Types Are Available in Objective-C
---

```
int someInteger = 42;
float someFloatingPointNumber = 3.1415;
double someDoublePresicionFloatingPointNumber = 6.0221499e23;
```

**use a scalar type for an Objective-C property**

```objective-c
@interface XYZCalculator : NSObject
@property double currentValue;
@end
```

```objective-c
@implementation XYZCaculator
- (void)increment {
    self.currentValue++;
}

- (void)decrement {
    self.currentValue--;
}

- (void)multiplyBy:(double)factor {
    self.currentValue *= factor;
}
@end
```
*Dot syntax is purely a syntactic wrapper around accessor method calls*

---

**Objective-C defines Additional Primitive Types**

---

**C Structure Can Hold Primitive Values**

```
NSString *mainString = @"This is a long string";
NSRange substringRange = [mainString rangeOfString:@"long"];
```

Objects Can Represent Primitive Values
---

*standard allocation and initialization*

```objective-c
NSString *firstString = [[NSString alloc] initWithCString:"Hello World!"
                                                 encoding:NSUTF8StringEncoding];
```

*class factory methods*

```objective-c
NSString *secondString = [NSString stringWithCString:@"Hello World!"
                                            encoding:NSUTF8StringEncoding];
```

*literal*

```objective-c
NSString *thirdString = @"Hello World!"
```

```objective-c
NSString *name = @"John";
name = [name stringByAppendingString:@"ny"];
```

```objective-c
NSMutableString *name = [NSMutableString stringWithString:@"John"];
[name appendString:@"ny"];
```

---

**Format Strings Are Used to Build String from Other Objects or Values**

```objective-c
int magicNumber = 123;
NSString *magicString = [NSString stringWithFormat:@"The mac number is %i", magicNumber];
```

Numbers Are Represented by Instances of the NSNumber class
---

Once you've created an `NSNumber` instance it's possible to request the scalar value

```
int scalarMagic = [magicNumber intValue];
```

Represent Other Values Using Instances of the NSValue Class
---

The `NSNumber` is a subclass `NSValue`.

```objective-c
NSString *mainString = @"This is a long string";
NSRange substringRange = [mainString rangeOfString:@"long"];
NSValue *rangeValue = [NSValue valueWithRange:substringRange];
```

```
typedef struct {
    int i;
    float f;
} MyIntegerFloatStruct;
```

```
struct MyIntegerFloatStruct aStruct;
aStruct.i = 42;
aStruct.f = 3.14;

NSValue *structValue = [NSValue value:&aStruct
                         withObjCType:@encode(MyIntegerFloatStruct)];
```

Arrays
---

**Literal Syntax**

```objective-c
NSArray *someArray = @[firstObject, secondObject, thirdObject];
```

```objective-c
NSArray *unsortedStrings = @[@"gammaString", @"alphaString", @"betaString"];
NSArray *sortedStrings = 
            [unsortedStrings sortedArrayUsingSelector:@selector(compare:)];
```

```
[string isKindOfClass:[NSMutableString class]]
```

Represent nil with NSNull
---

```objective-c
NSArray *array = @[ @"string", @42, [NSNull null] ];
```

`NSNull` is a singleton class, which means that the `null` method will always return the same instance.

```objective-c
for (id object in array) {
    if (object == [NSArray null]) {
    }
}
```

Use Collections to Persist Your Object Graph
---

```objective-c
NSURL *fileURL = ...
NSArray *array = @[@"first", @"sencond", @"third"];

BOOL success = [array writeToURL:fileURL atomically:YES];

if (!success) {
    // an error occured...
}
```
