//
//  ViewController.m
//  Peek-a-Boo
//
//  Created by Kagan Riedel on 1/30/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import "UserViewController.h"
#import "AppDelegate.h"
#import "User.h"

@interface UserViewController () <NSFetchedResultsControllerDelegate>
{
    CGFloat imageViewHeight;
    CGFloat imageViewWidth;
    
    __weak IBOutlet UIScrollView *userScrollView;
    NSManagedObjectContext *managedObjectContext;
    
    NSFetchedResultsController *fetchedResultsController;
    
}

@end

@implementation UserViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    imageViewWidth = 130.0;
    imageViewHeight = 222.0;


    managedObjectContext = ((AppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    fetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"photo" ascending:YES]];
    fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    [fetchedResultsController performFetch:nil];
    fetchedResultsController.delegate = self;
    if (fetchedResultsController.fetchedObjects.count == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hey Loner" message:@"Why don't you add some friends with the + button?" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        [self loadScrollViewWithImages];
    }
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    [self loadScrollViewWithImages];
}

-(void)loadScrollViewWithImages
{
    
    int columns = 5;
    int rows = 1 + (fetchedResultsController.fetchedObjects.count)/columns;
    int count = 0;
    userScrollView.contentSize = CGSizeMake(userScrollView.frame.size.width*2.4, (userScrollView.frame.size.height/2)*rows);

    for (int i = 0; i < rows; i++)
    {
        for (int j = 0; j < columns; j++)
        {
            
            UIImageView *imageView = [UIImageView new];
            User *user = fetchedResultsController.fetchedObjects[count];
            imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:user.photo]]];
            imageView.frame = CGRectMake((20+20*j)+(imageViewWidth*j),
                                         (20+20*i)+(imageViewHeight*i),
                                         imageViewWidth,
                                         imageViewHeight);
        
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.backgroundColor = [UIColor redColor];

            [userScrollView addSubview:imageView];
            count++;
            if (count >= fetchedResultsController.fetchedObjects.count)
            {
                return;
            }
        }
    }
}


@end
