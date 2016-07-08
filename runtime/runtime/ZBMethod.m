//
//  ZBMethod.m
//  runtime
//
//  Created by beginner on 16/7/8.
//  Copyright © 2016年 beginner. All rights reserved.
//

#import "ZBMethod.h"

@implementation ZBMethod
- (void)methodWithoutReturnAndArgument {
	NSLog(@"methodWithoutReturnAndArgument");
}

- (NSUInteger)methodWithIntAndArgument:(NSString*)test {
	return test.length;
}

- (NSMutableArray *)arraymethodArray:(NSString *)key {
	NSMutableArray *arry =[[NSMutableArray alloc] init];
	for (int i = 0; i < key.length; i ++) {
		NSString *t = [key substringWithRange:NSMakeRange(i, 1)];
		[arry addObject:t];
	}
	return arry;
}

- (void)logMethods {
	unsigned int outCount = 0;
	//获取method列表
	Method *methods = class_copyMethodList(self.class, &outCount);
	for (int i = 0; i < outCount; i++) {
		
		Method method = methods[i];
		SEL nameSel =  method_getName(method);
		
		const char *type = method_getTypeEncoding(method);
		NSString *typeStr = [NSString stringWithUTF8String:type];
		
		char returnType[256] = {};
		method_getReturnType(method, returnType, 256);
		NSString *returnTypeStr = [NSString stringWithUTF8String:returnType];
		
		NSLog(@"name : %@ |type : (%@) |returyType:(%@)| ",NSStringFromSelector(nameSel),typeStr,returnTypeStr);
		
		/*
		 Q - NSUInteger
		 q - NSInteger
		 v - void
		 i - int
		 @ - OC类，包括NSString , NSArray , id等
		 : - SEL
		 */
		
	}
	free(methods);
}

+ (void)test {
	((void (*)(id,SEL))objc_msgSend)((id)[ZBMethod new],@selector(logMethods));
}

@end
