//
//  PFImageView.m
//  Parse
//
//  Created by Qian Wang on 5/16/12.
//  Copyright (c) 2012 Parse Inc. All rights reserved.
//

#import "PFImageView.h"
#import "PFImageCache.h"

@interface PFImageView ()

@end

@implementation PFImageView

@synthesize file;
@synthesize placeholder;

#pragma mark -
#pragma mark PFImageView

- (void)load:(void (^)(UIImage *, NSError *))completion {
    if (!file) {
        [NSException raise:NSInternalInconsistencyException format:@"PFImageView must have its file property set before calling load."];
    }
    
    NSURL *url = [NSURL URLWithString:self.file.url];
    UIImage *cachedImage = [[PFImageCache sharedCache] imageForUrl:url];
    if (cachedImage) {
        self.image = cachedImage;
        
        if (completion) {
            completion(cachedImage, nil);
        }
        return;
    }
    
    self.image = placeholder;
    
    PFFile *current = file;
    // TODO, change this to the new getDataStream API
    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        // we dispatch to a background queue to spee
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            if (!error) {            
                UIImage *image = [UIImage imageWithData:data];
                
                if (current == file) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.image = image;
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