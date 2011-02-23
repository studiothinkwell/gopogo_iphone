//
//  webViewController.m
//  GoPoGo
//
//  Created by User on 2/2/11.file://localhost/mahendrar/Projects/GoPoGo/Classes/webViewController.m
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "webViewController.h"
#import "LoginController.h"

@implementation webViewController

@synthesize webviewscreen, av;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
	{
      printf("....in webview....");
		CGFloat width = self.view.frame.size.width;
		
		// webscreen initialization
		webviewscreen= [[UIWebView alloc]initWithFrame:CGRectMake(0,48,320,428)];
		webviewscreen.delegate= self;
		webviewscreen.userInteractionEnabled=YES;
		//webviewscreen.canGoBack=TRUE;
		//webviewscreen.canGoForward=TRUE;
		webviewscreen.multipleTouchEnabled=YES;
		webviewscreen.scalesPageToFit=YES;
		[webviewscreen  loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.google.com"]]];
		[self.view addSubview:webviewscreen];
		///webscreen initialization done
		
		//navigation
		navBar = [[UINavigationBar alloc] initWithFrame:
								   CGRectMake(0,0,width,45)];
		navBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		[self.view addSubview:navBar];

			
		img_URL=[[UIImageView alloc]init];
		img_URL.frame =CGRectMake(5,5,241,30);
		img_URL.image=[UIImage imageNamed:@"WebTextbox-bg.png"];
		[navBar addSubview:img_URL];
		
		txt_URL=[[UITextField alloc]initWithFrame:CGRectMake(13,6,200,28)];
		//txt_URL.borderStyle=YES;
		txt_URL.delegate = self;
		txt_URL.returnKeyType = UIReturnKeyDone;
		txt_URL.autocorrectionType = UITextAutocorrectionTypeNo;
		[txt_URL.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
		[txt_URL.layer setBorderColor:[[UIColor clearColor] CGColor]];
		[txt_URL.layer setBorderWidth: 2.0];
		[txt_URL.layer setCornerRadius:8.0f];
		[txt_URL.layer setMasksToBounds:YES];
		txt_URL.placeholder=@"Enter URL";
		txt_URL.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;		
		txt_URL.font = [UIFont systemFontOfSize:14.0];	
		txt_URL.textColor=[UIColor blackColor];
		
		//txt_Search.textColor=[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:246.0/255.0 alpha:1.0];
		
		
		//[self.view addSubview:txt_URL];
		[navBar addSubview:txt_URL];

		btn_Close = [ UIButton buttonWithType:UIButtonTypeCustom];
		btn_Close.frame = CGRectMake(255,1,55,38);
		//[btn_Close setTitle:@"X" forState:UIControlStateNormal];
		[btn_Close  setBackgroundImage:[ UIImage imageNamed: @"close1.png"] forState:(UIControlState) normal ]; 
		[btn_Close addTarget:self action:@selector(btn_ClosePressed) forControlEvents:UIControlEventTouchUpInside ];
		
		//[self.view addSubview: btn_Close];
		[navBar addSubview:btn_Close];
				
		btn_Search = [ UIButton buttonWithType:UIButtonTypeCustom];
		btn_Search.frame = CGRectMake(224,10,18,20);
		//[btn_Search setTitle:@"OK" forState:UIControlStateNormal];
		[btn_Search  setBackgroundImage:[ UIImage imageNamed: @"try.png"] forState:(UIControlState) normal ]; 
		[btn_Search addTarget:self action:@selector(btn_SearchPressed) forControlEvents:UIControlEventTouchUpInside ];
		
		//[self.view addSubview: btn_Search];
		[navBar addSubview:btn_Search];
		
		///navigation end
			
		
		//bottom navigation
		BotnavBar = [[UINavigationBar alloc] initWithFrame:
								   CGRectMake(0,436,width,25)];
		BotnavBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		[self.view addSubview:BotnavBar];
	
		btn_Left = [UIButton buttonWithType:UIButtonTypeCustom];
		btn_Left.frame = CGRectMake(120,4,15,17);
		//[btn_Search setTitle:@"OK" forState:UIControlStateNormal];
		[btn_Left  setBackgroundImage:[ UIImage imageNamed: @"WebArrow-leftr.png"] forState:(UIControlState) normal ]; 
		[btn_Left addTarget:self action:@selector(btn_LeftPressed) forControlEvents:UIControlEventTouchUpInside ];
		[BotnavBar addSubview:btn_Left];
		
		btn_Right = [ UIButton buttonWithType:UIButtonTypeCustom];
		btn_Right.frame = CGRectMake(180,4,15,17);
		//[btn_Search setTitle:@"OK" forState:UIControlStateNormal];
		[btn_Right  setBackgroundImage:[ UIImage imageNamed: @"WebArrow-right.png"] forState:(UIControlState) normal ]; 
		[btn_Right addTarget:self action:@selector(btn_RightPressed) forControlEvents:UIControlEventTouchUpInside ];
		[BotnavBar addSubview:btn_Right];
		///end of bottom navigation
		
		/*
		LoginController *ilogin=[[LoginController alloc]init];
		[self.navigationController pushViewController:ilogin animated:YES];
		[ilogin release];
		 */
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
	[txt_URL resignFirstResponder];
	//
		NSString *myURLString =txt_URL.text;
		NSURL *myURL;
		if ([myURLString hasPrefix:@"http://"]) 
		{
			myURL = [NSURL URLWithString:myURLString];
		} else 
		{
			myURL = [NSURL URLWithString:[@"http://" stringByAppendingString:myURLString]];
		}
	//
	[webviewscreen  loadRequest:[NSURLRequest requestWithURL:myURL]];
	//[webviewscreen release];
	//[myURLString release];
	//[webviewscreen  loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:txt_URL.text]]];
	return YES;
}

-(void) btn_SearchPressed
{
	NSString *myURLString =txt_URL.text;
	NSURL *myURL;
	if ([myURLString hasPrefix:@"http://"]) 
	{
		myURL = [NSURL URLWithString:myURLString];
	} else 
	{
		myURL = [NSURL URLWithString:[@"http://" stringByAppendingString:myURLString]];
	}
		
	[webviewscreen loadRequest:[NSURLRequest requestWithURL:myURL]];
	
	//[myURLString release];
	//[webviewscreen release];
	 
	//[webviewscreen  loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

-(void) btn_ClosePressed
{
	LoginController *iLogin=[[LoginController alloc]init];
	[self.navigationController pushViewController:iLogin animated:YES];
	[iLogin release];
}

-(void) btn_LeftPressed
{
	if ([webviewscreen canGoBack]) 
	{
		[webviewscreen goBack];
	}
}
-(void) btn_RightPressed
{
	if ([webviewscreen canGoForward]) 
	{
		[webviewscreen goForward];
	}
}

- (void)webViewDidStartLoad:(UIWebView *)webView
/*- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType*/
{
	printf("\n started");
	txt_URL.text=webviewscreen.request.URL.absoluteString;

	av = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle
		  :UIActivityIndicatorViewStyleWhiteLarge];
	av.frame=CGRectMake(130, 180, 50, 50);
	av.tag  = 1;
	[webView addSubview:av];
	[av startAnimating];
		
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	printf("\n stopped");
	txt_URL.text=webviewscreen.request.URL.absoluteString;

	[av stopAnimating];
	
	//back forward
	btn_Left.enabled = webviewscreen.canGoBack;
    btn_Right.enabled = webviewscreen.canGoForward;
	//
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
	//[webviewscreen dealloc];
	[av release];
	[BotnavBar release];
	[navBar release];
}


@end
