//
//  NSDictionary+ObjectForKeyNotNull.h
//  MicroBlog
//
//  Created by xujiajia on 16/2/17.
//  Copyright © 2016年 xujiajia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ObjectForKeyNotNull)

- (id)objectForKeyNotNull:(id)aKey;
@end
