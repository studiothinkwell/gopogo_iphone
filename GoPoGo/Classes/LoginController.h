//
//  LoginController.h
//  GoPoGo
//
//  Created by User on 1/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBDialog.h"
#import "FBConnect.h"
#import "FBSession.h"
#import "GoPoGoViewController.h"

@class GoPoGoAppDelegate;



@interface LoginController : UIViewController <UITextFieldDelegate, NSXMLParserDelegate,FBDialogDelegate, FBSessionDelegate, FBRequestDelegate>{

	
	
	UILabel* mainLabel;
	GoPoGoAppDelegate *objAppDelegate;
	UITextField* emailText;
	UITextField* paswdText;
	UIButton*	 SignInBtton;
	UIButton *btnFBConnect;
	UIButton* CancelBtton;
	UIButton* passwdBtton , *createAccBtton;
	CGRect frameCrAcc;
	CGRect frameFgtPswd , frameQue;
	
	UILabel *CrAccLabel , *CrQueLabel;
	
	/// for webservice 
	NSMutableData *webData;
	NSMutableString *soapResults;
	NSXMLParser *xmlParser;
	BOOL *recordResults, emailResFlag , statusFlag;
	
	NSString* emailRes;
	
	NSString* emailFB;
    FBUID fbookUID;
	
	FBLoginButton *loginButton;
	FBSession *usersession;
	
	
	NSString *username;
	UILabel *userlabel;
	NSString *empty;
	UIImageView* backgroundView;
	FBSession* _session;



}

@property (nonatomic, retain) IBOutlet GoPoGoAppDelegate *objAppDelegate;

@property(nonatomic,retain) FBSession* _session;

@property(nonatomic, retain) NSMutableData *webData;
@property(nonatomic, retain) NSMutableString *soapResults;
@property(nonatomic, retain) NSXMLParser *xmlParser;

/// fbook properties
@property(nonatomic,retain) FBLoginButton *loginButton; 
@property(nonatomic,retain)  FBSession *usersession;
@property(nonatomic,retain) NSString *username;



-(void) callMainView;
-(void) SignInBttonPressed;
-(void) cancelBttonPressed;
-(void) createAccountClicked;
-(void) forgotPasswdClicked;


/// fbook functions
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
-(void)getFacebookName;
-(void) fbookLoginCalled;
-(void) killFacebookSession;


@end
