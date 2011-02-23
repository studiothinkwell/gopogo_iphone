//
//  GoPoGoViewController.h
//  GoPoGo
//
//  Created by User on 12/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

#import "FBSession.h"
@class LoginView;
@class GoPoGoAppDelegate;
@class SignUpView;
@class LoginController;

@interface GoPoGoViewController : UIViewController <UIScrollViewDelegate>//,FBSessionDelegate, FBRequestDelegate> {
{
	UIScrollView *scrollView,*scrollView1;
	UIView* contentView;
	
	UIButton *btn_getmore,*btn_left;
	UIButton *btn_right;
	UIButton *CreateAccBtn;
	
	CGFloat cx ;
	NSInteger count;
	UIImageView *cancel_img,*right_img,*left_img,*screen_img,*img_customize,*img_xo,*img_heart;
	UIImageView *imageView;
	NSInteger index1,index2,index3;
	CGRect rc ;
	CGPoint pt; CGRect rect;CGRect rect1 , rect2;
	int pos, nImages ;
	NSMutableArray* theURLArray ;
	GoPoGoAppDelegate *objAppDelegate;
	UIButton* SignInBtn;
	UIButton* SignOutBtn;
	//LoginView*  iLoginView;
	//SignUpView* iSignUpView;
	//LoginController* loginController;
	
	FBSession *usersession;

	 FBSession* _session;
	
}

//@property (nonatomic, retain) LoginView* iLoginView;
//@property (nonatomic, retain) SignUpView* iSignUpView;
//@property (nonatomic, retain) LoginController* loginController;

@property (nonatomic, retain) IBOutlet GoPoGoAppDelegate *objAppDelegate;
@property(nonatomic,retain) UIScrollView* scrollView1;
@property(nonatomic,retain) NSMutableArray* theURLArray;
@property(nonatomic,retain)  FBSession *usersession;

@property(nonatomic,retain) FBSession* session;
//-(void) ShowSignUpView;

-(void) LoginBtnPressed;
-(void) SignOutPressed;
-(void) CrAccBtnPressed;
-(void)getFacebookName;
@end

