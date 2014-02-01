//
//  gridView.m
//  Peek-a-Boo
//
//  Created by Kagan Riedel on 1/31/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import "GridView.h"


@implementation GridView

-(id)initWithUser:(User*)user originx:(CGFloat)x originy:(CGFloat)y
{
    self = [super init];
    self.frame = CGRectMake(x, y, 130, 222);
    
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:user.photo]]];
    imageView.frame = CGRectMake(x, y, 130, 222);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imageView];
    
    self.backgroundColor = [UIColor darkGrayColor];

    return self;
}





@end
