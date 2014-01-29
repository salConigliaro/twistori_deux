//
//  twistori_deuxView.m
//  twistori_deux
//
//  Created by Sal Conigliaro on 10/10/13.
//  Copyright (c) 2013 e design. All rights reserved.
//

#import "twistori_deuxView.h"

@implementation twistori_deuxView

+ (BOOL)performGammaFade {
    return YES;
}

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/30.0];
    }
    
    return self;
}

-(BOOL)isPreview {
    return NO;
}

- (void)startAnimation
{
    [super startAnimation];
    
    // Create the webview for the screensaver.
    webView_ = [[WebView alloc] initWithFrame:[self bounds]];
    [webView_ setFrameLoadDelegate:self];
    [webView_ setShouldUpdateWhileOffscreen:YES];
    [webView_ setPolicyDelegate:self];
    [webView_ setUIDelegate:self];
    [webView_ setEditingDelegate:self];
    [webView_ setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
    [webView_ setAutoresizesSubviews:YES];
    [webView_ setDrawsBackground:NO];
    [self addSubview:webView_];
    
    NSColor *color = [NSColor colorWithCalibratedWhite:0.0 alpha:1.0];
    [[webView_ layer] setBackgroundColor:color.CGColor];
    
    [webView_ setMainFrameURL:@"http://twistori.com/"];
    
}

- (void)stopAnimation
{
    [super stopAnimation];
    
    [webView_ removeFromSuperview];
    [webView_ close];
    webView_ = nil;
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
}

- (void)dealloc {
    [webView_ setFrameLoadDelegate:nil];
    [webView_ setPolicyDelegate:nil];
    [webView_ setUIDelegate:nil];
    [webView_ setEditingDelegate:nil];
    [webView_ close];
}

- (void)animateOneFrame
{
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

#pragma mark Focus Overrides

// A bunch of methods that captures all the input events to prevent
// the webview from getting any keyboard focus.

- (NSView *)hitTest:(NSPoint)aPoint {
    return self;
}

- (void)keyDown:(NSEvent *)theEvent {
    return;
}

- (void)keyUp:(NSEvent *)theEvent {
    return;
}

- (BOOL)acceptsFirstResponder {
    return YES;
}

- (BOOL)resignFirstResponder {
    return NO;
}

#pragma mark WebPolicyDelegate

- (void)webView:(WebView *)webView
decidePolicyForNewWindowAction:(NSDictionary *)actionInformation
        request:(NSURLRequest *)request
   newFrameName:(NSString *)frameName
decisionListener:(id < WebPolicyDecisionListener >)listener {
    // Don't open new windows.
    [listener ignore];
}

- (void)webView:(WebView *)webView didFinishLoadForFrame:(WebFrame *)frame {
    [webView resignFirstResponder];
    [[[webView mainFrame] frameView] setAllowsScrolling:NO];
    [webView setDrawsBackground:YES];
}

- (void)webView:(WebView *)webView unableToImplementPolicyWithError:(NSError *)error frame:(WebFrame *)frame {
    NSLog(@"unableToImplement: %@", error);
}

#pragma mark WebUIDelegate

- (NSResponder *)webViewFirstResponder:(WebView *)sender {
    return self;
}

- (void)webViewClose:(WebView *)sender {
    return;
}

- (BOOL)webViewIsResizable:(WebView *)sender {
    return NO;
}

- (BOOL)webViewIsStatusBarVisible:(WebView *)sender {
    return NO;
}

- (void)webViewRunModal:(WebView *)sender {
    return;
}

- (void)webViewShow:(WebView *)sender {
    return;
}

- (void)webViewUnfocus:(WebView *)sender {
    return;
}



@end
