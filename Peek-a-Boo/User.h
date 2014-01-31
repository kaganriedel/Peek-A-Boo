//
//  User.h
//  Peek-a-Boo
//
//  Created by Kagan Riedel on 1/30/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * phoneNumber;
@property (nonatomic, retain) NSString * photo;

@end
