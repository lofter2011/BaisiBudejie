//
//  XYWebViewController.m
//  BaisiBudejie
//
//  Created by 韩啸宇 on 15/12/7.
//  Copyright © 2015年 韩啸宇. All rights reserved.
//

#import "XYWebViewController.h"

@interface XYWebViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshItem;

@end

@implementation XYWebViewController

- (instancetype)initWithURLPath:(NSString *)urlPath
{
    if (self = [super init]) {
        self.urlPath = urlPath;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlPath]];
    [self.webView loadRequest:request];
}

#pragma mark - 代理
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.backItem.enabled = webView.canGoBack;
    self.forwardItem.enabled = webView.canGoForward;
}

#pragma mark - 监听
- (IBAction)goBack:(id)sender {
    [self.webView goBack];
}

- (IBAction)goForward:(id)sender {
    [self.webView goForward];
}

- (IBAction)reload:(id)sender {
    [self.webView reload];
}
@end
