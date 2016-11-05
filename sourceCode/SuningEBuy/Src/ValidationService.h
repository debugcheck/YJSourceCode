//
//  ValidationService.h
//  SuningEBuy
//
//  Created by shasha on 12-8-27.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
	
/*!
 
 @header   ValidationService
 @abstract 字符串的各种验证信息（中文字符，特殊字符，位数，字母等等）
 @author   莎莎 
 @version  4.3  2012/08/27 Creation (此文档的版本信息)
 
 */

#define ErrorWithSuccessInfo(errorCode) [NSError errorWithDomain:kValidationErrorDomain code:errorCode userInfo:nil]; //YJ
#define ErrorWithErrorCodeAndDesc(errorCode,errorDesc,errorDescKey)  [NSError errorWithDomain:kValidationErrorDomain code:errorCode userInfo:[NSDictionary dictionaryWithObject:errorDesc forKey:errorDescKey]];//YJ
#define kValidationSuccess     1
#define kValidationFail        0//YJ

#define kValidationErrorDomain @"ValideError" //YJ

#define kValidationErrorDesc_Key   @"ErrorDesc"//YJ



#define kValidationErrorDesc_Error_Null       @"Error_Null"
#define kValidationErrorDesc_Error_NotValide  @"Error_NotValide"
#define kValidationErrorDesc_Error_Length     @"Error_Length"


#import <Foundation/Foundation.h>

/*!
 @abstract     字符串的验证
 @discussion   返回值NSError。通过errorCode判定成功还是失败，ErrorDesc：描述错误原因。
 */
@interface ValidationService : NSObject


+ (BOOL)checkBoardPersonName:(NSString *)name;
+ (NSError *)chineseChecking:(NSString *)chinese Frome:(NSInteger)minBit To:(NSInteger)maxBit;
+ (NSError *)NumOrCharacterChecking:(NSString *)checkedString;
+ (NSError *)NumAndCharacterChecking:(NSString *)checkingString  minBit:(NSInteger)minBit maxBit:(NSInteger)maxBit;

+ (NSError *)phoneNumChecking:(NSString *)checkedString;



+ (NSError *)valideIdentifyCard:(NSString *)identifyString;

@end
