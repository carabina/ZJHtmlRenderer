//
//  ViewController.m
//  ZJHtmlRendererDemo
//
//  Created by Evan on 25/8/2017.
//  Copyright © 2017 Evan. All rights reserved.
//

#import "ViewController.h"
#import "ZJHtmlRenderer.h"

@interface ViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) ZJHtmlRenderer *htmlRenderer;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.scrollView addSubview:self.imageView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickRefreshButton:(UIBarButtonItem *)sender {
    NSURL *url = [NSURL URLWithString:@"https://www.apple.com"];
    
    CGFloat imageWidth = CGRectGetWidth(self.view.frame);
    
    __weak typeof(self) weakSelf = self;
    self.htmlRenderer = [ZJHtmlRenderer creatImageWithURL:url imageWidth:imageWidth completion:^(UIImage *image, NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf setImage:image];
    }];
}

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
    
    CGRect frame = self.imageView.frame;
    frame.size = image.size;
    self.imageView.frame = frame;
}

#pragma mark - UIScrollViewDelegate

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

#pragma mark - Getter

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

@end
