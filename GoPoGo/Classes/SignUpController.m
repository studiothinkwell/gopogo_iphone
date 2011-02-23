    //
//  SignUpController.m
//  GoPoGo
//
//  Created by User on 1/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SignUpController.h"
#import "LoginController.h"
#import "GoPoGoAppDelegate.h"
#import "GoPoGoViewController.h"

@implementation SignUpController


#define _APP_KEY @"8fb6e9bc77b4892da086cc9aba0d5e22"
#define _SECRET_KEY @"f93cb9d0e961042bcbb1cebfbe16332f"
#define MAX_LENGTH 16
#define MIN_LENGTH 6


@synthesize webData,soapResults,xmlParser;
@synthesize objAppDelegate;
@synthesize loginButton;
@synthesize usersession;
@synthesize objActivityView , activationAlert;

-(id) init
{
   if(self = [super init ])
   {
	   activationAlert = [[UIAlertView alloc]
						  initWithTitle:@"An activation link has been sent to your email Id" 
						  message:@"Do you want to activate your account now?"  
						  delegate:self 
						  cancelButtonTitle:@"No" 
						  otherButtonTitles: @"Yes", nil];
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
    [super viewDidLoad];
	
	backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	backgroundView.image = [UIImage imageNamed:@"create-account-bg.png"];
	[self.view addSubview:backgroundView];
	
	
	
	emailText = [[ UITextField alloc ] initWithFrame : CGRectMake(30, 110, 255, 30)];
	
	
//	[ emailText setBorderStyle:UITextBorderStyleLine];// BorderStyleNone];
	[ emailText setTextColor:[UIColor blackColor]];
	[ emailText setFont:[UIFont systemFontOfSize:16]];
	[ emailText setDelegate:self];
	[ emailText setAutocorrectionType: UITextAutocorrectionTypeNo];
	[ emailText setPlaceholder:@" Email Address "];
	
	emailText.keyboardType = UIKeyboardTypeDefault;
	emailText.textAlignment = UITextAlignmentLeft;//Center ;
	emailText.returnKeyType = UIReturnKeyDone  ;
	[ emailText setClipsToBounds: TRUE ] ;
	[ self.view addSubview: emailText ] ;
	emailText.text = @"";
	
	
	paswdText = [ [ UITextField alloc ] initWithFrame:CGRectMake(30, 158, 255, 30) ];
//	[paswdText setBorderStyle:UITextBorderStyleLine];
	[paswdText setTextColor:[UIColor blackColor]];
	[paswdText setFont:[UIFont systemFontOfSize:16]];
	[paswdText setDelegate:self];
	[paswdText setAutocorrectionType:UITextAutocorrectionTypeNo];
	[paswdText setPlaceholder:@" Password "];
	
	paswdText.secureTextEntry = YES;
	paswdText.textAlignment = UITextAlignmentLeft;
	paswdText.returnKeyType = UIReturnKeyDone;
	
	[paswdText setClipsToBounds:TRUE ];
	[self.view addSubview:paswdText];
	paswdText.text=@"";
	
	
	repeatPswdTxt = [ [ UITextField alloc ] initWithFrame:CGRectMake(30, 206, 255, 30) ];
	//[repeatPswdTxt setBorderStyle:UITextBorderStyleLine];
	[repeatPswdTxt setTextColor:[UIColor blackColor]];
	[repeatPswdTxt setFont:[UIFont systemFontOfSize:16]];
	[repeatPswdTxt setDelegate:self];
	[repeatPswdTxt setAutocorrectionType:UITextAutocorrectionTypeNo];
	[repeatPswdTxt setPlaceholder:@" Re-Type Password "];
	
	repeatPswdTxt.secureTextEntry = YES;
	repeatPswdTxt.textAlignment = UITextAlignmentLeft;
	repeatPswdTxt.returnKeyType = UIReturnKeyDone;
	
	[repeatPswdTxt setClipsToBounds:TRUE ];
	[self.view addSubview:repeatPswdTxt];
	repeatPswdTxt.text=@"";

	frameCrAccLbl = CGRectMake(27, 246, 253, 25);
	UILabel* CrAccLabel = [[UILabel alloc]initWithFrame:frameCrAccLbl] ;
	CrAccLabel.text=@"Already have an account?";
	[CrAccLabel setBackgroundColor:[UIColor clearColor]];
	[CrAccLabel setTextColor:[UIColor whiteColor]];
	[CrAccLabel setFont:[UIFont fontWithName:@"Ariel" size:16] ];
	[self.view addSubview:CrAccLabel];
	
	UIImage *photoImage;
	photoImage = [ UIImage imageNamed: @"submit-btn.png"];
	
	SignUpBtton = [ UIButton buttonWithType:UIButtonTypeCustom];
	SignUpBtton.frame = CGRectMake(80, 275, photoImage.size.width, photoImage.size.height); // position in the parent view and set the size of the button
	
	[SignUpBtton  setBackgroundImage:[ UIImage imageNamed: @"submit-btn.png"] forState:(UIControlState) normal ]; 
	[SignUpBtton addTarget:self action:@selector(SignUpBtnPressed) forControlEvents:UIControlEventTouchUpInside ];
	
	[self.view addSubview: SignUpBtton ]; 
	
	[photoImage release];
	
	UIImage *photoImage1;
	photoImage1 = [ UIImage imageNamed: @"cancel.png"];
	
	CancelBtton = [ UIButton buttonWithType:UIButtonTypeCustom];
	CancelBtton.frame = CGRectMake(160, 275, photoImage1.size.width, photoImage1.size.height); // position in the parent view and set the size of the button
	
	[CancelBtton  setBackgroundImage:[ UIImage imageNamed: @"cancel.png"] forState:(UIControlState) normal ]; 
	[CancelBtton addTarget:self action:@selector(cancelBttonPressed) forControlEvents:UIControlEventTouchUpInside ];
	
	[self.view addSubview: CancelBtton ]; 
	
	[photoImage1 release];
	
	
	UIImage *photoImage3;
	photoImage3 = [ UIImage imageNamed: @"login-btn.png"];
	
	LoginBtton = [ UIButton buttonWithType:UIButtonTypeCustom];
	LoginBtton.frame = CGRectMake(234, 251, photoImage3.size.width, photoImage3.size.height); // position in the parent view and set the size of the button
	
	[LoginBtton  setBackgroundImage:[ UIImage imageNamed: @"login-btn.png"] forState:(UIControlState) normal ]; 
	[LoginBtton addTarget:self action:@selector(LoginBtnPressed) forControlEvents:UIControlEventTouchUpInside ];
	
	[self.view addSubview: LoginBtton ]; 
	
	[photoImage3 release];
	
	//// facebook login button
	
	objAppDelegate  =(GoPoGoAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	if (objAppDelegate._session == nil){
		objAppDelegate._session = [FBSession sessionForApplication:_APP_KEY 
															secret:_SECRET_KEY delegate:self];
	}

	
	loginButton = [[[FBLoginButton alloc] init] autorelease];
	loginButton.frame = CGRectMake(85,320,150,25);
	
	[self.view addSubview:loginButton];

}

-(void)cancelBttonPressed
{
	printf("cancel in  view");
	emailText.text = @"";
	paswdText.text = @"";
	repeatPswdTxt.text= @"";
	
	[emailText resignFirstResponder];
	[paswdText resignFirstResponder];
	[paswdText resignFirstResponder];
}
-(void)SignUpBtnPressed
{


	NSString* pswdStr = paswdText.text;

	
	NSString* RepswdStr = repeatPswdTxt.text;

	
	NSString* emailStr = emailText.text;
	
	
	
	if([emailStr isEqualToString:@""]) 
	{
		printf("\n email is blank");
		UIAlertView * Alert=[[UIAlertView alloc] initWithTitle:@"Blank field Error" message:@"email can not be blank" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil ];
		[Alert show];
		[Alert release];
		return;							 
		
	}
	
	else if(([pswdStr isEqualToString:@""] )|| ([RepswdStr isEqualToString:@""])  )
	{
		UIAlertView * Alert=[[UIAlertView alloc] initWithTitle:@"Blank field Error" message:@"password can not be blank" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil ];
		[Alert show];
		[Alert release];
		return;
	}
	
	else if (paswdText.text.length > MAX_LENGTH || paswdText.text.length < MIN_LENGTH ||repeatPswdTxt.text.length > MAX_LENGTH || repeatPswdTxt.text.length < MIN_LENGTH )
	{
		paswdText.text = @"";
		repeatPswdTxt.text= @"";
		
		UIAlertView * Alert=[[UIAlertView alloc] initWithTitle:@"Password not valid" message:@"password length should be between 6-16" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil ];
		[Alert show];
		[Alert release];
		
		
		return;			
		
	}
	else if(![pswdStr isEqualToString:RepswdStr])
	{		
		UIAlertView * Alert=[[UIAlertView alloc] initWithTitle:@"Password Error" message:@"Please enter same password." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil ];
		[Alert show];
		[Alert release];
		return;
	}
	
	// email validation code starts
	NSArray *validateAtSymbol = [emailText.text componentsSeparatedByString:@"@"];
    NSArray *validateDotSymbol = [emailText.text componentsSeparatedByString:@"."];
    if(([validateAtSymbol count] != 2) || ([validateDotSymbol count] < 2)) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"Invalid EMail Address" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alertView show];
        [alertView release];
		
        return;
    }
	
	// email validation code ends
	recordResults = FALSE;
	
	NSURL *url = [NSURL URLWithString:@"http://pirs.mygopogo.com/WebService/rest/api?method=signUp"];
	
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	
	NSString *reqMessage = [NSString stringWithFormat:
							 @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
							 "<WS_User generator=\"zend\" version=\"1.0\">\n"
							 "<singnUp>\n"
							 "<email>%@</email>\n"
							 "<passwd>%@</passwd>\n"
							 "<retypePasswd>%@</retypePasswd>\n"
							 "</singnUp>\n"
							 "</WS_User>\n",emailText.text,paswdText.text,repeatPswdTxt.text
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
	
	///Adding indicator here
	objActivityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle
					   :UIActivityIndicatorViewStyleWhiteLarge];
	objActivityView.frame=CGRectMake(130, 180, 50, 50);
	objActivityView.tag  = 1;
	[self.view addSubview:objActivityView];
	[objActivityView startAnimating];
	
	
}

-(void) LoginBtnPressed
{
	
	LoginController* objloginCtrllr = [[LoginController alloc]init];
	[self.navigationController pushViewController:objloginCtrllr animated:YES];
	[objloginCtrllr release];
	
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
	[emailText resignFirstResponder];
	[paswdText resignFirstResponder];
	[repeatPswdTxt resignFirstResponder];
	return YES;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[SignUpBtton release];
	[LoginBtton release];
	[emailText release];
	[paswdText release];
	[repeatPswdTxt release];
	[xmlParser release];
}

//// function of NSURLConnection


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	//	printf("\n\nDidReceiveResponse");
	[webData setLength: 0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	//	printf("\n\nDidReceiveData");
	[webData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
//	NSLog(@"ERROR with theConenction");
	[objActivityView stopAnimating];
	[connection release];
	[webData release];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	//printf("\n\n connectionDidFinishLoading");
//	NSLog(@"DONE. Received Bytes: %d", [webData length]);
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
	//printf("\n\n didStartElement");
	

	
	if( [elementName isEqualToString:@"response"]) // for GoPoGo we will have "sign-up"
	{
		if(!soapResults)
		{
			soapResults = [[NSMutableString alloc] init];
		}
		recordResults = TRUE;
		statusFlag = TRUE;
	}
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	//printf("\n\n foundCharacters");
	if( recordResults )
	{
		[soapResults appendString: string];
	}
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
//	printf("\n\n didEndElement");
	if( [elementName isEqualToString:@"response"])
	{
		//you will get response from server here
		//---displays the result
			
		if([soapResults isEqualToString:@"1"])
		{
			[objActivityView stopAnimating];
			NSLog(@"didEndelement result is%@",soapResults);        
						
			[activationAlert show];
			[activationAlert release];

			
		}
		else {
			[objActivityView stopAnimating];
			UIAlertView *alert = [[UIAlertView alloc] 
								  initWithTitle:@"Create Account Failed" 
								  
								  message:soapResults 
								  delegate:self  
								  cancelButtonTitle:@"OK" 
								  otherButtonTitles:nil];
			[alert show];
			[alert release];
			//[self callMainView];
		}
		
        [soapResults setString:@""];
        recordResults = FALSE; 
		statusFlag = FALSE;
		
	

	}
	
	//if([elementName isEqualToString:@"WS_User"])
//	{
//		printf("\n this is last tag ws_user");
//		if(emailResFlag)
//		{
//			printf("\n if email flag is set");
//			[self callMainView];
//		}
//	}
	
}

//  pop up view handle
//http://www.iphonedevsdk.com/forum/iphone-sdk-development/2982-2-button-uialertview-button-pressed.html
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// the user clicked one of the OK/Cancel buttons
	
	if(alertView == activationAlert) 
	{
		
		if (buttonIndex == 0)
		{
		//	NSLog(@"cancel");
			[self callMainView];
			
		}
		else
		{
		//	NSLog(@"OK");
			webViewController *web=[[webViewController alloc]init];
			[self.navigationController pushViewController:web animated:YES];
			[web release];
		}
	}
}

-(void) callMainView
{
	///[self.navigationController popViewControllerAnimated:YES];	
	LoginController* objloginCtrlr = [[ LoginController alloc] init];
	[self.navigationController pushViewController:objloginCtrlr animated:YES];
	[objloginCtrlr release];
}
//// facebook related functions

- (void)session:(FBSession*)session didLogin:(FBUID)uid {
	//printf("\n login ctrl session didlogin");
	self.usersession =session;
	fbookUID = uid;
   // NSLog(@"User with  fbookid %lld logged in.", fbookUID);
	//NSLog(@"User with id %lld logged in.", uid);
	[self getFacebookName];
	
	
}


- (void)getFacebookName {
	
	NSString* fql = [NSString stringWithFormat:
					 @"select uid,name,email from user where uid == %lld", self.usersession.uid];
	NSDictionary* params = [NSDictionary dictionaryWithObject:fql forKey:@"query"];
	[[FBRequest requestWithDelegate:self] call:@"facebook.fql.query" params:params];
	
	
}

- (void)request:(FBRequest*)request didLoad:(id)result {
	
	//printf("\n\n loginctrl request");
	if ([request.method isEqualToString:@"facebook.fql.query"]) {
		NSArray* users = result;
		NSDictionary* user = [users objectAtIndex:0];
		emailFB = [user objectForKey:@"email"];
		
	//	NSLog(@" username is %@",emailFB);
		NSUserDefaults *useremail = [NSUserDefaults standardUserDefaults ];
		//saving username
		[useremail setObject:emailFB forKey:@"FBEmailString" ];
		
		
		
		
		
	}
	NSString* mystr= [[NSUserDefaults standardUserDefaults] objectForKey:@"FBEmailString" ]; 
	
	if (!(mystr == nil))
	{
		//printf("\n null value");
//	}
//	else {
		printf("\n email has value");
		[self fbookLoginCalled];
	}	
}

-(void) fbookLoginCalled
{
	//printf("\n fbooklogin called ");
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
	
	//NSLog(@"reqMessage is :%@",reqMessage);
	
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
	
	//NSLog(@"theRequest is: %@",theRequest);
	///Adding indicator here
	objActivityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle
					   :UIActivityIndicatorViewStyleWhiteLarge];
	objActivityView.frame=CGRectMake(130, 180, 50, 50);
	objActivityView.tag  = 1;
	[self.view addSubview:objActivityView];
	[objActivityView startAnimating];
	
}





@end
