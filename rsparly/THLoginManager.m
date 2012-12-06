//
//  THLoginManager.m
//  rsparly
//
//  Created by Tom Hartley on 25/11/12.
//  Copyright (c) 2012 Tom Hartley. All rights reserved.
//

#import "THLoginManager.h"
#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"
@implementation THLoginManager

+(THLoginManager *)sharedLoginManager {
    static THLoginManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[THLoginManager alloc] init];
        // Do any other initialisation stuff here
        NSUserDefaults *shared = [NSUserDefaults standardUserDefaults];
        NSString *session = [shared objectForKey:@"sessionID"];
        if (session) {
            sharedInstance.sessionID = session;
            sharedInstance.loggedIn = YES;
        } else {
            sharedInstance.loggedIn = NO;
        }
    });
    return sharedInstance;
}

-(void)createSessionWithEmail:(NSString *)email password:(NSString *)password {
    NSURL *url = [NSURL URLWithString:@"http://parlihack.eu01.aws.af.cm/app/index.php?r=user/login"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    //NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            password, @"password",
                            email, @"email",
                            nil];
    NSURLRequest *request = [httpClient requestWithMethod:@"POST" path:nil parameters:params];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if ([[JSON objectForKey:@"success"] boolValue]) {
            self.sessionID = [JSON objectForKey:@"key"];
            NSUserDefaults *shared = [NSUserDefaults standardUserDefaults];
            [shared setObject:self.sessionID forKey:@"sessionID"];
            [shared synchronize];
            self.loggedIn = YES;
            NSLog(@"login succeeded! new session id: %@",self.sessionID);
        } else {
            NSLog(@"login failed!");
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
        NSLog(@"%@",error);
    }];
    [operation start];
}

-(void)logout {
    self.sessionID = nil;
    self.loggedIn = NO;
    NSUserDefaults *shared = [NSUserDefaults standardUserDefaults];
    [shared setObject:nil forKey:@"sessionID"];
    [shared synchronize];
}

@end
