#runtime

//1.[objc msg];  实际上是通过左边代码实现消息转发 
```objective-c
((void (*)(id,SEL))objc_msgSend)((id)objc,@selector(msg));
```
</br>
</br>
</br>

//2.如果有实现下面的方法，会先进入下面的方法。
```objective-c
- (void)msg {
//当进入括号时，不会先执行下面的代码，会先跳到下面resolveInstanceMethod的方法。但有声明msg方法。resolveInstanceMethod就检测不了msg这个方法。
NSLog(@"%@ msg", self);
}
```
</br>
</br>
</br>


//如果无，可以通过下面的方法接收到分发的sel(method)
```objective-c
+ (BOOL)resolveInstanceMethod:(SEL)sel {
// 我们可以不声明上面msg方法，我们可以动态添加msg方法
if ([NSStringFromSelector(sel) isEqualToString:@"msg"]) {
//这个方法可以动态添加一个IMP.
class_addMethod(self, sel, (IMP)msg, "v@:");
return YES;
}
return [super resolveInstanceMethod:sel];
}
```



//这个就上面提到的IMP实现方法。
```objective-c
void msg(id self, SEL cmd) {
NSLog(@"%@ msg", self);
}
```

其实，上面msg的方法，实际上也跟IMP挂钩的，实现msg方法实际上，通过isa查询class里的method_list,得出的SEL找出对应的IMP函数指针去实现方法。



//3.当第二步没有声明msg方法，也没有动态添加IMP。那就会进行下面的操作。你可以转发给一个有实现msg方法的类，让它实现msg的方法，若不想就return nil;
```objective-c
- (id)forwardingTargetForSelector:(SEL)aSelector {
if (aSelector == @selector(obj)) {
OtherObjc *otherObj = [OtherObjc new];
return otherObj;
}
return nil;
}
```
</br>
</br>
</br>

//4.methodSignatureForSelector再一次检测msg这个函数，然后返回NSMethodSignature，返回的NSMethodSignature会触发forwardInvocation的方法。如果methodSignatureForSelector返回nil或没有实现forwardInvocation都会跳到doesNotRecognizeSelector返回不能执行msg函数
//下面三行代码系NSMethodSignature与NSInvocation的关系
//NSMethodSignature *signature = nil;
//signature = [self methodSignatureForSelector:getSel];
//NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
```objective-c
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
if ([NSStringFromSelector(aSelector) isEqualToString:@"msg"]) {
//这里可以更改签证。
return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}
return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
// 我们还可以改变方法选择器
[anInvocation setSelector:@selector(otherMsg)];
// 改变方法选择器后，还需要指定是哪个对象的方法
[anInvocation invokeWithTarget:self];
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
NSLog(@"无法处理消息：%@", NSStringFromSelector(aSelector));
}


//上面的"v@:"  是指类似右边的代码  void msg(id self, SEL cmd)   void + self + cmd
/*
Q - NSUInteger
q - NSInteger
v - void
i - int
@ - OC类，包括NSString , NSArray , id等
: - SEL

*/
```




