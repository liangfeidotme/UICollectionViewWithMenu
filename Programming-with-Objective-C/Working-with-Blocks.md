Blocks are Objective-C objects, which means they can be added to collections like `NSArray` or `NSDictionary`.

> closures | lambdas

Block Syntax
---

```objective-c
^{
    NSLog(@"This is a block");
}
```
**declare a variable to keep track of a block**

```objective-c
void (^simpleBlock)(void);

simpleBlock = ^{
    NSLog(@"This is a block");
}
```

```objective-c
void (^simpleBlock)(void) = ^{
    NSLog(@"This is a block");
};
```

```objective-c
double (^multiplyTwoValues)(double, double);

^ (double firstValue, double sencondValue) {
    return firstValue * secondValue;
}

^ double (double firstValue, double sencondValue) {
    return firstValue * sencondValue;
}
```

---

*Enclosing Scope*

*consider the `final` keyword in Java*

```objective-c
- (void)testMethod {
    int anInteger = 42;

    void (^testBlock)(void) = ^{
        NSLog(@"Integer is: %i", anInteger);
    };

    anInteger = 84;

    testBlock();
}
```

*The block cannot change the value of the original variable, or even the caputred value (it's captured as a `const` variable).*

---

Use __block Variables to Share Storage

```objective-c
__block int anInteger = 42;

void (^testBlock)(void) = ^{
    NSLog(@"Integer is: %i", anInteger);
};

anInteger = 84;

testBlock();
```

**Blocks are also used for callbacks**

```objective-c
- (IBAction)fetchRemoteInformation:(id)sender {
    [self showProgressIndicator];

    XYZWebTask *task = ...

    [task beginTaskWithCallbackBlock:^{
        [self hideProgressIndicator];
    }];
```

```objective-c
- (void)beginTaskWithCallbackBlock:(void (^)(void))callbackBlock;
```


