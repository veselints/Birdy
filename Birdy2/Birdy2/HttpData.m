//
//  HttpData.m
//  Birdy2
//
//  Created by veso on 2/2/16.
//  Copyright © 2016 veso. All rights reserved.
//

#import "HttpData.h"

@implementation HttpData

-(void)sendAt:(NSString *)urlStr
   withMethod: (NSString*) method
         body:(NSDictionary *)bodyDict
      headers:(NSDictionary *)headersDict
andCompletionHandler:(void (^)(NSDictionary *, NSError *))completionHandler {
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:method];
    
    if(bodyDict){
        NSData *body = [NSJSONSerialization dataWithJSONObject:bodyDict options:NSJSONWritingPrettyPrinted error:nil];
        [request setHTTPBody: body];
    }
    
    if(headersDict){
        for(id key in headersDict){
            [request addValue:[headersDict objectForKey:key] forHTTPHeaderField:key];
        }
    }
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            completionHandler(nil, error);
            return;
        }
        
        NSError *err;
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        
        if(err) {
            completionHandler(nil, err);
            return;
        }
        completionHandler(dict, nil);
    }]
     resume];
}

-(void)getFrom:(NSString *)urlStr headers:(NSDictionary *)headersDict withCompletionHandler:(void (^)(NSDictionary *, NSError *))completionHandler {
    [self sendAt:urlStr withMethod:@"GET" body:nil headers:headersDict andCompletionHandler:completionHandler];
}

-(void)postAt:(NSString *)urlStr withBody:(NSDictionary *)bodyDict headers:(NSDictionary *)headersDict andCompletionHandler:(void (^)(NSDictionary *, NSError *))completionHandler {
    [self sendAt:urlStr withMethod:@"POST" body:bodyDict headers:headersDict andCompletionHandler:completionHandler];
}

-(void)putAt:(NSString *)urlStr withBody:(NSDictionary *)bodyDict headers:(NSDictionary *)headersDict andCompletionHandler:(void (^)(NSDictionary *, NSError *))completionHandler {
    [self sendAt:urlStr withMethod:@"PUT" body:bodyDict headers:headersDict andCompletionHandler:completionHandler];
}

+(HttpData *)httpData {
    return [[HttpData alloc] init];
}

@end
