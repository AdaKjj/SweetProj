//
//  MainManager.m
//  SweetProj
//
//  Created by 殷婕 on 2018/1/24.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import "MainManager.h"
//#import "NSURLSession.h"

@implementation MainManager
//
//- (void)sendRequest:(LoginRequestType)type long:(NSString *)lon lat:(NSString *)lat {
//    //第一步，创建url
//    NSURL *url = [NSURL URLWithString:@"https://thethreestooges.cn/consumer/bean/home_page/home_page_show.php"];
//    NSString *sendString = nil;
//    sendString = [NSString stringWithFormat:@"long=%@&lat=%@",lon,lat];
//    //第二步，创建请求
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
//    [request setHTTPMethod:@"POST"];
//
//    NSData *data = [sendString dataUsingEncoding:NSUTF8StringEncoding];
//    [request setHTTPBody:data];
//    //第三步，连接服务器
//    [NSURLConnection connectionWithRequest:request delegate:self];
//}
//
////接收到服务器回应的时候调用此方法
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
//{
//    NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
//    NSLog(@"%@",[res allHeaderFields]);
//    buff = [NSMutableData data];
//}
////接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次
//-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
//{
//    [buff appendData:data];
//}
////数据传完之后调用此方法
//-(void)connectionDidFinishLoading:(NSURLConnection *)connection
//{
//    NSString *receiveStr = [[NSString alloc]initWithData:buff encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",receiveStr);
//    switch(receivedType) {
//        case LOGINUSERLOGIN:
//            [_loginVC receiveLoginRequest:[receiveStr intValue]];
//            break;
//        case LOGINCHECKOUTEMAIL:
//            [_registerVC receiveSendEmailRequest:[receiveStr intValue]];
//            break;
//        case LOGINEMAILVER:
//            [_registerVC receiveSendEmailVerRequest:[receiveStr intValue]];
//            break;
//        case LOGINUSERREGISTER:
//            [_confirmVC receiveCompeleteRequest:[receiveStr intValue]];
//            break;
//    }
//}
////网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
//-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
//{
//    NSLog(@"%@",[error localizedDescription]);
//}

+ (NSDictionary *)getMainDic {
    NSURL *url=[NSURL URLWithString:@"https://thethreestooges.cn/consumer/bean/home_page/home_page_show.php"];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    //NSData *jsonData = [NSURLSession dataTaskWithRequest:request completionHandler:nil];
    NSData *jsonData=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *jsonDic=[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    return jsonDic;
}




@end
