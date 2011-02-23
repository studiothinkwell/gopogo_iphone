//
//  AccountView.h
//  GoPoGo
//
//  Created by User on 2/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AccountView : UIViewController <UITextFieldDelegate,NSXMLParserDelegate>{
	
	UIImageView* backgroundView , *backgroundView1 ,*backgroundView2;
	CGRect frameAcc , frameInfo;
	UILabel *AccLabel , *SignInfoLbl;
	UILabel *EmailLbl, *PswdLbl , *UsrLbl;
	UITextField* emailText ,*pswdText , * emailText1 , *oldpswdText , *newpswdText , *repswdText;
	
	UITextField* usrText, *usrText1;
	UIButton* resetBtton ,*resetBtton1 , *resetBtton2;
	UIView* newView;
	UILabel* EmailLbl1 ,*oldpswdLbl , *newpswdLbl, *repswdLbl ;
	
	UIImage *photoImage;
	UIImage *photoImage1 ;//, *closeImage;
	
	UIButton* saveBtton , *CancelBtton ,*LogoBtton;
			
	/// for webservice 
	NSMutableData *webData;
	NSMutableString *soapResults;
	NSXMLParser *xmlParser;
}
@property(nonatomic,retain) UIView* newView;


@property(nonatomic, retain) NSMutableData *webData;
@property(nonatomic, retain) NSMutableString *soapResults;
@property(nonatomic, retain) NSXMLParser *xmlParser;

-(void) updateEmailPressed;
-(void) closeClicked;
-(void) SaveBttonPressed;
-(void) cancelBttonPressed;
-(void) PswdUpdatePressed;
-(void) cancelBtton1Pressed;
-(void) usrUpdatePressed;
-(void) cancelBtton2Pressed;
-(void)LogoBtnPress;

@end
