//
//  CommonFunction.h
//  SampleJSON
//
//  Created by pachie on 14/7/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonFunction : NSObject

-(BOOL)CheckNSD:(NSData *)yourData;
-(void)ConnectionError;
-(NSString *)GetJsonConnection:(NSString *)MethodToCall;
//-(void) SortObjects:(NSMutableArray *)ArraryToSort CountedOjbect:(NSCountedSet *) countedset;

@end
