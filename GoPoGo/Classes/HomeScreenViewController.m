//
//  HomeScreenViewController.m
//  GoPoGo
//
//  Created by Mahendra Raut on 1/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HomeScreenViewController.h"
#import "GoPoGoAppDelegate.h"

@implementation HomeScreenViewController 
@synthesize txt_Search , objLoginCtrlr;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	
	 ///self.view.frame = CGRectMake(0, 0, 320, 480);
    if (self) 
	{
        // Custom initialization.
		Scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,320,480)];
		///
		
		UIImage *photoImage;
		photoImage = [ UIImage imageNamed: @"sign-out-btn.png"];
		
		SignOutBtn = [ UIButton buttonWithType:UIButtonTypeCustom];//RoundedRect ];
		SignOutBtn.frame = CGRectMake(225, 5, photoImage.size.width, photoImage.size.height); // position in the parent view and set the size of the button
		
		[SignOutBtn  setBackgroundImage:[ UIImage imageNamed: @"sign-out-btn.png"] forState:(UIControlState) normal ]; 
		[SignOutBtn addTarget:self action:@selector(SignOutPressed) forControlEvents:UIControlEventTouchUpInside ];
		
		
		
		[photoImage release];
		
		///
		
		//label view --Done v
//		img_zipcode=[[UIImageView alloc]init];
//		img_zipcode.frame =CGRectMake(225, 8, 75, 30);
//		img_zipcode.image=[UIImage imageNamed:@"zipcode-bg.png"];
//		
//		lbl_zip=[[UILabel alloc]initWithFrame:CGRectMake(225, 8, 73, 30)];
//		[lbl_zip setText:@"????"];
//		[lbl_zip setBackgroundColor:[UIColor clearColor]];		
//		lbl_zip.textColor=[UIColor blackColor];
//		lbl_zip.textAlignment = UITextAlignmentCenter; 
//		lbl_zip.font=[UIFont boldSystemFontOfSize:19];		
//		
//		///label view
		
		//text field
		
		txt_Search=[[UITextField alloc]initWithFrame:CGRectMake(27,397,223,34)];
		//txt_Search.borderStyle=YES;
		txt_Search.delegate = self;
		txt_Search.returnKeyType = UIReturnKeyDone;
		txt_Search.autocorrectionType = UITextAutocorrectionTypeNo;
		[txt_Search.layer setBackgroundColor: [[UIColor clearColor] CGColor]];
		//[txt_Search.layer setBorderColor:[[UIColor colorWithRed:255.0/255.0 green:192.0/255.0 blue:203.0/255.0 alpha:1.0] CGColor]];
		//[txt_Search.layer setBorderWidth: 2.0];
		[txt_Search.layer setCornerRadius:8.0f];
		[txt_Search.layer setMasksToBounds:YES];
		txt_Search.placeholder=@"Search";
		txt_Search.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;		
		txt_Search.font = [UIFont systemFontOfSize:18.0];	
		txt_Search.textColor=[UIColor blackColor];
		//txt_Search.textColor=[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:246.0/255.0 alpha:1.0];
		
		///text field
		
		//image view
			
		img_tophomepage=[[UIImageView alloc]init];
		img_tophomepage.frame =CGRectMake(0,0,320,359);
		img_tophomepage.image=[UIImage imageNamed:@"homepage-top.png"];
		
		img_bothomepage=[[UIImageView alloc]init];
		img_bothomepage.frame =CGRectMake(0,359,320,103);
		img_bothomepage.image=[UIImage imageNamed:@"homepage-bot.png"];
	
	//Done v
		img_search=[[UIImageView alloc]init];
		img_search.frame =CGRectMake(5,364,305,94);
		img_search.image=[UIImage imageNamed:@"search-bg.png"];
					
		///image view
		
		//button
		
		
		btn_Logo=[UIButton buttonWithType:UIButtonTypeCustom];
		[btn_Logo setFrame:CGRectMake(10,4,150,35)];
		//[btn_Logo setImage:[UIImage imageNamed:@"locator.png"]forState:UIControlStateNormal];
		//[btn_Locator addTarget:self action:@selector(btn_Locator_Press) forControlEvents:UIControlEventTouchUpInside];
		[btn_Logo addTarget:self action:@selector(btn_LogoPress) forControlEvents:UIControlEventTouchUpInside];
		
	//Done v
		btn_Locator=[UIButton buttonWithType:UIButtonTypeCustom];
		[btn_Locator setFrame:CGRectMake(182,6,33,30)];
		[btn_Locator setImage:[UIImage imageNamed:@"locator.png"]forState:UIControlStateNormal];
		//[btn_Locator addTarget:self action:@selector(btn_Locator_Press) forControlEvents:UIControlEventTouchUpInside];
		[btn_Locator addTarget:self action:@selector(anyBtnPress) forControlEvents:UIControlEventTouchUpInside];
	//Done v	
		btn_Browse=[UIButton buttonWithType:UIButtonTypeCustom];
		[btn_Browse setFrame:CGRectMake(5,50,105,97)];
		[btn_Browse setImage:[UIImage imageNamed:@"browse-icon.png"]forState:UIControlStateNormal];
		//[btn_Browse addTarget:self action:@selector(btn_Browse_Press) forControlEvents:UIControlEventTouchUpInside];
		[btn_Browse addTarget:self action:@selector(anyBtnPress) forControlEvents:UIControlEventTouchUpInside];
	//Done v
		btn_MyPlaylist=[UIButton buttonWithType:UIButtonTypeCustom];
		[btn_MyPlaylist setFrame:CGRectMake(5,147,105,93)];
		[btn_MyPlaylist setImage:[UIImage imageNamed:@"my-playlists-icon.png"]forState:UIControlStateNormal];
		//[btn_MyPlaylist addTarget:self action:@selector(btn_MyPlaylist_Press) forControlEvents:UIControlEventTouchUpInside];
		[btn_MyPlaylist addTarget:self action:@selector(anyBtnPress) forControlEvents:UIControlEventTouchUpInside];
	//Done v
		btn_FavPlaces=[UIButton buttonWithType:UIButtonTypeCustom];
		[btn_FavPlaces setFrame:CGRectMake(5,251,105,90)];
		[btn_FavPlaces setImage:[UIImage imageNamed:@"fav-places-icon.png"]forState:UIControlStateNormal];
		//[btn_FavPlaces addTarget:self action:@selector(btn_FavPlaces_Press) forControlEvents:UIControlEventTouchUpInside];
		[btn_FavPlaces addTarget:self action:@selector(anyBtnPress) forControlEvents:UIControlEventTouchUpInside];
	//Done v	
		btn_MyQueue=[UIButton buttonWithType:UIButtonTypeCustom];
		[btn_MyQueue setFrame:CGRectMake(114,49,99,84)];
		[btn_MyQueue setImage:[UIImage imageNamed:@"my-queue-icon.png"]forState:UIControlStateNormal];
		//[btn_MyQueue addTarget:self action:@selector(btn_MyQueue_Press) forControlEvents:UIControlEventTouchUpInside];
		[btn_MyQueue addTarget:self action:@selector(anyBtnPress) forControlEvents:UIControlEventTouchUpInside];
	//Done v
		btn_MyFans=[UIButton buttonWithType:UIButtonTypeCustom];
		[btn_MyFans setFrame:CGRectMake(114,147,99,93)];
		[btn_MyFans setImage:[UIImage imageNamed:@"my-fans-icon.png"]forState:UIControlStateNormal];
		//[btn_MyFans addTarget:self action:@selector(btn_MyFans_Press) forControlEvents:UIControlEventTouchUpInside];
		[btn_MyFans addTarget:self action:@selector(anyBtnPress) forControlEvents:UIControlEventTouchUpInside];
	//Done v	
		btn_NearByMe=[UIButton buttonWithType:UIButtonTypeCustom];
		[btn_NearByMe setFrame:CGRectMake(114,251,99,90)];
		[btn_NearByMe setImage:[UIImage imageNamed:@"near-by-me-icon.png"]forState:UIControlStateNormal];
		//[btn_NearByMe addTarget:self action:@selector(btn_NearByMe_Press) forControlEvents:UIControlEventTouchUpInside];
		[btn_NearByMe addTarget:self action:@selector(anyBtnPress) forControlEvents:UIControlEventTouchUpInside];
	//Done v	
		btn_Create=[UIButton buttonWithType:UIButtonTypeCustom];
		[btn_Create setFrame:CGRectMake(219,49,81,84)];
		[btn_Create setImage:[UIImage imageNamed:@"create-icon.png"]forState:UIControlStateNormal];
		//[btn_Create addTarget:self action:@selector(btn_Create_Press) forControlEvents:UIControlEventTouchUpInside];
		[btn_Create addTarget:self action:@selector(anyBtnPress) forControlEvents:UIControlEventTouchUpInside];
	//Done v
		btn_FanOf=[UIButton buttonWithType:UIButtonTypeCustom];
		[btn_FanOf setFrame:CGRectMake(219,146,82,93)];
		[btn_FanOf setImage:[UIImage imageNamed:@"fan-of-icon.png"]forState:UIControlStateNormal];
		//[btn_FanOf addTarget:self action:@selector(btn_FanOf_Press) forControlEvents:UIControlEventTouchUpInside];
		[btn_FanOf addTarget:self action:@selector(anyBtnPress) forControlEvents:UIControlEventTouchUpInside];
	//Done v
		btn_Account=[UIButton buttonWithType:UIButtonTypeCustom];
		[btn_Account setFrame:CGRectMake(219,250,82,90)];
		[btn_Account setImage:[UIImage imageNamed:@"account-icon.png"]forState:UIControlStateNormal];
		//[btn_Account addTarget:self action:@selector(btn_Account_Press) forControlEvents:UIControlEventTouchUpInside];
		[btn_Account addTarget:self action:@selector(AccBtnPress) forControlEvents:UIControlEventTouchUpInside];
		
		btn_Search=[UIButton buttonWithType:UIButtonTypeCustom];
		[btn_Search setFrame:CGRectMake(262,394,41,38)];
		[btn_Search setImage:[UIImage imageNamed:@"search-btn.png"]forState:UIControlStateNormal];
		//[btn_Search addTarget:self action:@selector(btn_Search_Press) forControlEvents:UIControlEventTouchUpInside];
		[btn_Search addTarget:self action:@selector(anyBtnPress) forControlEvents:UIControlEventTouchUpInside];
		
		///button
		
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
		
	[self.view addSubview:Scroll];

	[Scroll addSubview:img_tophomepage];
	[Scroll addSubview:img_bothomepage];
	//[Scroll addSubview:img_homepageBG];
	//[Scroll addSubview:img_homepage];
	
	//[Scroll addSubview:btn_Logo];
	[Scroll addSubview:btn_Locator];
	[Scroll addSubview: SignOutBtn ]; 
//	[Scroll addSubview:img_zipcode];
//	[Scroll addSubview:lbl_zip];
	
	[Scroll addSubview:btn_Browse];
	[Scroll addSubview:btn_MyPlaylist];
	[Scroll addSubview:btn_FavPlaces];
	
	[Scroll addSubview:btn_MyQueue];
	[Scroll addSubview:btn_MyFans];
	[Scroll addSubview:btn_NearByMe];
	
	[Scroll addSubview:btn_Create];
	[Scroll addSubview:btn_FanOf];
	[Scroll addSubview:btn_Account];
	
	//[Scroll addSubview:img_search];
	[Scroll addSubview:btn_Search];
	[Scroll addSubview:txt_Search];
	
	[Scroll setScrollEnabled:TRUE];
	Scroll.clipsToBounds=YES;
	
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
	[txt_Search resignFirstResponder];
	[Scroll setContentOffset:svos animated:YES];	
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField 
{	
		svos = Scroll.contentOffset;
		CGPoint pt;
		CGRect rc = [textField bounds];
		rc = [textField convertRect:rc toView:Scroll];
		pt = rc.origin;
		pt.x = 0;
		pt.y -= 180;
		[Scroll setContentOffset:pt animated:YES];
}

//Button press functions
-(void) anyBtnPress
{
	NSLog(@"Button Pressed");        
	UIAlertView *alert = [[UIAlertView alloc] 
					  initWithTitle:@"Button Pressed" 
					  
					  message:@"Its Working" 
					  delegate:self  
					  cancelButtonTitle:@"OK" 
					  otherButtonTitles:nil];
	[alert show];
	[alert release];
}

-(void) AccBtnPress
{
	printf("\n Acc btn pressed");
	AccountView* objAccntView= [[AccountView alloc] init];
	
	[self.navigationController pushViewController: objAccntView animated:YES];
	[objAccntView release];
	
}

-(void) btn_LogoPress
{
	//NSLog(@"Button_Logo Pressed");
//	login=[[LoginController alloc]init];
//	[self.navigationController pushViewController:login animated:YES]; 
//	[login release];
}

///Button press functions


/*

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
	//return YES;
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

*/
- (void)didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc 
{
    [super dealloc];
	//[Scroll dealloc];
//	[txt_Search dealloc];
//	[btn_Locator dealloc];
//	[btn_Browse dealloc];
//	[btn_MyQueue dealloc];
//	[btn_Create dealloc];
//	[btn_MyPlaylist dealloc];
//	[btn_MyFans dealloc];
//	[btn_FanOf dealloc];
//	[btn_FavPlaces dealloc];
//	[btn_NearByMe dealloc];
//	[btn_Account dealloc];
//	[btn_Search dealloc];
//	[img_homepage dealloc];
//	[img_search dealloc];
//	[img_zipcode dealloc];
//	[img_homepageBG dealloc];
				
}

-(void) SignOutPressed
{
	printf("\n SignOut pressed");
	
	if (_session.isConnected)
	{
		printf("\n if session connected");
		[_session logout];
	}
	objAppDelegate = (GoPoGoAppDelegate*) [[UIApplication sharedApplication]delegate];
	
	objAppDelegate.isLogin = FALSE;
	
	if(objAppDelegate._session.isConnected)
	{
		printf("\n 11if session connected");
		[objAppDelegate._session logout];
		
		///[objAppDelegate ShowMainView];
		
	}
	[objAppDelegate ShowMainView];
	
}



@end
