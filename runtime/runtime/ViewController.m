//
//  ViewController.m
//  runtime
//
//  Created by beginner on 16/1/26.
//  Copyright © 2016年 beginner. All rights reserved.
//

#import "ViewController.h"
#import "ExchangeMethod.h"
#import "Message.h"
#import "ZBMethod.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	//交换method
//	[ExchangeMethod test];
	
	//runtime 的消息转发流程
//	[Message test];
	
	[ZBMethod test];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
