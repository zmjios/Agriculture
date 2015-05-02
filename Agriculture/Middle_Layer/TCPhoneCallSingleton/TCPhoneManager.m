//
//  TCPhoneManager.m
//  FUCK
//
//  Created by 曾明剑 on 14-1-5.
//  Copyright (c) 2014年 zmj. All rights reserved.
//

#import "TCPhoneManager.h"

static UIWebView *_phoneCallWebView; // 作为电话返回的容器

@implementation TCPhoneManager

+ (TCPhoneManager *)sharedInstance
{
    static TCPhoneManager  *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

#pragma mark - Compose Mail and SMS

- (BOOL)makeCallPhone:(NSString *)phoneNum
{
    BOOL couldSend = NO;
    
    if (nil == phoneNum || phoneNum.length < 1)
    {
        return couldSend;
    }
    
    couldSend = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel:"]];
    
    if (!couldSend)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持电话功能"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", phoneNum]];
        
        if (nil == _phoneCallWebView)
        {
            _phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
        }
        
        [_phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
    }
    
    return couldSend;
}

- (void)composeMailToRecipients:(NSArray *)recipients withSubject:(NSString *)subject body:(NSString *)body{
    if (![MFMailComposeViewController canSendMail])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持邮件功能"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    MFMailComposeViewController *composeVC = [[MFMailComposeViewController alloc] init];
	composeVC.mailComposeDelegate = self;
    if (recipients) [composeVC setToRecipients:recipients];
    if (subject) [composeVC setSubject:subject];
    if (body) [composeVC setMessageBody:body isHTML:NO];
	[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:composeVC animated:YES completion:NULL];
}

- (void)composeMessageToRecipients:(NSArray *)recipients withBody:(NSString *)body{
    if (![MFMessageComposeViewController canSendText])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    MFMessageComposeViewController *composeVC = [[MFMessageComposeViewController alloc] init];
	composeVC.messageComposeDelegate = self;
    if (recipients) [composeVC setRecipients:recipients];
    if (body) [composeVC setBody:body];
	[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:composeVC animated:YES completion:NULL];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    switch (result) {
        case MessageComposeResultCancelled:
            //
            break;
        case MessageComposeResultSent:
            //
            break;
        case MessageComposeResultFailed:
            //
            break;
        default:
            break;
    }
    [controller dismissViewControllerAnimated:YES completion:NULL];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result) {
        case MFMailComposeResultCancelled:
            //
            break;
        case MFMailComposeResultSaved:
            //
            break;
        case MFMailComposeResultSent:
            //
            break;
        case MFMailComposeResultFailed:
            //
            break;
            
        default:
            break;
    }
    [controller dismissViewControllerAnimated:YES completion:NULL];
}


@end
