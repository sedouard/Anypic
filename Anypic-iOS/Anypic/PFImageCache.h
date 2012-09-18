//
//  PFUrlCache.h
//  Parse
//
//  Created by Qian Wang on 5/16/12.
//  Copyright (c) 2012 Parse Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static inline NSString *cacheKeyFromUrl(NSURL *url) {
    return [url absoluteString];
}

@interface PFImageCache : NSCache
+ (PFImageCache *)sharedCache;
- (UIImage *)imageForUrl:(NSURL *)url;
- (void)setImage:(UIImage *)image forUrl:(NSURL *)url;
@end
