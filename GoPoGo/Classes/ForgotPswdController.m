    //
//  ForgotPswdController.m
//  GoPoGo
//
//  Created by User on 1/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ForgotPswdController.h"
#import "LoginController.h"
#import "SignUpController.h"
#import "GoPoGoViewController.h"

@implementation ForgotPswdController

@synthesize webData,soapResults,xmlParser;


-(id) init
{
	
	if(self = [super init ] )
		
	{
		
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
	
	
	backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 320, 480)];
	backgroundView .image = [UIImage imageNamed:@"forgot-password.png"];
	[self.view addSubview:backgroundView];
	
	
	emailText = [[ UITextField alloc ] initWithFrame : CGRectMake(25, 117, 265, 30)];
	
	[ emailText setTextColor:[UIColor blackColor]];
	[ emailText setFont:[UIFont systemFontOfSize:16]];
	[ emailText setDelegate:self];
	[ emailText setAutocorrectionType: UITextAutocorrectionTypeNo];
	[ emailText setPlaceholder:@"Email"];
	
	emailText.keyboardType = UIKeyboardTypeDefault;
	emailText.textAlignment = UITextAlignmentLeft ;
	emailText.returnKeyType = UIReturnKeyDone  ;
	[ emailText setClipsToBounds: TRUE ] ;
	[ self.view addSubview: emailText ] ;
	
	UIImage *photoImage;
	UIImage *photoImage1;
	photoImage = [ UIImage imageNamed: @"reset-btn.png"];
	
	resetBtton = [ UIButton buttonWithType:UIButtonTypeCustom];
	resetBtton.frame = CGRectMake(80, 170, photoImage.size.width, photoImage.size.height); // position in the parent view and set the size of the button
	
	[resetBtton  setBackgroundImage:[ UIImage imageNamed: @"reset-btn.png"] forState:(UIControlState) normal ]; 
	[resetBtton addTarget:self action:@selector(resetBttonPressed) forControlEvents:UIControlEventTouchUpInside ];
	
	[self.view addSubview: resetBtton ]; 
	
	photoImage1 = [ UIImage imageNamed: @"cancel-btn.png"];
	
	CancelBtton = [ UIButton buttonWithType:UIButtonTypeCustom];
	CancelBtton.frame = CGRectMake(162, 170, photoImage1.size.width, photoImage1.size.height); // position in the parent view and set the size of the button
	
	[CancelBtton  setBackgroundImage:[ UIImage imageNamed: @"cancel-btn.png"] forState:(UIControlState) normal ]; 
	[CancelBtton addTarget:self action:@selector(cancelBttonPressed) forControlEvents:UIControlEventTouchUpInside ];
	
	[self.view addSubview: CancelBtton ]; 
	
		
	
}

-(void)cancelBttonPressed
{
	printf("cancel in  view");
	emailText.text = @"";

	[emailText resignFirstResponder];
	
	[self callMainView];
	
}

-(void)resetBttonPressed
{
	printf("\n\n reset -forgot pswd.");
	/// code for email validation
	
	NSArray *validateAtSymbol = [emailText.text componentsSeparatedByString:@"@"];
    NSArray *validateDotSymbol = [emailText.text componentsSeparatedByString:@"."];
    if(([validateAtSymbol count] != 2) || ([validateDotSymbol count] < 2)) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"Invalid EMail Address" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alertView show];
        [alertView release];
		return;
    }
	
	NSURL *url = [NSURL URLWithString:@"http://pirs.mygopogo.com/WebService/rest/api?method=forgotPassword"];
	
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	
	NSString *reqMessage = [NSString stringWithFormat:
							 @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
							 "<WS_User generator=\"zend\" version=\"1.0\">\n"
							 "<forgotPassword>\n"
							 "<email>%@</email>\n"
							 "</forgotPassword>\n"
							 "</WS_User>\n",emailText.text
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
	[emailText resignFirstResponder];
	
	
	return YES;
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch* touch = [touches anyObject];
	if((CGRectContainsPoint(frameLogin, [touch locationInView:self.view ])))
	{
		printf("\n Login is clicked");
		LoginController* objLoginCtrl = [[LoginController alloc]init];
		[self.navigationController pushViewController:objLoginCtrl animated:YES];
		[objLoginCtrl release];
	}
	
	if((CGRectContainsPoint(frameCrAcc, [touch locationInView:self.view ])))
	{
		printf("\n\n Create Acc clicked");
		
		SignUpController* objSignUpCtrl = [[SignUpController alloc]init];
		
		[self.navigationController pushViewController:objSignUpCtrl animated:YES];
		[objSignUpCtrl release];
		
	}
}

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
	[xmlParser release];
	[emailText release];

	
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
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	//printf("\n\n foundCharacters");
	if( statusFlag) // recordResults )
	{
		[soapResults appendString: string];
	}
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	printf("\n\n didEndElement");
	if( [elementName isEqualToString:@"response"])
	{
		//you will get response from server here
		//---displays the result
			
		if([soapResults isEqualToString:@"0"])
		{
			NSLog(@"didEndelement result is%@",soapResults);        
			UIAlertView *alert = [[UIAlertView alloc] 
								  initWithTitle:@"You entered wrong mail id" 
								  
								  message:@"Give correct mail id" 
								  delegate:self  
								  cancelButtonTitle:@"OK" 
								  otherButtonTitles:nil];
			[alert show];
			[alert release];
			
						
		}
		else {
			UIAlertView *alert = [[UIAlertView alloc] 
								  initWithTitle:@"Password has been sent to your mail Id" 
								  
								  message:@"check your email id" 
								  delegate:self  
								  cancelButtonTitle:@"OK" 
								  otherButtonTitles:nil];
			[alert show];
			[alert release];
			
			[self callMainView];
		}
		
        [soapResults setString:@""];
        recordResults = FALSE; 
		statusFlag = FALSE;
	}
}

-(void) callMainView
{
	[self.navigationController popViewControllerAnimated:YES]; 

}

@end
