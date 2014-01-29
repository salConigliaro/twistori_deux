//
//  twistori_deuxView.h
//  twistori_deux
//
//  Created by Sal Conigliaro on 10/10/13.
//  Copyright (c) 2013 e design. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>
#import <WebKit/WebKit.h>

@interface twistori_deuxView : ScreenSaverView {
 WebView *webView_;
      NSTimer *timer_;
      NSInteger currentIndex_;
}

@property (nonatomic, retain) NSArray *urls;

@end
