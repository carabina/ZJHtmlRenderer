//
//  ZJHtmlRenderer.m
//  ZJHtmlRenderer
//
//  Created by Evan on 24/8/2017.
//  Copyright © 2017 Evan. All rights reserved.
//

#import "ZJHtmlRenderer.h"
#import "UIView+Snapshot.h"

@interface ZJHtmlRenderer ()

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, copy) NSString *HTMLString;

@end

@implementation ZJHtmlRenderer

- (instancetype)initWithURL:(NSURL*)url {
    self = [super init];
    if (self) {
        self.url = url;
        [self loadWebView];
    }
    return self;
}

- (instancetype)initWithHTMLString:(NSString*)string {
    self = [super init];
    if (self) {
        self.HTMLString = string;
        [self loadWebView];
    }
    return self;
}

- (void)loadWebView {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(-1, 0, 1, 1)];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    [window addSubview:self.webView];
    
    if (self.HTMLString) {
        [self.webView loadHTMLString:self.HTMLString baseURL:nil];
    }else {
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
    }
}

- (void)removeWebView {
    self.webView.delegate = nil;
    [self.webView stopLoading];
    [self.webView removeFromSuperview];
    self.webView = nil;
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (webView.isLoading) {
        return;
    }
    
    CGSize size =  [webView sizeThatFits:CGSizeMake(self.imageWidth, 0)];
    CGRect newFrame = webView.frame;
    newFrame.size = size;
    webView.frame = newFrame;
    
    UIImage *image = [webView snapshot];
    
    if (self.completionBlock) {
        self.completionBlock(image, nil);
    }
    
    [self removeWebView];;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if (webView.isLoading) {
        return;
    }
   
    if (self.completionBlock) {
        self.completionBlock(nil, error);
    }
    
    [self removeWebView];
}

#pragma mark - Setter

- (void)setImageWidth:(CGFloat)imageWidth {
    _imageWidth = imageWidth;
    
    if (self.webView) {
        CGRect newFrame = self.webView.frame;
        newFrame.origin.x = -imageWidth;
        newFrame.size.width = imageWidth;
        self.webView.frame = newFrame;
    }
}

#pragma mark - Public Methods

+ (instancetype)creatImageWithURL:(NSURL *)url completion:(CompletionBlock)completionBlock {
    return [self creatImageWithURL:url imageWidth:0 completion:completionBlock];
}

+ (instancetype)creatImageWithHTMLString:(NSString *)string completion:(CompletionBlock)completionBlock {
    return [self creatImageWithHTMLString:string imageWidth:0 completion:completionBlock];
}

+ (instancetype)creatImageWithURL:(NSURL *)url imageWidth:(CGFloat)imageWidth completion:(CompletionBlock)completionBlock {
    ZJHtmlRenderer *renderer = [[ZJHtmlRenderer alloc] initWithURL:url];
    renderer.completionBlock = completionBlock;
    renderer.imageWidth = imageWidth;
    return renderer;
}

+ (instancetype)creatImageWithHTMLString:(NSString *)string imageWidth:(CGFloat)imageWidth completion:(CompletionBlock)completionBlock {
    ZJHtmlRenderer *renderer = [[ZJHtmlRenderer alloc] initWithHTMLString:string];
    renderer.completionBlock = completionBlock;
    renderer.imageWidth = imageWidth;
    return renderer;
}

@end
