//
//  AddUserViewController.m
//  Peek-a-Boo
//
//  Created by Kagan Riedel on 1/30/14.
//  Copyright (c) 2014 Kagan Riedel. All rights reserved.
//

#import "AddUserViewController.h"
#import "AppDelegate.h"
#import "User.h"

@interface AddUserViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    __weak IBOutlet UITextField *nameTextField;
    __weak IBOutlet UITextField *phoneNumberTextField;
    __weak IBOutlet UITextField *emailTextField;
    __weak IBOutlet UITextField *addressTextField;
    __weak IBOutlet UITextField *cityTextField;
    __weak IBOutlet UITextField *stateTextField;
    __weak IBOutlet UITextField *zipTextField;
    __weak IBOutlet UIImageView *imageView;
}

@end

@implementation AddUserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)saveUserButtonPressed:(id)sender
{
    int imageSuffix;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults integerForKey:@"imageCount"])
    {
        imageSuffix = 0;
        [userDefaults setInteger:imageSuffix forKey:@"imageCount"];
        [userDefaults synchronize];
    }
    else
    {
        imageSuffix = [userDefaults integerForKey:@"imageCount"];
    }
    
    NSManagedObjectContext *managedObjectContext = ((AppDelegate*)([UIApplication sharedApplication].delegate)).managedObjectContext;
    
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:managedObjectContext];
    user.name = nameTextField.text;
    user.phoneNumber = phoneNumberTextField.text;
    user.email = emailTextField.text;
    user.address = [NSString stringWithFormat:@"%@, %@ %@, %@", addressTextField.text, cityTextField.text, stateTextField.text, zipTextField.text];
    NSLog(@"%@",user.address);
    
    NSData *imageData = UIImagePNGRepresentation(imageView.image);
    

    NSURL *documentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    NSURL *imageURL =[documentsDirectory URLByAppendingPathComponent:[NSString stringWithFormat:@"cached_%i.png",imageSuffix]];
    NSLog((@"pre writing to file"));
    if (![imageData writeToURL:imageURL atomically:NO])
    {
        NSLog((@"Failed to cache image data to disk"));
    }
    else
    {
        [imageData writeToURL:imageURL atomically:NO];
        user.photo = [NSString stringWithFormat:@"%@",imageURL];
        imageSuffix++;
        [userDefaults setInteger:imageSuffix forKey:@"imageCount"];
        [userDefaults synchronize];
        NSLog(@"the cachedImagedPath is %@",imageURL);
    }
    [managedObjectContext save:nil];
    
    [self.view endEditing:YES];
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)addPhotoButtonPressed:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *imagePickerController = [UIImagePickerController new];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    imageView.image = info[@"UIImagePickerControllerOriginalImage"];
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
