//
//  OSSManager.m
//  SweetProj
//
//  Created by 殷婕 on 2018/4/4.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import "OSSManager.h"

#import <AliyunOSSiOS/OSSService.h>
#import <AliyunOSSiOS/OSSCompat.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonHMAC.h>

#define BUCKETNAME @"thethreestooges"
@interface OSSManager() {
    NSMutableData *buff;
    BOOL finished;
}

@property (nonatomic) NSString *AccessKeySecret;
@property (nonatomic) NSString *AccessKeyId;
@property (nonatomic) NSString *Expiration;
@property (nonatomic) NSString *SecurityToken;

@property (nonatomic) OSSClient *client;
@property (nonatomic) NSData *downloadData;


@end

@implementation OSSManager
- (void)sendRequestToGetOSS{
    
    NSString *requestString = [NSString stringWithFormat:@"https://thethreestooges.cn:5210/identity/oss/token.php"];
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    //连接服务器
    [[NSURLConnection connectionWithRequest:request delegate:self] start];
    
    //开启一个runloop，使它始终处于运行状态
    
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    finished = NO;
    while (!finished)
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
}

//接收到服务器回应的时候调用此方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(nonnull NSURLResponse *)response
{
    NSLog(@"开始啦啦啦啦阿拉");
    buff = [NSMutableData data];
}
//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次
-(void)connection:(NSURLConnection *)connection didReceiveData:(nonnull NSData *)data
{
    [buff appendData:data];
}
//获得了Json
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    finished = YES;
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:buff options:NSJSONReadingMutableContainers error:nil] ;
    NSDictionary *OSSDic = [jsonDic valueForKey:@"Credentials"];
    
    _ossModel = [[OSSSTSModel alloc] initWithDictionary:OSSDic error:nil];
    
    self.AccessKeyId = self.ossModel.AccessKeyId;
    self.AccessKeySecret = self.ossModel.AccessKeySecret;
    self.Expiration = self.ossModel.Expiration;
    self.SecurityToken = self.ossModel.SecurityToken;
}
//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
}

- (void)uploadImage:(UIImage *)image {
    if (!self.AccessKeySecret) {
        [self sendRequestToGetOSS];
        NSString *endpoint = @"http://oss-cn-shenzhen.aliyuncs.com";
        // 明文设置secret的方式建议只在测试时使用，更多鉴权模式参考后面链接给出的官网完整文档的`访问控制`章节
        id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc] initWithAccessKeyId:self.AccessKeyId secretKeyId:self.AccessKeySecret securityToken:self.SecurityToken];
        _client = [[OSSClient alloc] initWithEndpoint:endpoint credentialProvider:credential];
    }
    
    NSData *imageData = nil;
    if (UIImagePNGRepresentation(image)) {
        //返回为png图像。
        UIImage *imagenew = [self imageWithImageSimple:image scaledToSize:CGSizeMake(200, 200)];
        imageData = UIImagePNGRepresentation(imagenew);
    }
    else {
        //返回为JPEG图像。
        UIImage *imagenew = [self imageWithImageSimple:image scaledToSize:CGSizeMake(200, 200)];
        imageData = UIImageJPEGRepresentation(imagenew, 0.1);
    }
    
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    // required fields
    put.bucketName = BUCKETNAME;
    
    // TODO:上传文件的文件名
    NSString *objectKeys = [NSString stringWithFormat:@"/person/portrait/%@.jpg",[self getTimeNow]];
    
    put.objectKey = objectKeys;
    //put.uploadingFileURL = [NSURL fileURLWithPath:fullPath];
    put.uploadingData = imageData;
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };
    OSSTask * putTask = [_client putObject:put];
    
    [putTask continueWithBlock:^id(OSSTask *task) {
        task = [_client presignPublicURLWithBucketName:BUCKETNAME
                                        withObjectKey:objectKeys];
        NSLog(@"objectKey: %@", put.objectKey);
        if (!task.error) {
            NSLog(@"upload object success!");
        }
        else {
            NSLog(@"upload object failed, error: %@" , task.error);
        }
        return nil;
    }];
}

//异步下载 :(NSString *)str
- (void)downloadImageWithName:(NSString *)name
{
    if (!self.ossModel) {
        [self sendRequestToGetOSS];
        NSString *endpoint = @"http://oss-cn-shenzhen.aliyuncs.com";
        // 明文设置secret的方式建议只在测试时使用，更多鉴权模式参考后面链接给出的官网完整文档的`访问控制`章节
        id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc] initWithAccessKeyId:self.AccessKeyId secretKeyId:self.AccessKeySecret securityToken:self.SecurityToken];
        _client = [[OSSClient alloc] initWithEndpoint:endpoint credentialProvider:credential];
    }
    
    OSSGetObjectRequest *request = [OSSGetObjectRequest new];
    
    request.bucketName = BUCKETNAME;
    request.objectKey = name;
    
    //optional
    request.downloadProgress = ^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        NSLog(@"%lld, %lld, %lld", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
    };
    // NSString * docDir = [self getDocumentDirectory];
    // request.downloadToFileURL = [NSURL fileURLWithPath:[docDir stringByAppendingPathComponent:@"downloadfile"]];
    
    OSSTask * getTask = [_client getObject:request];
    
    
    [getTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            //下载成功后作一些处理
            NSLog(@"download image success!");
            OSSGetObjectResult *getResult = task.result;
            _downloadData = getResult.downloadedData;
            if (self.downloadBlock) {
                self.downloadBlock(_downloadData);
            }
        } else {
            //下载失败作一些处理
            NSLog(@"download object failed, error: %@" ,task.error);
        }
        return nil;
    }];
    
}


/**
 *  返回当前时间
 *
 *  @return 当前时间
 */
- (NSString *)getTimeNow
{
    NSString* date;
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYYMMddhhmmssSSS"];
    date = [formatter stringFromDate:[NSDate date]];
    //取出个随机数
    int last = arc4random() % 10000;
    NSString *timeNow = [[NSString alloc] initWithFormat:@"%@-%i", date,last];
    NSLog(@"%@", timeNow);
    return timeNow;
}

/**
 *  压缩图片尺寸
 *
 *  @param image   图片
 *  @param newSize 大小
 *
 *  @return 真实图片
 */
- (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize {
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
