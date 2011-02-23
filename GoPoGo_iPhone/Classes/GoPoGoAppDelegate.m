//
//  GoPoGoAppDelegate.m
//  GoPoGo
//
//  Created by User on 12/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GoPoGoAppDelegate.h"
#import "GoPoGoViewController.h"

#import "LoginController.h"
#import "AccountView.h"


@implementation GoPoGoAppDelegate

@synthesize window ,splashScreen;
@synthesize viewController;
@synthesize isLogin , iLoginCtrl;
@synthesize _session;




#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.

    // Add the view controller's view to the window and display.
	
	
	
	
	
	iLoginCtrl = [[LoginController alloc]init];
	AccountView* objAcc= [[AccountView alloc]init];
	NavController=[[UINavigationController alloc]initWithRootViewController:iLoginCtrl]; //iLoginCtrl
	[window addSubview:NavController.view];
	NavController.navigationBar.hidden =YES;
 
		
	
	/// Add splash screen here.
	splashScreen = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320, 480)];
	splashScreen.image = [UIImage imageNamed:@"splash.png"];
	
	[self.window addSubview:splashScreen];
					
    [self.window makeKeyAndVisible];
	
	isLogin = FALSE;
	iLoginCtrl.objAppDelegate = self;

	[self performSelector:@selector(hideSplash) withObject: nil afterDelay: 3.5];

    return YES;
}



- (void) hideSplash {
	
	[UIView beginAnimations: @"hideSplash" context: 0];
	[UIView setAnimationDuration: 1.0];
	
	[splashScreen setAlpha: 0];
	[UIView commitAnimations];
	[splashScreen removeFromSuperview];
	
}
-(void) ShowMainView
{
	
 if(iLoginCtrl!=nil) 
	{
		iLoginCtrl=nil;
		[iLoginCtrl release];
	}
	iLoginCtrl = [[LoginController alloc]init];
	NavController=[[UINavigationController alloc]initWithRootViewController:iLoginCtrl]; //viewController
	
	[window addSubview:NavController.view];
	NavController.navigationBar.hidden =YES;
	
}

- (void)applicationWillResignActive:(UIApplication *)application 
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application 
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application 
{
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application 
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application 
{
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application 
{
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}




-(NSString*) GenerateSessionId
{
	
	NSDate *today = [NSDate date];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	// display in 12HR/24HR (i.e. 11:25PM or 23:25) format according to User Settings
	[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
	NSString *currentTime = [dateFormatter stringFromDate:today];
	
	NSLog(@"User's current time in their preference format:%@",currentTime);
	
    [dateFormatter setDateStyle: NSDateFormatterBehavior10_4]; //NSDateFormatterShortStyle];
	NSString *currentDate = [dateFormatter stringFromDate:today];
	
	NSLog(@"User's current date in their preference format:%@",currentDate);
	
	NSString * noSpaces = [[currentDate componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString: @""];
	
	NSString *finalStr = [[noSpaces componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"/:,"]] componentsJoinedByString: @""];
	
	NSLog(@"User's current date in final preference format:%@",finalStr);
	
	[dateFormatter release];	
	
	NSString* strId = [[UIDevice currentDevice] uniqueIdentifier]; 
	
	NSLog(@"uniq identifier is :%@",strId);
	
	
	NSString *newString;
	newString = [strId substringFromIndex: 24];
	
	NSLog(@"new uniq identifier is :%@",newString);
	
	finalStr = [finalStr stringByAppendingString:newString];
	return finalStr;
}

- (void)dealloc {
   // [viewController release];
	[NavController release];
    [window release];
    [super dealloc];
}


@end
