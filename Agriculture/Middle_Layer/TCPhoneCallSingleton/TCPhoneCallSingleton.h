//
//  TCPhoneCallSingleton.h
//  jojo
//
//  Created by ChenQi on 12-11-25.
//  Copyright (c) 2012年 TCGROUP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>

@interface TCPhoneCallSingleton : NSObject <MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate>

+ (id)sharePhoneCall;

// 打电话
+ (BOOL)makePhoneCall:(NSString *)phoneNum;
// 发短信
+ (BOOL)sendSMS:(UIViewController *)target phoneNum:(NSArray *)phoneNum;
// 发邮件
+ (BOOL)sendEmails:(UIViewController *)target email:(NSArray *)email;


@end
