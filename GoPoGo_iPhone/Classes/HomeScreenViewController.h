//
//  HomeScreenViewController.h
//  GoPoGo
//
//  Created by Mahendra Raut on 1/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "LoginController.h"
#import "FBSession.h"
#import "AccountView.h"

@interface HomeScreenViewController : UIViewController <UITextFieldDelegate>
{
	UIScrollView *Scroll;
	UILabel *lbl_zip;
	UITextField *txt_Search;
	UIButton *btn_Locator, *btn_Browse, *btn_MyQueue, *btn_Create, *btn_MyPlaylist, *btn_MyFans, *btn_FanOf, *btn_FavPlaces, *btn_NearByMe, *btn_Account, *btn_Search, *btn_Logo;
	UIImageView *img_homepage, *img_search, *img_zipcode, *img_homepageBG ,*img_tophomepage, *img_bothomepage;
	CGPoint svos;
	LoginController *objLoginCtrlr;
	UIButton* SignOutBtn;
	FBSession* _session;
	
	GoPoGoAppDelegate *objAppDelegate;
	//AccountView* objAccntView;
	
}
@property(nonatomic, retain) UITextField *txt_Search;
@property (nonatomic, retain) IBOutlet GoPoGoAppDelegate *objAppDelegate;
@property(nonatomic,retain) FBSession* session;
@property(nonatomic, retain) LoginController *objLoginCtrlr;
-(void) anyBtnPress;
-(void) btn_LogoPress;

@end
