Protocols Define Messaging Contracts
---

To specify that one protocol conforms to another, you provide the name of the other protocol in angle brackets, like this:

```objective-c
@protocol MyProtocol <NSObject>

//...

@end
```

Conforming to Protocols
---

```objective-c
@interface MyClass : NSObject <MyProtocol>

// ...

@end
```

There's no need to redeclare the protocol methods in the class interface - the adoption of the protocol is sufficient.

**Adopt multiple protocols**

```objective-c
@interface MyClass : NSObject <MyProtocol, AnotherProtocol, YetAnotherProtocol>

// ...

@end
```

Protocols Are Used for Anonymity
---

