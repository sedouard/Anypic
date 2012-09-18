//
//  PFUrlCache.m
//  Parse
//
//  Created by Qian Wang on 5/16/12.
//  Copyright (c) 2012 Parse Inc. All rights reserved.
//

#import "PFImageCache.h"

@implementation PFImageCache

+ (PFImageCache *)sharedCache {
    static dispatch_once_t onceToken;
    static PFImageCache *sharedCache;
    dispatch_once(&onceToken, ^{
        sharedCache = [[PFImageCache alloc] init];
    });
    
    return sharedCache;
}

- (UIImage *)imageForUrl:(NSURL *)url {
    return [self objectForKey:cacheKeyFromUrl(url)];
}

- (void)setImage:(UIImage *)image forUrl:(NSURL *)url {
    [self setObject:image forKey:cacheKeyFromUrl(url)];
}

@end
