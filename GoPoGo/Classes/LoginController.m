    //
//  LoginController.m
//  GoPoGo
//
//  Created by User on 1/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginController.h"
#import "GoPoGoAppDelegate.h"
#import "SignUpController.h"
#import "ForgotPswdController.h"
#import "GoPoGoViewController.h"
#import "HomeScreenViewController.h"
#import "FBPermissionDialog.h"

@implementation LoginController

#define _APP_KEY @"8fb6e9bc77b4892da086cc9aba0d5e22"
#define _SECRET_KEY @"f93cb9d0e961042bcbb1cebfbe16332f"


@synthesize webData,soapResults,xmlParser,objAppDelegate;
@synthesize loginButton;
@synthesize usersession;
@synthesize username;
@synthesize  _session;



-(id) init
{
 if(self = [super init])
 {
	//self.view.frame = CGRectMake(0, 0, 320, 480);
 } 
	return self;
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
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
- (void)viewDidLoad {
	
//	printf("\n login viewdidLoad");
	
    [super viewDidLoad];
	
	objAppDelegate = (GoPoGoAppDelegate*) [[UIApplication sharedApplication]delegate];
			
	if(objAppDelegate._session.isConnected)
	{
		HomeScreenViewController* objHomeCtrlr = [[HomeScreenViewController alloc]init];
		[self.view addSubview:objHomeCtrlr.view];
		
	}
	else {

	emailResFlag = FALSE;
	
	backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 320, 480)];
	backgroundView .image = [UIImage imageNamed:@"sign-in-bg.png"];
	
	[self.view addSubview:backgroundView];
			
	emailText = [[ UITextField alloc ] initWithFrame : CGRectMake(30, 109, 255, 30)];
	
	[ emailText setTextColor:[UIColor blackColor]];
	[ emailText setFont:[UIFont systemFontOfSize:16]];
	[ emailText setDelegate:self];
	[ emailText setAutocorrectionType: UITextAutocorrectionTypeNo];
	[ emailText setPlaceholder:@"Email"];
	
	emailText.keyboardType = UIKeyboardTypeDefault;
	emailText.textAlignment = UITextAlignmentLeft;
	emailText.returnKeyType = UIReturnKeyDone;
	[ emailText setClipsToBounds: TRUE ] ;
	[ self.view addSubview: emailText ] ;
	emailText.text = @"";
	
	paswdText = [ [ UITextField alloc ] initWithFrame:CGRectMake(30, 157, 255, 30) ];
	[paswdText setTextColor:[UIColor blackColor]];
	[paswdText setFont:[UIFont systemFontOfSize:16]];
	[paswdText setDelegate:self];
	[paswdText setAutocorrectionType:UITextAutocorrectionTypeNo];
	[paswdText setPlaceholder:@"Password"];
	
	paswdText.secureTextEntry = YES;
	paswdText.textAlignment = UITextAlignmentLeft;
	paswdText.returnKeyType = UIReturnKeyDone;
	
	[paswdText setClipsToBounds:TRUE ];
	[self.view addSubview:paswdText];
	paswdText.text = @"";		
	
	UIImage *photoImage;
	photoImage = [ UIImage imageNamed: @"submit-btn.png"];
		
	SignInBtton = [ UIButton buttonWithType:UIButtonTypeCustom];
	SignInBtton.frame = CGRectMake(80, 235, photoImage.size.width, photoImage.size.height); // position in the parent view and set the size of the button

	[SignInBtton  setBackgroundImage:[ UIImage imageNamed: @"submit-btn.png"] forState:(UIControlState) normal ]; 
	[SignInBtton addTarget:self action:@selector(SignInBttonPressed) forControlEvents:UIControlEventTouchUpInside ];

	[self.view addSubview: SignInBtton ]; 
	
	[photoImage release];
	
	
	UIImage *photoImage1;
	photoImage1 = [ UIImage imageNamed: @"cancel-btn.png"];
	
	CancelBtton = [ UIButton buttonWithType:UIButtonTypeCustom];
	CancelBtton.frame = CGRectMake(160, 235, photoImage1.size.width, photoImage1.size.height); // position in the parent view and set the size of the button
	
	[CancelBtton  setBackgroundImage:[ UIImage imageNamed: @"cancel-btn.png"] forState:(UIControlState) normal ]; 
	[CancelBtton addTarget:self action:@selector(cancelBttonPressed) forControlEvents:UIControlEventTouchUpInside ];
	
	[self.view addSubview: CancelBtton ];
	
	[photoImage1 release];
	
	UIImage *photoImage3;
	photoImage3 = [ UIImage imageNamed: @"password-btn.png"];
	
	passwdBtton = [ UIButton buttonWithType:UIButtonTypeCustom];
	passwdBtton.frame = CGRectMake(96, 205, photoImage3.size.width, photoImage3.size.height); // position in the parent view and set the size of the button
	
	[passwdBtton  setBackgroundImage:[ UIImage imageNamed: @"password-btn.png"] forState:(UIControlState) normal ]; 
	[passwdBtton addTarget:self action:@selector(forgotPasswdClicked) forControlEvents:UIControlEventTouchUpInside ];
	
	[self.view addSubview: passwdBtton ]; 
	
	[photoImage3 release];
	
	
	UIImage *photoImage4;
	photoImage4 = [ UIImage imageNamed: @"create-account-btn.png"];
	
	createAccBtton = [ UIButton buttonWithType:UIButtonTypeCustom];
	createAccBtton.frame = CGRectMake(192, 205, photoImage4.size.width, photoImage4.size.height); // position in the parent view and set the size of the button
	
	[createAccBtton  setBackgroundImage:[ UIImage imageNamed: @"create-account-btn.png"] forState:(UIControlState) normal ]; 
	[createAccBtton addTarget:self action:@selector(createAccountClicked) forControlEvents:UIControlEventTouchUpInside ];
	
	[self.view addSubview: createAccBtton ]; 
	
	[photoImage4 release];
	
	frameFgtPswd = CGRectMake(6, 201, 185, 25);
	CrAccLabel = [[UILabel alloc]initWithFrame:frameFgtPswd] ;
	CrAccLabel.text=@"Forgot your                or";
	[CrAccLabel setBackgroundColor:[UIColor clearColor]];
	[CrAccLabel setTextColor:[UIColor whiteColor]];
	[CrAccLabel setFont:[UIFont fontWithName:@"Ariel" size:16] ];
	[self.view addSubview:CrAccLabel];
	
	frameQue= CGRectMake(305, 201, 10, 25);
	CrQueLabel = [[UILabel alloc]initWithFrame:frameQue] ;
	CrQueLabel.text=@"?";
	[CrQueLabel setBackgroundColor:[UIColor clearColor]];
	[CrQueLabel setTextColor:[UIColor whiteColor]];
	[CrQueLabel setFont:[UIFont fontWithName:@"Ariel" size:16] ];
	[self.view addSubview:CrQueLabel];
	
	//// facebook login button
	
	objAppDelegate  =(GoPoGoAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	if (objAppDelegate._session == nil){
		objAppDelegate._session = [FBSession sessionForApplication:_APP_KEY 
														 secret:_SECRET_KEY delegate:self];
	}
			
	loginButton = [[[FBLoginButton alloc] init] autorelease];
	loginButton.frame = CGRectMake(85,290,150,25);
	
	[self.view addSubview:loginButton];
	
	} ///end of else loop
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
	[emailText resignFirstResponder];
	[paswdText resignFirstResponder];
	
	NSString* emailTxt = emailText.text;
	
	NSUserDefaults *userName = [NSUserDefaults standardUserDefaults ];
	//saving username
	[userName setObject:emailTxt forKey:@"keyUserNameString" ];
	
	return YES;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(void)cancelBttonPressed
{
//	printf("cancel in  view");
	emailText.text = @"";
	paswdText.text = @"";
	
	[emailText resignFirstResponder];
	[paswdText resignFirstResponder];
}


-(void) SignInBttonPressed
{
	[self killFacebookSession];
	//printf("\n\n SignInBttonPressed");
	
	
	NSString* pswdStr = paswdText.text;
	NSString* emailStr = emailText.text;
	
	if([emailStr isEqualToString:@""])
	{
		printf("\n email is blank");
		UIAlertView * Alert=[[UIAlertView alloc] initWithTitle:@"Blank field Error" message:@"email can not be blank" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil ];
		[Alert show];
		[Alert release];
		return;							 
		
	}
	
	else if(([pswdStr isEqualToString:@""] )  )
	{
		UIAlertView * Alert=[[UIAlertView alloc] initWithTitle:@"Blank field Error" message:@"password can not be blank" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil ];
		[Alert show];
		[Alert release];
		return;
	}
	
	
	NSString* mystr= [[NSUserDefaults standardUserDefaults] objectForKey:@"keyUserNameString" ]; 
	
	// email validation code starts
	NSArray *validateAtSymbol = [emailText.text componentsSeparatedByString:@"@"];
    NSArray *validateDotSymbol = [emailText.text componentsSeparatedByString:@"."];
    if(([validateAtSymbol count] != 2) || ([validateDotSymbol count] < 2)) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"Invalid EMail Address" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alertView show];
        [alertView release];
		//  whereClicked = 1;
        return;
    }
	
	// email validation code ends
	recordResults = FALSE;
	emailResFlag = FALSE;
	
	NSURL *url = [NSURL URLWithString:@"http://pirs.mygopogo.com/WebService/rest/api?method=login"];
	
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	
	NSString *reqMessage = [NSString stringWithFormat:
							 @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
							 "<WS_User generator=\"zend\" version=\"1.0\">\n"
							 "<login>\n"
							 "<email>%@</email>\n"
							 "<passwd>%@</passwd>\n"	
							 "</login>\n"
							 "</WS_User>\n",emailText.text,paswdText.text
							 ];
	
	NSLog(@"reqMessage is :%@",reqMessage);
	
	NSString *msgLength = [NSString stringWithFormat:@"%d",[reqMessage length]];	
	///	[theRequest addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	///	[theRequest addValue:@"http://mygopogo.com/webservice/soap" forHTTPHeaderField:@"SOAPAction"];
	
	[theRequest setURL:url];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setValue:msgLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	
	//[theRequest addValue:msgLength forHTTPHeaderField:@"Content-Length"];
	
	[theRequest setHTTPBody: [reqMessage dataUsingEncoding:NSUTF8StringEncoding]];
	
	
	
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];	
	if(theConnection)
	{
		webData = [[NSMutableData data] retain];
	}
	
	NSLog(@"theRequest is: %@",theRequest);
	
}
-(void) createAccountClicked
{
	//printf("\n cr acc is clicked");

	SignUpController* objSignUpCtrller = [[SignUpController alloc]init];
	[self.navigationController pushViewController:objSignUpCtrller animated:YES];
	[objSignUpCtrller release];
}

-(void) forgotPasswdClicked
{
	ForgotPswdController* objFgtPswdCtrller = [[ForgotPswdController alloc] init];
	[self.navigationController pushViewController:objFgtPswdCtrller animated:YES];
	[objFgtPswdCtrller release];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch* touch = [touches anyObject];
	if((CGRectContainsPoint(frameCrAcc, [touch locationInView:self.view ])))
	{
		//printf("\n cr acc is clicked");
			
		SignUpController* objSignUpCtrller = [[SignUpController alloc]init];
		[self.navigationController pushViewController:objSignUpCtrller animated:YES];
		[objSignUpCtrller release];
	
	}
	
	if((CGRectContainsPoint(frameFgtPswd, [touch locationInView:self.view ])))
	{
		//printf("\n\n fgt pswd clicked");
		
	ForgotPswdController* objFgtPswdCtrller = [[ForgotPswdController alloc] init];
		[self.navigationController pushViewController:objFgtPswdCtrller animated:YES];
		[objFgtPswdCtrller release];
		
	
	}
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

-(void) viewWillAppear:(BOOL)animated
{
	//printf("\n view will appear");
}
- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[backgroundView release];
	[CrAccLabel release];
	[CrQueLabel release];
	[SignInBtton release];
	
	[emailText release];
	[paswdText release];
	[xmlParser release];
	
	[loginButton release];
	[usersession release];
	[username release];
}

//// function of NSURLConnection


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
		printf("\n\nDidReceiveResponse");
	[webData setLength: 0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
		printf("\n\nDidReceiveData");
	[webData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"ERROR with theConenction");
	[connection release];
	[webData release];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	printf("\n\n connectionDidFinishLoading");
	NSLog(@"DONE. Received Bytes: %d", [webData length]);
	NSString *theXML = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
	NSLog(@"response xml is :%@",theXML);
	[theXML release];
	
	if( xmlParser )
	{
		[xmlParser release];
	}
	
	xmlParser = [[NSXMLParser alloc] initWithData: webData];
	[xmlParser setDelegate: self];
	[xmlParser setShouldResolveExternalEntities: YES];
	[xmlParser parse];
	
	[connection release];
	[webData release];
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
		printf("\n\n didStartElement");
	if( [elementName isEqualToString:@"response"]) // for GoPoGo we will have "sign-up"
	{
		if(!soapResults)
		{
			soapResults = [[NSMutableString alloc] init];
		}
		recordResults = TRUE;
		statusFlag = TRUE;
	}
	
	if( [elementName isEqualToString:@"email"]) // for GoPoGo we will have "sign-up"
	{
		if(!soapResults)
		{
			soapResults = [[NSMutableString alloc] init];
		}
		emailResFlag = TRUE;
		statusFlag = FALSE;
	}
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	printf("\n\n foundCharacters");
	[soapResults setString:@""];

	 NSLog(@"foundchar soap result is: %@",soapResults);
	if(statusFlag)// recordResults )
	{
		[soapResults setString:@""];
		printf("\n stutus flag found");
		[soapResults appendString: string];
	}
	
	if( emailResFlag )
	{
		[soapResults setString:@""];
		printf("\n email flag found");
		[soapResults appendString: string];
	}
	
	if([soapResults isEqualToString:@"success"])
	{ 
		printf("\n if success found then clear");
	     [soapResults setString:@""];
	}
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	printf("\n\n didEndElement");
	 NSLog(@"result is%@",soapResults); 
	if( [elementName isEqualToString:@"response"])
	{
		//you will get response from server here
		printf("\n if response tag");
			
		if([soapResults isEqualToString:@"1"])
		{
        NSLog(@"if response 1 then result is%@",soapResults);        
      	objAppDelegate = (GoPoGoAppDelegate*)[[UIApplication sharedApplication] delegate];

		objAppDelegate.isLogin = TRUE;
		}
		else if([soapResults isEqualToString:@"0"])
		{
			UIAlertView *alert = [[UIAlertView alloc] 
								  initWithTitle:@"Your Email / Password seems incorrect!!!" 
								  
								  message:@"Please Try again" 
								  delegate:self  
								  cancelButtonTitle:@"OK" 
								  otherButtonTitles:nil];
			[alert show];
			[alert release];
			
			/// call here same view 
			[self cancelBttonPressed];
		}

		[soapResults setString:@""];
        recordResults = FALSE; 
		statusFlag = FALSE;
		
			
		
	}
	
	if( [elementName isEqualToString:@"email"]) // for GoPoGo we will have "sign-up"
	{
		/// if get success then save your email
	
		emailRes = [NSString stringWithString:soapResults];
		
		
		NSUserDefaults *userName = [NSUserDefaults standardUserDefaults ];
		//saving username
		[userName setObject:emailRes forKey:@"keyUserEmailString" ];
		objAppDelegate = (GoPoGoAppDelegate*)[[UIApplication sharedApplication] delegate];
		
		objAppDelegate.isLogin = TRUE;
		
		
		NSLog(@" email is:%@", emailRes);
		[soapResults setString:@""];
		emailResFlag = TRUE;
		
	}
	
	if([elementName isEqualToString:@"WS_User"])
		{
			printf("\n this is last tag ws_user");
			if(emailResFlag)
			{
				printf("\n if email flag is set");
				[self callMainView];
			}
		}
}

-(void) callMainView
{
	

	printf("\n in callMainView");
	
	objAppDelegate = (GoPoGoAppDelegate*) [[UIApplication sharedApplication]delegate];
	if(objAppDelegate._session.isConnected)
	{
		
    [objAppDelegate ShowMainView];
	}
	
	else 
	{
		
		HomeScreenViewController* objGoPoGoCtrlr = [[HomeScreenViewController alloc]initWithNibName:nil bundle:[NSBundle mainBundle]];
		[self.navigationController pushViewController:objGoPoGoCtrlr animated:YES]; 
		[objGoPoGoCtrlr release];
	}
	printf("\n end of  callMainView");
		
}

//// facebook related functions
- (void)session:(FBSession*)session didLogin:(FBUID)uid 
{
	printf("\n login ctrl session didlogin");
	self.usersession =session;
	fbookUID = uid;
    NSLog(@"User with  fbookid %lld logged in.", fbookUID);
	 NSLog(@"User with id %lld logged in.", uid);
	[self getFacebookName];
}


- (void)getFacebookName {
	
	NSString* fql = [NSString stringWithFormat:
					 @"select uid,name,email from user where uid == %lld", self.usersession.uid];
	NSDictionary* params = [NSDictionary dictionaryWithObject:fql forKey:@"query"];
	[[FBRequest requestWithDelegate:self] call:@"facebook.fql.query" params:params];
	

}

- (void)request:(FBRequest*)request didLoad:(id)result {
	
	printf("\n\n loginctrl request");
	if ([request.method isEqualToString:@"facebook.fql.query"]) {
		NSArray* users = result;
		NSDictionary* user = [users objectAtIndex:0];
		emailFB = [user objectForKey:@"email"];
	
		NSLog(@" username is %@",emailFB);
		NSUserDefaults *useremail = [NSUserDefaults standardUserDefaults ];
		//saving username here
		[useremail setObject:emailFB forKey:@"FBEmailString" ];
		
	}
	NSString* mystr= [[NSUserDefaults standardUserDefaults] objectForKey:@"FBEmailString" ]; 
	
	if (mystr == nil)
	{
		printf("\n null value");
	}
	else {
		printf("\n email has value");
		[self fbookLoginCalled];
	}	
}

-(void) fbookLoginCalled
{
	printf("\n fbooklogin called ");
	NSURL *url = [NSURL URLWithString:@"http://pirs.mygopogo.com/WebService/rest/api?method=fblogin"];
	
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	
	NSString *reqMessage = [NSString stringWithFormat:
							 @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
							 "<WS_User generator=\"zend\" version=\"1.0\">\n"
							 "<fblogin>\n"
							 "<fbemail>%@</fbemail>\n"
							 "<fbuid>%lld</fbuid>\n"	
							 "</fblogin>\n"
							 "</WS_User>\n",emailFB,fbookUID
							 ];
	
	NSLog(@"reqMessage is :%@",reqMessage);
	
	NSString *msgLength = [NSString stringWithFormat:@"%d",[reqMessage length]];	
	
	[theRequest setURL:url];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setValue:msgLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	
	
	[theRequest setHTTPBody: [reqMessage dataUsingEncoding:NSUTF8StringEncoding]];
	
	
	
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];	
	if(theConnection)
	{
		webData = [[NSMutableData data] retain];
	}
	
	NSLog(@"theRequest is: %@",theRequest);
	
}

-(void) killFacebookSession
{
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
		
	
		
	}
	
}






@end
