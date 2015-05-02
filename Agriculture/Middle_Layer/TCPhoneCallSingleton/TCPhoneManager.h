//
//  TCPhoneManager.h
//  FUCK
//
//  Created by 曾明剑 on 14-1-5.
//  Copyright (c) 2014年 zmj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>

@interface TCPhoneManager : NSObject<UIAlertViewDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

+ (TCPhoneManager *)sharedInstance;

//打电话
- (BOOL)makeCallPhone:(NSString *)phone;

//发短信
- (void)composeMailToRecipients:(NSArray *)recipients withSubject:(NSString *)subject body:(NSString *)body;

//发邮件
- (void)composeMessageToRecipients:(NSArray *)recipients withBody:(NSString *)body;

@end
