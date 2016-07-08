//
//  ExchangeMethod.m
//  runtime
//
//  Created by beginner on 16/7/8.
//  Copyright © 2016年 beginner. All rights reserved.
//

#import "ExchangeMethod.h"

@implementation ExchangeMethod
- (void)firstMethod {
	NSLog(@"firstMethod");
}
- (void)secondMethod {
	NSLog(@"secondMethod");
}

+ (void)test {
	[[ExchangeMethod new] firstMethod];
	
	//交换实例方法
	Method m1 = class_getInstanceMethod([ExchangeMethod class], @selector(firstMethod));
	Method m2 = class_getInstanceMethod([ExchangeMethod class], @selector(secondMethod));
	method_exchangeImplementations(m1, m2);
	
	[[ExchangeMethod new] firstMethod];
}

@end
