//
//  SignUpController.h
//  GoPoGo
//
//  Created by User on 1/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBDialog.h"
#import "FBConnect.h"
#import "webViewController.h"

@class GoPoGoAppDelegate;

@interface SignUpController : UIViewController <UIAlertViewDelegate,UITextFieldDelegate,NSXMLParserDelegate, FBSessionDelegate, FBRequestDelegate>{

	UILabel* label;
	UILabel* mainLabel;
	UITextView* textView;
	
	UIImageView* backgroundView;
	
	UITextField* emailText;
	UITextField* paswdText;
	UITextField* repeatPswdTxt;
	
	UIButton* SignUpBtton;
	UIButton* LoginBtton;
	UIButton* CancelBtton;
	CGRect frameCrAccLbl;
	
	NSMutableData *responseData;
    NSMutableArray *translations;

	GoPoGoAppDelegate *objAppDelegate;
	
	/// for webservice 
	NSMutableData *webData;
	NSMutableString *soapResults;
	NSXMLParser *xmlParser;
	BOOL *recordResults;
	BOOL statusFlag;
	
	NSString* emailFB;
    FBUID fbookUID;
	
	FBLoginButton *loginButton; 
	FBSession *usersession;

	UIAlertView *activationAlert;
	UIActivityIndicatorView *objActivityView;
}
@property (nonatomic, retain) IBOutlet GoPoGoAppDelegate *objAppDelegate;

@property(nonatomic, retain) NSMutableData *webData;
@property(nonatomic, retain) NSMutableString *soapResults;
@property(nonatomic, retain) NSXMLParser *xmlParser;

/// fbook properties
@property(nonatomic,retain) FBLoginButton *loginButton; 
@property(nonatomic,retain) FBSession *usersession;
@property(nonatomic,retain) UIAlertView *activationAlert;
@property(nonatomic,retain) UIActivityIndicatorView *objActivityView;

-(void) LoginBtnPressed;
-(void) callMainView;
-(void)cancelBttonPressed;
-(void) fbookLoginCalled;
- (void)getFacebookName;
@end
