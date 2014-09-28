//
//  XMLReader.h
//
//

#import <Foundation/Foundation.h>

@interface XMLReader : NSObject <NSXMLParserDelegate>
{
    NSMutableArray *dictionaryStack;
    NSMutableString *textInProgress;
    __autoreleasing NSError **errorPointer;
}
/**
 *  从本地拿xml文件边转成字典格式
 *
 *  @param path         xml所在的位置
 *  @param errorPointer 解析错误的指针
 *
 *  @return 解析后的字典格式数据
 */
+ (NSDictionary *)dictionaryForPath:(NSString *)path error:(NSError **)errorPointer;
/**
 *  把xml从NSData转成字典格式
 *
 *  @param data         需要转换的xml的data数据
 *  @param errorPointer 错误指针
 *
 *  @return xml以data的格式存储，这里可以把这样的data转换成字典格式
 */
+ (NSDictionary *)dictionaryForXMLData:(NSData *)data error:(NSError **)errorPointer;
/**
 *  把xml从NSString转成字典格式
 *
 *  @param string       需要转换的xml的string数据
 *  @param errorPointer 错误指针
 *
 *  @return xml以string的格式存储，这里可以把这样的data转换成字典格式
 */
+ (NSDictionary *)dictionaryForXMLString:(NSString *)string error:(NSError **)errorPointer;
/**
 *  对dictionaryForPath:的补充
 *
 *  @param path         xml所在的位置（全路径）
 *  @param errorPointer 错误指针
 *
 *  @return 解析后的字典格式数据
 */
+ (NSDictionary *)dictionaryForFullPath:(NSString *)path error:(NSError **)errorPointer;
@end

@interface NSDictionary (XMLReaderNavigation)

- (id)retrieveForPath:(NSString *)navPath;

@end