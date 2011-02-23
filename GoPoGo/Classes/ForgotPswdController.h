//
//  ForgotPswdController.h
//  GoPoGo
//
//  Created by User on 1/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ForgotPswdController : UIViewController <UITextFieldDelegate,NSXMLParserDelegate> {
	
	
	UITextField* emailText;
	
	UIButton* resetBtton , *CancelBtton;
	
	CGRect frameLogin;
	CGRect frameCrAcc;
	
	/// for webservice 
	NSMutableData *webData;
	NSMutableString *soapResults;
	NSXMLParser *xmlParser;
	BOOL *recordResults, statusFlag ;
	
	UIImageView* backgroundView;

}

@property(nonatomic, retain) NSMutableData *webData;
@property(nonatomic, retain) NSMutableString *soapResults;
@property(nonatomic, retain) NSXMLParser *xmlParser;


-(void) callMainView;
-(void) resetBttonPressed;
-(void)cancelBttonPressed;


@end

