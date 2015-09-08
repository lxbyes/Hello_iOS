//
//  ViewController.m
//  Camera
//
//  Created by 赖显波 on 9/8/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>

@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *takePictureButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) MPMoviePlayerController *moviePlayerController;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSURL *movieURL;
@property (copy, nonatomic) NSString *lastChoseMediaType;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.takePictureButton.hidden = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateDisplay];
}

- (void)updateDisplay {
    if ([self.lastChoseMediaType isEqual:(NSString *)kUTTypeImage]) {
        self.imageView.image = self.image;
        self.imageView.hidden = NO;
        self.moviePlayerController.view.hidden = YES;
    } else {
        [self.moviePlayerController.view removeFromSuperview];
        self.moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:self.movieURL];
        
        [self.moviePlayerController play];
        UIView *movieView = self.moviePlayerController.view;
        movieView.frame = self.imageView.frame;
        movieView.clipsToBounds = YES;
        [self.view addSubview:movieView];
        self.imageView.hidden = YES;
    }
}

- (IBAction)shootPictureOrVideo:(UIButton *)sender {
    [self pickMediaFromSource:UIImagePickerControllerSourceTypeCamera];
}


- (IBAction)selectExistingPictureOrVideo:(UIButton *)sender {
    [self pickMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)pickMediaFromSource:(UIImagePickerControllerSourceType)sourceType {
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType] && [mediaTypes count] > 0) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.mediaTypes = mediaTypes;
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:NULL];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error accessing media" message:@"Unsupported media source." delegate:nil cancelButtonTitle:@"Drat!" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (UIImage *)shrinkImage:(UIImage *)original toSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
    
    CGFloat originalAspect = original.size.width / original.size.height;
    CGFloat targetAspect = size.width / size.height;
    CGRect targetRect;
    
    if (originalAspect > targetAspect) {
        targetRect.size.width = size.width;
        targetRect.size.height = size.height * targetAspect / originalAspect;
        targetRect.origin.x = 0;
        targetRect.origin.y = (size.height - targetRect.size.height) * 0.5;
    } else if (originalAspect < targetAspect){
        targetRect.size.width = size.width * originalAspect / targetAspect;
        targetRect.size.height = size.height;
        targetRect.origin.x = (size.width -targetRect.size.width) * 0.5;
        targetRect.origin.y = 0;
    } else {
        targetRect = CGRectMake(0, 0, size.width, size.height);
    }
    
    [original drawInRect:targetRect];
    UIImage *final = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return final;
}

#pragma mark - Image Picker Controller delegate methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.lastChoseMediaType = info[UIImagePickerControllerMediaType];
    if ([self.lastChoseMediaType isEqual:(NSString *)kUTTypeImage]) {
        UIImage *choseImage = info[UIImagePickerControllerEditedImage];
        self.image = [self shrinkImage:choseImage toSize:self.imageView.bounds.size];
    } else if ([self.lastChoseMediaType isEqual:(NSString *)kUTTypeMovie]){
        self.movieURL = info[UIImagePickerControllerMediaURL];
    }
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
@end
