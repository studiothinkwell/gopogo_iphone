//
//  GoPoGoAppDelegate.h
//  GoPoGo
//
//  Created by User on 12/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
///GoPoGo with Json framework...Ragini.


#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "FBSession.h"



@class GoPoGoViewController;

@class LoginController;


@interface GoPoGoAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UIView *contentView;

    GoPoGoViewController *viewController;
	UIImageView* splashScreen;
	LoginController*  iLoginCtrl;
	
	UINavigationController *NavController;
	BOOL isLogin;
	FBSession *_session;
	

	
}


@property(nonatomic,retain) UIImageView* splashScreen;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet GoPoGoViewController *viewController;

@property (readwrite, assign) BOOL isLogin;

@property (nonatomic, retain) LoginController*  iLoginCtrl;

@property (nonatomic,retain) FBSession *_session;


-(void) ShowMainView;
-(NSString*) GenerateSessionId;
- (void) hideSplash;

@end

