//
//  VWWUserAboutViewController.m
//  Hatreddit
//
//  Created by Zakk Hoyt on 4/20/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWUserAboutViewController.h"
#import "VWWRESTEngine.h"
#import "VWWRedditAbout.h"

@interface VWWUserAboutViewController ()
@property (strong) IBOutlet NSTextField *nameLabel;
@property (strong) IBOutlet NSTextField *commentKarmaLabel;
@property (strong) IBOutlet NSTextField *linkKarmaLabel;
@property (strong) IBOutlet NSTextField *hasMailLabel;

@property (strong) IBOutlet NSTextField *usernameTextField;
@property (strong) IBOutlet NSSecureTextField *passwordTextField;

@end

@implementation VWWUserAboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


-(void)loadView{
    [super loadView];
    
    [[VWWRESTEngine publicInstance] getAboutInfoUser:@"sneeden"
                                           completionBlock:^(VWWRedditAbout *about) {
                                               NSLog(@"Success: %@", about);
                                               self.nameLabel.stringValue = about.data.name;
                                               
                                               self.commentKarmaLabel.stringValue = about.data.commentKarma;
                                               NSDockTile *tile = [[NSApplication sharedApplication] dockTile];
                                               NSString *dockTitle = [NSString stringWithFormat:@"%ld", about.data.commentKarma.integerValue];
                                               [tile setBadgeLabel:dockTitle];
                                               
                                               self.linkKarmaLabel.stringValue = about.data.linkKarma;
                                               
//                                               if(about.data.hasMail == (NSString*)[NSNull null]){
//                                                   self.hasMailLabel.stringValue = @"NO";
//                                               }
//                                               else{
//                                                   self.hasMailLabel.stringValue = @"YES";
//                                               }
//
//                                               if([about.data.hasMail isEqualToString:@"<null>"] == YES){
//                                                   self.hasMailLabel.stringValue = @"NO";
//                                               }
//                                               else{
//                                                   self.hasMailLabel.stringValue = @"YES";
//                                               }
//                                               
//                                               self.hasMailLabel.stringValue = @"asdfasd";
                                               
                                           } errorBlock:^(NSError *error, NSString *additionalInfo) {
                                               //assert(NO);
                                           }];
}


- (IBAction)loginButtonAction:(id)sender {
    VWWHTTPRedditLoginForm *form = [VWWHTTPRedditLoginForm new];
//    form.username = @"sneeden";
//    form.password = @"jfy45h1";
    form.user = @"sneeden";
    form.passwd = @"jfy45h1";
    
    [[VWWRESTEngine privateInstance] loginWithForm:form
                                  completionBlock:^(NSString *string) {
                                      NSLog(@"");
                                  } errorBlock:^(NSError *error, NSString *additionalInfo) {
                                      
                                      NSLog(@"");
                                  }];
}



@end
