//
//  PFImageButton.h
//  Parse
//
//  Created by Héctor Ramos on 5/21/12.
//  Copyright (c) 2012 Parse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFImageButton : UIButton

@property (nonatomic, retain) PFFile *file;
@property (nonatomic, retain) UIImage *placeholder;
- (void)load:(void (^)(UIImage *image, NSError *error))completion;

@end
