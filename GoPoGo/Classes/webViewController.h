//
//  webViewController.h
//  GoPoGo
//
//  Created by User on 2/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "LoginController.h"

@interface webViewController : UIViewController  <UIWebViewDelegate, UITextFieldDelegate>
{
	UIWebView *webviewscreen;
	UITextField *txt_URL;
	UIButton *btn_Search, *btn_Close , *btn_Right, *btn_Left;
	UIImageView *img_URL;
	UIActivityIndicatorView *av;
	UINavigationBar *navBar , *BotnavBar;
	
}

@property (nonatomic, retain) UIWebView *webviewscreen;
@property (nonatomic, retain) UIActivityIndicatorView *av;

-(void) btn_SearchPressed;
-(void) btn_ClosePressed;
@end
