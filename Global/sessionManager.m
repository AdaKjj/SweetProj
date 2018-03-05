//
//  sessionManager.m
//  明秀山庄物业管理
//
//  Created by mac on 2018/1/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "sessionManager.h"
#import "CTDefines.h"
#import "loginManager.h"

@interface sessionManager()  <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@end
@implementation sessionManager

- (void)reLogin:(NSString *)emailString pwdString:(NSString *)pwdString{
    //第一步，创建URL
    NSURL  *url = [NSURL URLWithString:LOGIN_URL];
    NSString *string = [NSString stringWithFormat:@"username=%@&password=%@",emailString,pwdString];
    //第二步，创建请求
    NSLog(@"字符串%@",string);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:100];
    [request setHTTPMethod:@"POST"];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    //第三步，连接服务器
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connection start];
    
}

- (void)submitSession:(NSString *)sessionString
{
    //第一步，创建URL
    NSURL  *url = [NSURL URLWithString:TEST_SESSION_URL];
    //第二步，创建请求
     NSString *param = [NSString stringWithFormat:@"session=%@",sessionString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:100];
    [request setHTTPMethod:@"POST"];
    NSData *data = [param dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    //第三步，连接服务器
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connection start];

}

//接收到服务器回应的时候调用此方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.receiveData = [NSMutableData data];
}
//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receiveData appendData:data];
}

//数据传完之后调用此方法
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    _receiveStr = [[NSString alloc]initWithData:self.receiveData encoding:NSUTF8StringEncoding];
    NSLog(@"提交session之后的返回码%@",_receiveStr);
     NSString *str = [_receiveStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([str isEqualToString:@"250"]) {
        [self reLoginByRespondSession:_receiveStr];
    } else
    {
        [self reGetSession:_receiveStr];
    }
}

// 重新做的登录之后对返回码做的操作
- (void)reGetSession:(NSString *)recieveString
{
    if (recieveString.length == 32) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:recieveString forKey:@"sessionString"];
        NSString *sessionString;
        sessionString = [defaults objectForKey:@"sessionString"];
        [self submitSession:sessionString];
    }
}

- (void)reLoginByRespondSession:(NSString *)receiveString
{
   NSString *str = [receiveString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([str isEqualToString:@"250"]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *email = [defaults objectForKey:@"emailString"];
        NSString *password = [defaults objectForKey:@"pwdString"];
        [self reLogin:email pwdString:password];
    } else{
        NSLog(@"做子账户添加的逻辑");
    }
}


@end
