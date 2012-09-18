//
//  PFImageButton.m
//  Parse
//
//  Created by Héctor Ramos on 5/21/12.
//  Copyright (c) 2012 Parse Inc. All rights reserved.
//

#import "PFImageButton.h"
#import "PFImageCache.h"

@interface PFImageButton ()

@end

@implementation PFImageButton

@synthesize file;
@synthesize placeholder;

#pragma mark -
#pragma mark PFImageButton

- (void)load:(void (^)(UIImage *, NSError *))completion {
    if (!file) {
        [NSException raise:NSInternalInconsistencyException format:@"PFImageButton must have its file property set before calling load."];
    }
    
    NSURL *url = [NSURL URLWithString:self.file.url];
    UIImage *cachedImage = [[PFImageCache sharedCache] imageForUrl:url];
    if (cachedImage) {
        [self setImage:cachedImage forState:UIControlStateNormal];
        
        if (completion) {
            completion(cachedImage, nil);
        }
        return;
    }
    
    [self setImage:placeholder forState:UIControlStateNormal];
    
    PFFile *current = file;
    // TODO, change this to the new getDataStream API
    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        // we dispatch to a background queue to spee
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            if (!error) {            
                UIImage *image = [UIImage imageWithData:data];
                
                if (current == file) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self setImage:image forState:UIControlStateNormal];
                    });
                }
                
                // TODO, we might not want to call this if (current != file), should we call this with error instead?
                if (completion) {
                    completion(image, nil);
                }
                
                // we always want to store the image in the cache
                [[PFImageCache sharedCache] setImage:image forUrl:url];
            } else {
                if (completion) {
                    completion(nil, error);
                }
            }            
        });
    }];
}

@end