//
//  SandBoxFile.m
//  EBook
//
//  Created by zmj on 13-7-2.
//  Copyright (c) 2013年 TCGROUP. All rights reserved.
//

#import "SandBoxFile.h"

@implementation SandBoxFile

/*
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 ＊获取程序的Home目录路径
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 */
+(NSString *)GetHomeDirectoryPath
{
    return NSHomeDirectory();
}
/*
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 ＊获取document目录路径
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 */
+(NSString *)GetDocumentPath
{
    NSArray *Paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [Paths objectAtIndex:0];
    return path;
}
/*
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 ＊获取Cache目录路径
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 */
+(NSString *)GetCachePath
{
    NSArray *Paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [Paths objectAtIndex:0];
    return path;
}
/*
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 ＊获取Library目录路径
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 */
+(NSString *)GetLibraryPath
{
    NSArray *Paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [Paths objectAtIndex:0];
    return path;
}
/*
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 ＊获取Tmp目录路径
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 */
+(NSString *)GetTmpPath
{
    return NSTemporaryDirectory();
}
/*
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 ＊返回Documents下的指定文件路径(加创建)
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 */
+(NSString *)GetDirectoryForDocuments:(NSString *)dir
{
    NSError* error;
    NSString* path = [[self GetDocumentPath] stringByAppendingPathComponent:dir];
    if(![[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error])
    {
        NSLog(@"create dir error: %@",error.debugDescription);
    }
    return path;
}
/*
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 ＊返回Caches下的指定文件路径
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 */
+(NSString *)GetDirectoryForCaches:(NSString *)dir
{
    NSError* error;
    NSString* path = [[self GetCachePath] stringByAppendingPathComponent:dir];
    
    if(![[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error])
    {
        NSLog(@"create dir error: %@",error.debugDescription);
    }
    return path;
}
/*
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 ＊创建目录文件夹
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 */
+(NSString *)CreateList:(NSString *)List ListName:(NSString *)Name
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSString *FileDirectory=[List stringByAppendingPathComponent:Name];
    if ([self IsFileExists:Name])
    {
        NSLog(@"exist,%@",Name);
    }
    else
    {
        [fileManager createDirectoryAtPath:FileDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return FileDirectory;
}
/*
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 ＊写入NSArray文件
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 */
+(BOOL)WriteFileArray:(NSArray *)ArrarObject SpecifiedFile:(NSString *)path
{
    return [ArrarObject writeToFile:path atomically:YES];
}
/*
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 ＊写入NSDictionary文件
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 */
+(BOOL)WriteFileDictionary:(NSMutableDictionary *)DictionaryObject SpecifiedFile:(NSString *)path
{
    return [DictionaryObject writeToFile:path atomically:YES];
}
/*
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 ＊是否存在该文件
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 */
+(BOOL)IsFileExists:(NSString *)filepath
{
    return [[NSFileManager defaultManager] fileExistsAtPath:filepath];
}
/*
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 ＊删除指定文件
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 */
+(BOOL)DeleteFile:(NSString *)filepath
{
    if([[NSFileManager defaultManager] fileExistsAtPath:filepath])
    {
        return  [[NSFileManager defaultManager] removeItemAtPath:filepath error:nil];
    }else
    {
        NSLog(@"删除失败");
        return NO;
    }
}
/*
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 ＊获取目录列表里所有的文件名
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 */
+(NSArray *)GetSubpathsAtPath:(NSString *)path
{
    NSFileManager *fileManage = [NSFileManager defaultManager];
    NSArray *file = [fileManage subpathsAtPath:path];
    return file;
}

//删除 document/dir 目录下 所有文件
+(void)deleteAllForDocumentsDir:(NSString *)dir
{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:[self GetDirectoryForDocuments:dir] error:nil];
    for (NSString* filename in fileList) {
        [fileManager removeItemAtPath:[self GetPathForDocuments:filename inDir:dir] error:nil];
    }
}

//写入图片
+ (BOOL)WriteImage:(UIImage *)image inPath:(NSString *)path
{
   return  [UIImageJPEGRepresentation(image, 1) writeToFile:path atomically:YES];
}


#pragma mark- 获取文件的数据
+(NSData *)GetDataForPath:(NSString *)path
{
    return [[NSFileManager defaultManager] contentsAtPath:path];
}
+(NSData *)GetDataForResource:(NSString *)name inDir:(NSString *)dir
{
    return [self GetDataForPath:[self GetPathForResource:name inDir:dir]];
}
+(NSData *)GetDataForDocuments:(NSString *)name inDir:(NSString *)dir
{
    return [self GetDataForPath:[self GetPathForDocuments:name inDir:dir]];
}



#pragma mark- 获取文件路径
+(NSString *)GetPathForResource:(NSString *)name
{
    return [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:name];
}
+(NSString *)GetPathForResource:(NSString *)name inDir:(NSString *)dir
{
    return [[[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:dir] stringByAppendingPathComponent:name];
}
+ (NSString *)GetPathForDocuments:(NSString *)filename
{
    return [[self GetDocumentPath] stringByAppendingPathComponent:filename];
}
+(NSString *)GetPathForDocuments:(NSString *)filename inDir:(NSString *)dir
{
    return [[self GetDirectoryForDocuments:dir] stringByAppendingPathComponent:filename];
}
+(NSString *)GetPathForCaches:(NSString *)filename
{
    return [[self GetCachePath] stringByAppendingPathComponent:filename];
}
+(NSString *)GetPathForCaches:(NSString *)filename inDir:(NSString *)dir
{
    return [[self GetDirectoryForCaches:dir] stringByAppendingPathComponent:filename];
}


@end
