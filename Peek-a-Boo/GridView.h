//
//  gridView.h
//  Peek-a-Boo
//
//  Created by Kagan Riedel on 1/31/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface GridView : UIView

-(id)initWithUser:(User*)user originx:(CGFloat)x originy:(CGFloat)y;

@end
