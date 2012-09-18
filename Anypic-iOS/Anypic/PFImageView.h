//
//  PFImageView.h
//  Parse
//
//  Created by Qian Wang on 5/16/12.
//  Copyright (c) 2012 Parse Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PFImageView : UIImageView

@property (nonatomic, retain) PFFile *file;
@property (nonatomic, retain) UIImage *placeholder;
- (void)load:(void (^)(UIImage *image, NSError *error))completion;

@end
