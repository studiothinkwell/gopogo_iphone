//
//  GoPoGoViewController.m
//  GoPoGo
//
//  Created by User on 12/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GoPoGoViewController.h"
#import "GoPoGoAppDelegate.h"
//#import "JSON/JSON.h"
//#import "LoginView.h"
//#import "SignUpView.h"
#import "LoginController.h"
#import "SignUpController.h"
#import "FBSession.h"




@implementation GoPoGoViewController
@synthesize objAppDelegate;
@synthesize usersession;//@synthesize lastText = _lastText;
@synthesize scrollView1,theURLArray;
//@synthesize  loginController;//,iSignUpView; ///iMainView,iForgotPswd;
//@synthesize session;
@synthesize session = _session;
-(id) init
{
	if(self = [super init ] )
	{
		self.view.frame = CGRectMake(0, 0, 320, 480);
	}
	return self;
}
/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	printf("\n GOpoGoViewCtrl viewDidLoad");
    [super viewDidLoad];
	
	
	[self.view setBackgroundColor:[UIColor whiteColor]];
	
		
	UIImageView* LogoImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 140, 50)];
	LogoImage.image = [UIImage imageNamed:@"logo.png"];
	[self.view addSubview:LogoImage];
	
	SignInBtn = [ UIButton buttonWithType:UIButtonTypeRoundedRect ];
	[SignInBtn setFrame:CGRectMake(240, 7, 60, 20) ];
	[SignInBtn setTitle:@"Sign In"  forState:UIControlStateNormal ];
//	[SignInBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal ];
	[SignInBtn setBackgroundColor:[UIColor orangeColor ]];
	[SignInBtn addTarget:self action:@selector(LoginBtnPressed) forControlEvents:UIControlEventTouchUpInside ];
	
	
	SignOutBtn = [ UIButton buttonWithType:UIButtonTypeRoundedRect ];
	[SignOutBtn setFrame:CGRectMake(240, 7, 60, 20) ];
	[SignOutBtn setTitle:@"SignOut"  forState:UIControlStateNormal ];
//	[SignOutBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal ];
	[SignOutBtn setBackgroundColor:[UIColor orangeColor ]];
	[SignOutBtn addTarget:self action:@selector(SignOutPressed) forControlEvents:UIControlEventTouchUpInside ];
	
	//create account 
	
	CreateAccBtn = [ UIButton buttonWithType:UIButtonTypeRoundedRect ];
	[CreateAccBtn setFrame:CGRectMake(190, 30, 120,20) ];
	[CreateAccBtn setTitle:@"Create Account"  forState:UIControlStateNormal ];
	[CreateAccBtn setBackgroundColor:[UIColor orangeColor ]];
	[CreateAccBtn addTarget:self action:@selector(CrAccBtnPressed) forControlEvents:UIControlEventTouchUpInside ];
	[self.view addSubview: CreateAccBtn ];
	
	objAppDelegate = (GoPoGoAppDelegate*)[[UIApplication sharedApplication] delegate];

	if(objAppDelegate.isLogin == FALSE)
	{
	   [self.view addSubview: SignInBtn ];
	}
    else 
	{
		NSString* mystr= [[NSUserDefaults standardUserDefaults] objectForKey:@"keyUserEmailString" ]; 
		NSLog(@"email on main view is :%@",mystr);
		UILabel* emailLabel = [[ UILabel alloc] initWithFrame:CGRectMake(70, 10, 150, 15)];
		emailLabel.font= [UIFont boldSystemFontOfSize:12.5];
		emailLabel.text = mystr;
		[self.view addSubview:emailLabel ];
		[self.view addSubview:SignOutBtn];
	}

	
	UIImage *photoImage;
	cx = 0;
	photoImage = [ UIImage imageNamed: @"right-arrow.png"];
	
	btn_right = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[btn_right setFrame : CGRectMake(290, 260, photoImage.size.width, photoImage.size.height)]; // position in the parent view and set the size of the button
	[btn_right addTarget:self action:@selector(scrollRight:) forControlEvents:UIControlEventTouchUpInside];
	[btn_right  setBackgroundImage:[ UIImage imageNamed: @"right-arrow.png"] forState:(UIControlState) normal ]; 
	[self.view addSubview:btn_right];
	
	
	
	UIImage *photoImage1;
	photoImage1 = [ UIImage imageNamed: @"left-arrow.png"];
	
	btn_left = [UIButton buttonWithType:UIButtonTypeCustom];
	btn_left.frame = CGRectMake(5, 260, photoImage1.size.width, photoImage1.size.height); // position in the parent view and set the size of the button
	[btn_left addTarget:self action:@selector(scrollLeft:) forControlEvents:UIControlEventTouchUpInside];
	[btn_left  setBackgroundImage:[ UIImage imageNamed: @"left-arrow.png"] forState:(UIControlState) normal ]; 
	[self.view addSubview:btn_left];
	
	/////
	
	scrollView1=[[UIScrollView alloc]initWithFrame:CGRectMake(30, 120,255, 250)];
	scrollView1.delegate = self;
	
	scrollView1.backgroundColor=[UIColor whiteColor];
	[scrollView1 setCanCancelContentTouches:NO];
	
	scrollView1.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	scrollView1.clipsToBounds = YES;
	scrollView1.scrollEnabled = YES;
	///	scrollView1.pagingEnabled = YES;
	
	
	[self.view addSubview:scrollView1];
	
	
	
	//this is the code for scrolling images then see the right n left button click code	
	theURLArray = [NSArray arrayWithObjects:
				   @"http://mygopogo.com/themes/default/images/thum1.jpg",
				   @"http://mygopogo.com/themes/default/images/thum2.jpg",
				   @"http://mygopogo.com/themes/default/images/thum3.jpg",
				   @"http://mygopogo.com/themes/default/images/thum2.jpg",
				   @"http://mygopogo.com/themes/default/images/thum3.jpg",
				   nil];	
	nImages = [[ self theURLArray] count];
	
	for(int i=0;i<=nImages-1;i++)
	{
		NSURL * imageURL = [NSURL URLWithString:[theURLArray objectAtIndex:i]];	
		NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
		UIImage * image = [UIImage imageWithData:imageData];	
		if (image == nil)
		{
			break;
		}
		
		imageView = [[UIImageView alloc] initWithImage:image];
		
		rect = imageView.frame;
		rect.size.height = image.size.height;
		rect.size.width = image.size.width;
		
		rect.origin.x = ((scrollView1.frame.size.width - image.size.width) / 22) + cx;
		rect.origin.y = ((scrollView1.frame.size.height - image.size.height) / 2); //10 if u want lilbit above in height
		
		imageView.frame = rect;
		
		
		[scrollView1 addSubview:imageView];
		
		[imageView release];
		
		//// label for text above images.
		
		rect1.size.height = 16;
		rect1.size.width = 113;
		rect1.origin.x = rect.origin.x;
		rect1.origin.y = rect.origin.y - 20;
		
		UILabel *TitleLbl1 = [[UILabel alloc]initWithFrame:CGRectZero];// CGRectMake(5,30,113,16)];
		TitleLbl1.text = @"Bily idol's day in LA";
		TitleLbl1.font = [UIFont italicSystemFontOfSize:12.5];
		TitleLbl1.frame = rect1;
		[TitleLbl1 setBackgroundColor:[UIColor clearColor]];
		[scrollView1 addSubview:TitleLbl1];
		[TitleLbl1 release];
		
		//// button below image
		
		UIImage *DoItImage;
		DoItImage = [ UIImage imageNamed: @"do-it-button.png"];
		
		rect2.size.height = DoItImage.size.height;
		rect2.size.width = DoItImage.size.width;
		rect2.origin.x = rect.origin.x;
		rect2.origin.y = rect.origin.y + 155;
		
		UIButton *DoItButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[DoItButton setFrame:rect2];/// position in the parent view and set the size of the button
		///	[rButton addTarget:self action:@selector(scrollLeft:) forControlEvents:UIControlEventTouchUpInside];
		[DoItButton  setBackgroundImage:[ UIImage imageNamed: @"do-it-button.png"] forState:(UIControlState) normal ]; 
		[scrollView1 addSubview:DoItButton];
		
		
		//UIButton *rButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
		//			[rButton setTitle:@"Do it" forState : UIControlStateNormal];
		//			[rButton setFrame:rect2];//CGRectMake(7, 210, 112, 25)];
		//			[scrollView1 addSubview:rButton];
		
		
		cx += scrollView1.frame.size.width-120; 
		
		//NSLog(@"cx  for i= %d \n",cx);
		///	cx += scrollView1.frame.size.width;
	}
	[scrollView1 setContentSize:CGSizeMake(cx, [scrollView1 bounds].size.height)];
	
	//scrollView1.contentSize = CGSizeMake(scrollView1.frame.size.width * [img_array count], scrollView1.frame.size.height);


}

-(void) LoginBtnPressed
{
	printf("\n\n LoginBtnPressed ");

	
	LoginController* loginController = [[ LoginController alloc] init];
	[self.navigationController pushViewController:loginController animated:YES]; 
	[loginController release];
	///[self.view addSubview:loginController.view ];
	
}	

-(void) CrAccBtnPressed
{
	SignUpController* objSignUpCtrller = [[SignUpController alloc]init];
	[self.navigationController pushViewController:objSignUpCtrller animated:YES];
	[objSignUpCtrller release];
	
}
-(void) SignOutPressed
{
 printf("\n SignOut pressed");
	///[self dismissModalViewControllerAnimated:YES];
	///
	//[self.usersession logout];
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

-(void)scrollRight:(UIButton*)sender
{ 
	btn_left.enabled = YES;	
    if(pos< (nImages/2))
	{
		pos +=1;
		CGRect frame1 = scrollView1.frame;
		frame1.origin.x = frame1.size.width *pos;
		frame1.origin.y = 0;
		NSLog(@"frame1.origin.x: %i",frame1.origin.x);
		
		[scrollView1 scrollRectToVisible:frame1 animated:YES];
		///    [scrollView1 scrollRectToVisible:CGRectMake(pos*scrollView1.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:YES];
        NSLog(@"Position: %i",pos);
    }
	else {
		
		btn_right.enabled = NO;	
	}
	
}
-(void)scrollLeft:(UIButton*)sender
{ 
	
	btn_right.enabled = YES;
    if(pos>0)
	{
		pos -=1;
		CGRect frame1 = scrollView1.frame;
		frame1.origin.x = frame1.size.width *pos;
		frame1.origin.y = 0;
		[scrollView1 scrollRectToVisible:frame1 animated:YES];
		///   [scrollView1 scrollRectToVisible:CGRectMake(pos*scrollView1.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:YES];
        NSLog(@"Position: %i",pos);
    }
	else {
		btn_left.enabled = NO;
	}
	
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code.
 }
 */
#pragma mark -
#pragma mark UIScrollViewDelegate stuff
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
	
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView 
{
	
}
/// calling webservice methods

/*
-(void) SignUpBttonPressed
{
	printf("sign up pressed");
	
	self.lastText = emailText.text;
    [translations addObject:_lastText];
   /// textView.text = _lastText;  
	NSString* pswdStr = paswdText.text;
	NSLog(@"pswdstr is : %@", pswdStr);
	
	NSString* RepswdStr = repeatPswdTxt.text;
	NSLog(@"RepswdStr is : %@", RepswdStr);
	
	if([pswdStr isEqualToString:RepswdStr] )
	{
		printf("\n\n matching pswd");
	}
	else {
		UIAlertView * Alert=[[UIAlertView alloc] initWithTitle:@"Password Error" message:@"Please enter same password." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil ];
		[Alert show];
		[Alert release];
		return;
	}
	
	/// code for email validation
	
	NSArray *validateAtSymbol = [emailText.text componentsSeparatedByString:@"@"];
    NSArray *validateDotSymbol = [emailText.text componentsSeparatedByString:@"."];
    if(([validateAtSymbol count] != 2) || ([validateDotSymbol count] < 2)) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"Invalid EMail Address" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alertView show];
        [alertView release];
      //  whereClicked = 1;
        return;
    }
	
	// Break if we exceed limit
    if (translations.count > 50) {
    ///    button.enabled = YES;
        return;
    }
    
    responseData = [[NSMutableData data] retain];
    BOOL translateToEnglish = ([translations count] % 2 == 0);
    
    // Bail if we have a match
    if (!translateToEnglish && [translations count] >= 3) {
        NSString *oldString = [translations objectAtIndex:[translations count] - 3];
        if ([oldString caseInsensitiveCompare:_lastText] == NSOrderedSame) {
        ///    button.enabled = YES;
            return;
        }
    }
    
    NSString *langString;
    if (translateToEnglish) {
        langString = @"ja|en";        
    } else {
        langString = @"en|ja";
    }
    
    NSString *textEscaped = [_lastText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];    NSString *langStringEscaped = [langString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *url = [NSString stringWithFormat:@"http://ajax.googleapis.com/ajax/services/language/translate?q=%@&v=1.0&langpair=%@",
                     textEscaped, langStringEscaped];
	printf("url with data=", self.lastText);
	NSLog(@"url = %@",url);
	//	NSLog(url);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	/// this is for test only ///
	
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}





/*
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {		
	[connection release];
	
	NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	[responseData release];
	
	NSError *error;
	SBJSON *json = [[SBJSON new] autorelease];
	NSArray *luckyNumbers = [json objectWithString:responseString error:&error];
	[responseString release];	
	
	if (luckyNumbers == nil)
		label.text = [NSString stringWithFormat:@"JSON parsing failed: %@", [error localizedDescription]];
	else {		
		NSMutableString *text = [NSMutableString stringWithString:@"Lucky numbers:\n"];
		
		for (int i = 0; i < [luckyNumbers count]; i++) 
			[text appendFormat:@"%@\n", [luckyNumbers objectAtIndex:i]];
		
		label.text =  text;
	}
}

*/
- (void)dealloc {
    [super dealloc];
	[scrollView1 release];
	[theURLArray release];
}

- (void)session:(FBSession*)session didLogin:(FBUID)uid {
	printf("\n main ctrl session didlogin");
	self.usersession =session;
    NSLog(@"User with id %lld logged in.", uid);
	[self getFacebookName];
	
}


- (void)getFacebookName {
	
	NSString* fql = [NSString stringWithFormat:
					 @"select uid,name,email from user where uid == %lld", self.usersession.uid];
	NSDictionary* params = [NSDictionary dictionaryWithObject:fql forKey:@"query"];
	[[FBRequest requestWithDelegate:self] call:@"facebook.fql.query" params:params];
	//	self.post=YES;
}

- (void)request:(FBRequest*)request didLoad:(id)result {
	printf("\n\n main request");
	if ([request.method isEqualToString:@"facebook.fql.query"]) {
		NSArray* users = result;
		NSDictionary* user = [users objectAtIndex:0];
		NSString* name = [user objectForKey:@"email"];
		
		NSLog(@" username is %@",name);
		///	self.username = name;		
		//
	//	userlabel.text=name;
		//
		//if (self.post) {
		//			[self postToWall];
		//			self.post = NO;
		//		}
		
		//FBPermissionDialog* dialog = [[[FBPermissionDialog alloc] init] autorelease];
		//		dialog.delegate = self;
		//		dialog.permission = @"email";
		//		[dialog show];  
	}
}


@end
