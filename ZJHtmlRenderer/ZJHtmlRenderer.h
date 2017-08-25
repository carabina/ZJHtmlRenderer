//
//  ZJHtmlRenderer.h
//  ZJHtmlRenderer
//
//  Created by Evan on 24/8/2017.
//  Copyright © 2017 Evan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^CompletionBlock)(UIImage *image, NSError *error);

@interface ZJHtmlRenderer : NSObject<UIWebViewDelegate>

@property (nonatomic, assign) CGFloat imageWidth;

@property (nonatomic, copy) CompletionBlock completionBlock;

+ (instancetype)creatImageWithURL:(NSURL *)url
                       completion:(CompletionBlock)completionBlock;

+ (instancetype)creatImageWithHTMLString:(NSString *)string
                              completion:(CompletionBlock)completionBlock;

+ (instancetype)creatImageWithURL:(NSURL *)url
                       imageWidth:(CGFloat)imageWidth
                       completion:(CompletionBlock)completionBlock;

+ (instancetype)creatImageWithHTMLString:(NSString *)string
                              imageWidth:(CGFloat)imageWidth
                              completion:(CompletionBlock)completionBlock;

@end
