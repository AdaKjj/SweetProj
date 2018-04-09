//
//  PreViewDDListManager.m
//  SweetProj
//
//  Created by 殷婕 on 2018/3/7.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import "PreViewDDListManager.h"

@interface PreViewDDListManager () {
    NSMutableData *buff;   //暂存响应的数据
}
@end

@implementation PreViewDDListManager

- (void)sendRequestWithCity:(NSString *)city{
    //第一步，创建url
    NSURL *url = [NSURL URLWithString:@"https://thethreestooges.cn:666/application/searching/select_show.php"];
    NSString *sendString = nil;
    sendString = [NSString stringWithFormat:@"city=%@",city];
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
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:buff options:NSJSONReadingMutableContainers error:nil] ;
    NSDictionary *value = (NSDictionary *)[jsonDic objectForKey:@"liist"];
    if (value != nil){
        [_foodPreviewVC getDDMenuArr:value];
    }
}
//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    DLog(@"%@",[error localizedDescription]);
}

@end
