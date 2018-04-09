//
//  WeatherManager.m
//  SweetProj
//
//  Created by 殷婕 on 2018/3/14.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import "WeatherManager.h"

@interface WeatherManager ()
{
    NSMutableData *buff;   //暂存响应的数据
}
@end

@implementation WeatherManager

- (void)sendRequestWithCity:(NSString *)city{
    //第一步，创建url
    NSString *requestString = [NSString stringWithFormat:@"https://free-api.heweather.com/s6/weather/now?key=e14dc2b9f04d4a84b467f7f43e3137f2&location=%@",city];
    requestString = [requestString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:requestString];
    //第二步，创建请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //第三步，连接服务器
    [NSURLConnection connectionWithRequest:request delegate:self];
}

//接收到服务器回应的时候调用此方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
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
    NSDictionary *dictmp = (NSDictionary *)[jsonDic valueForKey:@"HeWeather6"];
    
    NSDictionary *basicDic = [dictmp valueForKey:@"basic"];
    NSString *lat = [[basicDic valueForKey:@"lat"] firstObject];
    NSString *lon = [[basicDic valueForKey:@"lon"] firstObject];
    NSString *city = [[basicDic valueForKey:@"location"] firstObject];
    
    NSDictionary *nowDic = [dictmp valueForKey:@"now"];
    NSString *condCode = [[nowDic valueForKey:@"cond_code"] firstObject];
    NSString *condTxt = [[nowDic valueForKey:@"cond_txt"] firstObject];
    NSString *tmp = [[nowDic valueForKey:@"tmp"] firstObject];
    
    if (lat){
        [_mainVC getWeathertmp:tmp condTxt:condTxt condCode:condCode lat:lat lon:lon city:city];
    }
}
//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    DLog(@"%@",[error localizedDescription]);
}

@end
