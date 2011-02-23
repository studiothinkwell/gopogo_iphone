    //
//  AccountView.m
//  GoPoGo
//
//  Created by User on 2/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AccountView.h"
#import "HomeScreenViewController.h"

@implementation AccountView
@synthesize newView;
@synthesize webData,soapResults,xmlParser;//,objAppDelegate;
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

-(id) init
{
	if(self = [super init])
	{
		
	}
	return self;
	
}
	
	
/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	
	printf("\n load view");
	
	backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 320, 480)];
	backgroundView .image = [UIImage imageNamed:@"sign-in-bg.png"];
	[self.view addSubview:backgroundView];

}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 320, 480)];
	backgroundView .image = [UIImage imageNamed:@"homepageBG.png"];
	[self.view addSubview:backgroundView];
	
	LogoBtton=[UIButton buttonWithType:UIButtonTypeCustom];
	[LogoBtton setFrame:CGRectMake(10,4,150,37)];
	[self.view addSubview:LogoBtton];
	[LogoBtton addTarget:self action:@selector(LogoBtnPress) forControlEvents:UIControlEventTouchUpInside];
	
	frameAcc = CGRectMake(225, 8, 185, 25);
	AccLabel = [[UILabel alloc]initWithFrame:frameAcc] ;
	AccLabel.text=@"Account";
	[AccLabel setBackgroundColor:[UIColor clearColor]];
	[AccLabel setTextColor:[UIColor blackColor]];
	[AccLabel setFont:[UIFont fontWithName:@"Ariel" size:22]];
	AccLabel.font=[UIFont boldSystemFontOfSize:22];
	[self.view addSubview:AccLabel];
	
	frameInfo = CGRectMake(15, 52, 225, 25);
	SignInfoLbl = [[UILabel alloc]initWithFrame:frameInfo] ;
	SignInfoLbl.text=@"SIGN IN INFORMATION";
	[SignInfoLbl setBackgroundColor:[UIColor clearColor]];
	[SignInfoLbl setTextColor:[UIColor blackColor]];
	[SignInfoLbl setFont:[UIFont fontWithName:@"Ariel" size:16]];
	SignInfoLbl.font=[UIFont boldSystemFontOfSize:16];
	[self.view addSubview:SignInfoLbl];
	
	EmailLbl = [[UILabel alloc]initWithFrame:CGRectMake(15,90, 150, 25)];
	EmailLbl.text=@"Email:";
	[EmailLbl setBackgroundColor:[UIColor clearColor]];
	[EmailLbl setTextColor:[UIColor blackColor]];
	[EmailLbl setFont:[UIFont fontWithName:@"Ariel" size:16]];
	[self.view addSubview:EmailLbl];
	
	emailText = [[ UITextField alloc ] initWithFrame : CGRectMake(65, 92, 210, 30)];
	
	emailText.enabled = NO;
//	[ emailText setBorderStyle:UITextBorderStyleLine];// BorderStyleNone];
	[ emailText setTextColor:[UIColor blackColor]];
	[ emailText setFont:[UIFont systemFontOfSize:16]];
	[ emailText setDelegate:self];
	[ emailText setAutocorrectionType: UITextAutocorrectionTypeNo];
	NSString* myEmail= [[NSUserDefaults standardUserDefaults] objectForKey:@"keyUserEmailString" ]; 
	NSLog(@"email on Acc view is :%@",myEmail);
	
	emailText.text=@"";
	emailText.text = [emailText.text stringByAppendingString:myEmail];

//	emailText.keyboardType = UIKeyboardTypeDefault;
	emailText.textAlignment = UITextAlignmentLeft;
//	emailText.returnKeyType = UIReturnKeyDone;
	[ emailText setClipsToBounds: TRUE ] ;
	[ self.view addSubview: emailText ] ;
	
	
	PswdLbl = [[UILabel alloc]initWithFrame:CGRectMake(15,150, 150, 25)];
	PswdLbl.text=@"Password:";
	[PswdLbl setBackgroundColor:[UIColor clearColor]];
	[PswdLbl setTextColor:[UIColor blackColor]];
	[PswdLbl setFont:[UIFont fontWithName:@"Ariel" size:16]];
	[self.view addSubview:PswdLbl];
	
	pswdText = [[ UITextField alloc ] initWithFrame : CGRectMake(105, 150, 170, 30)];
	
	pswdText.enabled = NO;
	[ pswdText setBorderStyle:UITextBorderStyleNone];// BorderStyleNone];
	[ pswdText setTextColor:[UIColor blackColor]];
	//	[pswdText setBackgroundColor:clearColor];
	[ pswdText setFont:[UIFont systemFontOfSize:16]];
	[ pswdText setDelegate:self];
	[ pswdText setAutocorrectionType: UITextAutocorrectionTypeNo];
	pswdText.text=@"mypassword";
	pswdText.secureTextEntry = YES;
	NSString* str = @"mypassword";
	[ pswdText setPlaceholder:str];
	
	//	emailText.keyboardType = UIKeyboardTypeDefault;
	pswdText.textAlignment = UITextAlignmentLeft;
	//	emailText.returnKeyType = UIReturnKeyDone;
	[ pswdText setClipsToBounds: TRUE ] ;
	[ self.view addSubview: pswdText ] ;

	//
	
	UsrLbl = [[UILabel alloc]initWithFrame:CGRectMake(15,210, 150, 25)];
	UsrLbl.text=@"UserName:";
	[UsrLbl setBackgroundColor:[UIColor clearColor]];
	[UsrLbl setTextColor:[UIColor blackColor]];
	[UsrLbl setFont:[UIFont fontWithName:@"Ariel" size:16]];
	[self.view addSubview:UsrLbl];
	
	usrText = [[ UITextField alloc ] initWithFrame : CGRectMake(105, 212, 180, 30)];
	
	usrText.enabled = NO;
	//[ usrText setBorderStyle:UITextBorderStyleLine];// BorderStyleNone];
	[ usrText setTextColor:[UIColor blackColor]];
	//	[emailText setBackgroundColor:clearColor];
	[ usrText setFont:[UIFont systemFontOfSize:16]];
	[ usrText setDelegate:self];
	[ usrText setAutocorrectionType: UITextAutocorrectionTypeNo];
	
	usrText.text=@"";
	usrText.text = [usrText.text stringByAppendingString:@"ragini"];

	[self.view addSubview:usrText];
	
	UIImage *resetImage;
	resetImage = [ UIImage imageNamed: @"reset-btn.png"];
	
	resetBtton = [ UIButton buttonWithType:UIButtonTypeCustom];//RoundedRect ];
	resetBtton.frame = CGRectMake(240, 122, resetImage.size.width, resetImage.size.height); // position in the parent view and set the size of the button
	
	[resetBtton  setBackgroundImage:[ UIImage imageNamed: @"reset-btn.png"] forState:(UIControlState) normal ]; 
	[resetBtton addTarget:self action:@selector(updateEmailPressed) forControlEvents:UIControlEventTouchUpInside ];
	
	[self.view addSubview: resetBtton ]; ///myTempFun SignInBttonPressed
	
	resetBtton1 = [ UIButton buttonWithType:UIButtonTypeCustom];//RoundedRect ];
	resetBtton1.frame = CGRectMake(240, 162, resetImage.size.width, resetImage.size.height); // position in the parent view and set the size of the button
	
	[resetBtton1  setBackgroundImage:[ UIImage imageNamed: @"reset-btn.png"] forState:(UIControlState) normal ]; 
	[resetBtton1 addTarget:self action:@selector(PswdUpdatePressed) forControlEvents:UIControlEventTouchUpInside ];
	
	[self.view addSubview: resetBtton1 ]; ///myTempFun SignInBttonPressed
	
	
	resetBtton2 = [ UIButton buttonWithType:UIButtonTypeCustom];//RoundedRect ];
	resetBtton2.frame = CGRectMake(240, 262, resetImage.size.width, resetImage.size.height); // position in the parent view and set the size of the button
	
	[resetBtton2  setBackgroundImage:[ UIImage imageNamed: @"reset-btn.png"] forState:(UIControlState) normal ]; 
	[resetBtton2 addTarget:self action:@selector(usrUpdatePressed) forControlEvents:UIControlEventTouchUpInside ];
	
	[self.view addSubview: resetBtton2 ]; 
	
	[resetImage release];
   
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
-(void) updateEmailPressed  // email update button
{
	
	backgroundView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 90, 310, 300)];
	backgroundView1.image = [UIImage imageNamed:@"homepage-top.png"];
	[self.view addSubview:backgroundView1];
	
	EmailLbl1 = [[UILabel alloc]initWithFrame:CGRectMake(15,150, 80, 30)];
	EmailLbl1.text=@"Email:";
	[EmailLbl1 setBackgroundColor:[UIColor clearColor]];
	[EmailLbl1 setTextColor:[UIColor blackColor]];
	[EmailLbl1 setFont:[UIFont fontWithName:@"Ariel" size:16]];
	[self.view addSubview:EmailLbl1];
		
	emailText1 = [[ UITextField alloc ] initWithFrame : CGRectMake(30, 180, 255, 30)];
	
	[ emailText1 setBorderStyle:UITextBorderStyleLine];// BorderStyleNone];
	[ emailText1 setTextColor:[UIColor blackColor]];
	[ emailText1 setFont:[UIFont systemFontOfSize:16]];
	[ emailText1 setDelegate:self];
	[ emailText1 setAutocorrectionType: UITextAutocorrectionTypeNo];
	[ emailText1 setPlaceholder:@"Email"];
	
	emailText1.keyboardType = UIKeyboardTypeDefault;
	emailText1.textAlignment = UITextAlignmentLeft;
	emailText1.returnKeyType = UIReturnKeyDone;
	[ emailText1 setClipsToBounds: TRUE ] ;
	[ self.view addSubview: emailText1 ] ;
	emailText1.text = @"";
	
	
	photoImage = [ UIImage imageNamed: @"submit-btn.png"];
	
	saveBtton = [ UIButton buttonWithType:UIButtonTypeCustom];
	saveBtton.frame = CGRectMake(80, 235, photoImage.size.width, photoImage.size.height); // position in the parent view and set the size of the button
	
	[saveBtton  setBackgroundImage:[ UIImage imageNamed: @"submit-btn.png"] forState:(UIControlState) normal ]; 
	[saveBtton addTarget:self action:@selector(SaveBttonPressed) forControlEvents:UIControlEventTouchUpInside ];
	
	[self.view addSubview: saveBtton ]; 
	
	photoImage1 = [ UIImage imageNamed: @"cancel-btn.png"];
	
	CancelBtton = [ UIButton buttonWithType:UIButtonTypeCustom];
	CancelBtton.frame = CGRectMake(160, 235, photoImage1.size.width, photoImage1.size.height); // position in the parent view and set the size of the button
	
	[CancelBtton  setBackgroundImage:[ UIImage imageNamed: @"cancel-btn.png"] forState:(UIControlState) normal ]; 
	[CancelBtton addTarget:self action:@selector(cancelBttonPressed) forControlEvents:UIControlEventTouchUpInside ];
	
	[self.view addSubview: CancelBtton ]; 
	
	resetBtton1.enabled = NO;
	resetBtton.enabled = NO;
	resetBtton2.enabled = NO;
	
}

-(void) PswdUpdatePressed  /// passwd update button
{
	printf("\n update pswd pressed");
	
	CGPoint pcenter;
	
	
	CGRect frame = CGRectMake(160, 270, 310, 300);
	
	backgroundView1 = [[UIImageView alloc] initWithFrame:frame];//CGRectMake(0,0, 320, 480)];
	backgroundView1.image = [UIImage imageNamed:@"password.png"];

	[backgroundView1 setBackgroundColor:[UIColor lightGrayColor ]];
	backgroundView1.alpha = 1;
	pcenter.x = 160;
	pcenter.y = 270;
	[self.view addSubview:backgroundView1];
	
	[backgroundView1 setCenter: pcenter];
	
	oldpswdText = [[ UITextField alloc ] initWithFrame : CGRectMake(30, 165, 255, 30)];
	
//	[ oldpswdText setBorderStyle:UITextBorderStyleLine];// BorderStyleNone];
	[ oldpswdText setTextColor:[UIColor blackColor]];
	[ oldpswdText setFont:[UIFont systemFontOfSize:16]];
	[ oldpswdText setDelegate:self];
	[ oldpswdText setAutocorrectionType: UITextAutocorrectionTypeNo];
	[ oldpswdText setPlaceholder:@"Old Password"];
	
	oldpswdText.keyboardType = UIKeyboardTypeDefault;
	oldpswdText.textAlignment = UITextAlignmentLeft;
	oldpswdText.returnKeyType = UIReturnKeyDone;
	[ oldpswdText setClipsToBounds: TRUE ] ;
	[ self.view addSubview: oldpswdText ] ;
	oldpswdText.text = @"";
			
		
	newpswdText = [[ UITextField alloc ] initWithFrame : CGRectMake(30, 245, 255, 30)];
	
//	[ newpswdText setBorderStyle:UITextBorderStyleLine];// BorderStyleNone];
	[ newpswdText setTextColor:[UIColor blackColor]];
	[ newpswdText setFont:[UIFont systemFontOfSize:16]];
	[ newpswdText setDelegate:self];
	[ newpswdText setAutocorrectionType: UITextAutocorrectionTypeNo];
	[ newpswdText setPlaceholder:@"New password*"];
	
	newpswdText.keyboardType = UIKeyboardTypeDefault;
	newpswdText.textAlignment = UITextAlignmentLeft;
	newpswdText.returnKeyType = UIReturnKeyDone;
	[ newpswdText setClipsToBounds: TRUE ] ;
	[ self.view addSubview: newpswdText ] ;
	newpswdText.text = @"";
	
			
	repswdText = [[ UITextField alloc ] initWithFrame : CGRectMake(30, 325, 255, 30)];
	
//	[ repswdText setBorderStyle:UITextBorderStyleLine];// BorderStyleNone];
	[ repswdText setTextColor:[UIColor blackColor]];
	[ repswdText setFont:[UIFont systemFontOfSize:16]];
	[ repswdText setDelegate:self];
	[ repswdText setAutocorrectionType: UITextAutocorrectionTypeNo];
	[ repswdText setPlaceholder:@"New password*"];
	
	repswdText.keyboardType = UIKeyboardTypeDefault;
	repswdText.textAlignment = UITextAlignmentLeft;
	repswdText.returnKeyType = UIReturnKeyDone;
	[ repswdText setClipsToBounds: TRUE ] ;
	[ self.view addSubview: repswdText ] ;
	repswdText.text = @"";
	
	
	saveBtton=[UIButton buttonWithType:UIButtonTypeCustom];
	[saveBtton setFrame:CGRectMake(165,376,62,30)];
//	[saveBtton setBackgroundColor:[UIColor grayColor]];
	[self.view addSubview:saveBtton];
	
	[saveBtton addTarget:self action:@selector(SaveBttonPressed) forControlEvents:UIControlEventTouchUpInside ];

	
	CancelBtton=[UIButton buttonWithType:UIButtonTypeCustom];
	[CancelBtton setFrame:CGRectMake(81,376,62,30)];
	//[CancelBtton setBackgroundColor:[UIColor grayColor]];
	[self.view addSubview:CancelBtton];
	
	
	[CancelBtton addTarget:self action:@selector(cancelBtton1Pressed) forControlEvents:UIControlEventTouchUpInside ];
	
	//[self.view addSubview: CancelBtton ]; ///myTempFun SignInBttonPressed
	
	resetBtton1.enabled = NO;
	resetBtton.enabled = NO;
	resetBtton2.enabled = NO;
	
}

-(void) usrUpdatePressed ///username update button
{
	backgroundView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 90, 300, 300)];
	backgroundView1.image = [UIImage imageNamed:@"homepage-top.png"];
	[self.view addSubview:backgroundView1];
	
	UsrLbl = [[UILabel alloc]initWithFrame:CGRectMake(15,150, 100, 30)];
	UsrLbl.text=@"UserName:";
	[UsrLbl setBackgroundColor:[UIColor clearColor]];
	[UsrLbl setTextColor:[UIColor blackColor]];
	[UsrLbl setFont:[UIFont fontWithName:@"Ariel" size:16]];
	[self.view addSubview:UsrLbl];
	
	usrText1 = [[ UITextField alloc ] initWithFrame : CGRectMake(30, 180, 255, 30)];
	
	[ usrText1 setBorderStyle:UITextBorderStyleLine];// BorderStyleNone];
	[ usrText1 setTextColor:[UIColor blackColor]];
	[ usrText1 setFont:[UIFont systemFontOfSize:16]];
	[ usrText1 setDelegate:self];
	[ usrText1 setAutocorrectionType: UITextAutocorrectionTypeNo];
	[ usrText1 setPlaceholder:@"UsrName"];
	
	usrText1.keyboardType = UIKeyboardTypeDefault;
	usrText1.textAlignment = UITextAlignmentLeft;
	usrText1.returnKeyType = UIReturnKeyDone;
	[ usrText1 setClipsToBounds: TRUE ] ;
	[ self.view addSubview: usrText1 ] ;
	usrText1.text = @"";
	
	
	photoImage = [ UIImage imageNamed: @"submit-btn.png"];
	
	saveBtton = [ UIButton buttonWithType:UIButtonTypeCustom];
	saveBtton.frame = CGRectMake(80, 235, photoImage.size.width, photoImage.size.height); // position in the parent view and set the size of the button
	
	[saveBtton  setBackgroundImage:[ UIImage imageNamed: @"submit-btn.png"] forState:(UIControlState) normal ]; 
	[saveBtton addTarget:self action:@selector(SaveBttonPressed) forControlEvents:UIControlEventTouchUpInside ];
	
	[self.view addSubview: saveBtton ]; 
	
	photoImage1 = [ UIImage imageNamed: @"cancel-btn.png"];
	
	CancelBtton = [ UIButton buttonWithType:UIButtonTypeCustom];
	CancelBtton.frame = CGRectMake(160, 235, photoImage1.size.width, photoImage1.size.height); // position in the parent view and set the size of the button
	
	[CancelBtton  setBackgroundImage:[ UIImage imageNamed: @"cancel-btn.png"] forState:(UIControlState) normal ]; 
	[CancelBtton addTarget:self action:@selector(cancelBtton2Pressed) forControlEvents:UIControlEventTouchUpInside ];
	
	[self.view addSubview: CancelBtton ]; 
	
	resetBtton1.enabled = NO;
	resetBtton.enabled = NO;
	resetBtton2.enabled = NO;
	
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];

	
	CGPoint pcenter;
	pcenter.x = 160;
	pcenter.y = 270;
	[backgroundView1 setCenter: pcenter];
	
	pcenter.x = 160;
	pcenter.y = 178;
	[oldpswdText setCenter:pcenter];
	
	pcenter.x = 160;
	pcenter.y = 258;//365+15;
	[newpswdText setCenter:pcenter];
	
	pcenter.x = 160;
	pcenter.y = 338;//365+15;
	[repswdText setCenter:pcenter];
	
	[UIView commitAnimations];
	
	[emailText resignFirstResponder];
	
	[emailText1 resignFirstResponder];
	
	[pswdText resignFirstResponder];
	
	[oldpswdText resignFirstResponder];
	
	[repswdText resignFirstResponder];
	
	[newpswdText resignFirstResponder];
	
	[usrText resignFirstResponder];
	
	
	return YES;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField 
{
	printf("\n\n textBeginEditing");
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	if(textField == newpswdText)
	{
		CGPoint pcenter;
		pcenter.x = 160;
		pcenter.y = 190;
		[backgroundView1 setCenter: pcenter];
		
		pcenter.x = 30+130;
		pcenter.y =165-65;
		[oldpswdText setCenter:pcenter];
	
		pcenter.x = 160;
		pcenter.y = 245-65;
		[newpswdText setCenter:pcenter];
	}
	
	if(textField == repswdText)
	{
		CGPoint pcenter;
		pcenter.x = 160;
		pcenter.y = 150;
		[backgroundView1 setCenter: pcenter];
		
		pcenter.x = 30+130;
		pcenter.y =165-108;
		[oldpswdText setCenter:pcenter];
		
		pcenter.x = 160;
		pcenter.y = 245-108;
		[newpswdText setCenter:pcenter];
		
		pcenter.x = 160;
		pcenter.y = 325-108;
		[repswdText setCenter:pcenter];
		
	}
	[UIView commitAnimations];
	return ( TRUE ) ;
	
}

-(void) backClicked
{
	[self.navigationController popViewControllerAnimated:YES];
}
-(void) cancelBtton1Pressed
{
	printf(" cancelClicked");
	backgroundView1.alpha = 0;

	[oldpswdText setAlpha:0];
	
	[repswdText setAlpha:0];
	
	[newpswdText setAlpha:0];

	[CancelBtton setAlpha:0];
	
	[saveBtton setAlpha:0];
	
	resetBtton1.enabled = YES;
	resetBtton.enabled = YES;
	resetBtton2.enabled = YES;
}

-(void) cancelBttonPressed
{
	backgroundView1.alpha = 0;
	
	[EmailLbl1 setAlpha:0];
	
	[emailText1 setAlpha:0];
	
	[CancelBtton setAlpha:0];
	
	[saveBtton setAlpha:0];
	
	resetBtton1.enabled = YES;
	resetBtton.enabled = YES;
	resetBtton2.enabled = YES;
}

-(void) cancelBtton2Pressed
{
	backgroundView1.alpha = 0;
	[UsrLbl setAlpha:0];
	[usrText setAlpha:0];
	
	[CancelBtton setAlpha:0];
	
	[saveBtton setAlpha:0];
	
	resetBtton1.enabled = YES;
	resetBtton.enabled = YES;
	resetBtton2.enabled = YES;
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
	[AccLabel release];
	[SignInfoLbl release];
	//[backgroundView1 release];
	[EmailLbl1 release];

	[emailText release];
	[emailText1 release];

	[oldpswdText release];
	[newpswdText release];
	[repswdText release];
	
	[usrText release];
	[usrText1 release];
	
	//[photoImage1 release];
	//[photoImage release];
	[UsrLbl release];
	
//	[LogoBtton release];
}

-(void)LogoBtnPress
{
	printf("\n logobtn press");	

	[self.navigationController popViewControllerAnimated:YES];
	//HomeScreenViewController* objHomeCtrlr = [[HomeScreenViewController alloc]initWithNibName:nil bundle:[NSBundle mainBundle]];
	
	//[self.view addSubview:objHomeCtrlr.view];
	
}

-(void) SaveBttonPressed
{
	printf("\n saveBtn pressed");
}

//// function of NSURLConnection related webservice API


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
//		recordResults = TRUE;
//		statusFlag = TRUE;
	}
	
	if( [elementName isEqualToString:@"email"]) // for GoPoGo we will have "sign-up"
	{
		if(!soapResults)
		{
			soapResults = [[NSMutableString alloc] init];
		}
//		emailResFlag = TRUE;
//		statusFlag = FALSE;
	}
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	printf("\n\n foundCharacters");
	[soapResults setString:@""];
	
	NSLog(@"foundchar soap result is: %@",soapResults);
//	if(statusFlag)// recordResults )
	{
		[soapResults setString:@""];
		printf("\n stutus flag found");
		[soapResults appendString: string];
	}
	
//	if( emailResFlag )
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
}

@end
