//
//  GetBackPwdManager.m
//  SweetProj
//
//  Created by 殷婕 on 2017/11/28.
//  Copyright © 2017年 AdaKjj. All rights reserved.
//

#import "GetBackPwdManager.h"
#import "AppDelegate.h"

@interface GetBackPwdManager ()
{
    NSMutableData *buff;   //暂存响应的数据
    bool finished;
    GetBackRequestType receivedType;
}
@end

@implementation GetBackPwdManager

- (void)sendRequest:(GetBackRequestType)type email:(NSString *)email pwd:(NSString *)pwd verdificationCode:(NSString *)verCode {
    NSString *urlString = nil;
    NSString *sendString = nil;
    switch (type) {
            // 忘记密码请求验证码
        case GETBACKCHECKOUTEMAIL:
            receivedType = GETBACKCHECKOUTEMAIL;
            urlString = @"https://thethreestooges.cn:666/application/login/forget_submit.php";
            sendString = [NSString stringWithFormat:@"mail_address=%@",email];
            break;
            // 提交验证码和邮件地址
        case GETBACKEMAILVER:
            receivedType = GETBACKEMAILVER;
            urlString = @"https://thethreestooges.cn:666/application/login/forget_validate.php";
            sendString = [NSString stringWithFormat:@"mail_address=%@&mail_ver=%@",email,verCode];
            break;
            // 提交邮件和密码
        case GETBACKUSERREGISTER:
            receivedType = GETBACKUSERREGISTER;
            urlString = @"https://thethreestooges.cn:666/application/login/user_forget.php";
            sendString = [NSString stringWithFormat:@"username=%@&password=%@",email,pwd];
            break;
    }
    
    //第一步，创建url
    NSURL *url = [NSURL URLWithString:urlString];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    
    NSData *data = [sendString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    //第三步，连接服务器
    [NSURLConnection connectionWithRequest:request delegate:self];
}

//接收到服务器回应的时候调用此方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    buff = [NSMutableData data];
}
//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [buff appendData:data];
}
//数据传完之后调用此方法
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *receiveStr = [[NSString alloc]initWithData:buff encoding:NSUTF8StringEncoding];
    DLog(@"%@",receiveStr);
    switch(receivedType) {
        case GETBACKCHECKOUTEMAIL:
            [_registerVC receiveSendEmailRequest:[receiveStr intValue]];
            break;
        case GETBACKEMAILVER:
            [_registerVC receiveSendEmailVerRequest:[receiveStr intValue]];
            break;
        case GETBACKUSERREGISTER:
            [_confirmVC receiveCompeleteRequest:[receiveStr intValue]];
            break;
    }
}
//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    DLog(@"%@",[error localizedDescription]);
}
@end
