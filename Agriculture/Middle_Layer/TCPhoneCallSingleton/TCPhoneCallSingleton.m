//
//  TCPhoneCallSingleton.m
//  jojo
//
//  Created by ChenQi on 12-11-25.
//  Copyright (c) 2012年 TCGROUP. All rights reserved.
//

#import "TCPhoneCallSingleton.h"


static TCPhoneCallSingleton *_instance = nil;
static UIWebView *_phoneCallWebView; // 作为电话返回的容器


@interface TCPhoneCallSingleton ()

@property(nonatomic,strong) UIWebView *phoneCallWebView;

@end

@implementation TCPhoneCallSingleton


+ (id)sharePhoneCall
{
    @synchronized(self)
    {
        if (nil == _instance)
        {
            _instance = [[super allocWithZone:NULL] init];
        }
    }
    return _instance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharePhoneCall];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}



#pragma mark - getter



+ (BOOL)makePhoneCall:(NSString *)phoneNum
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

+ (BOOL)sendSMS:(UIViewController *)target phoneNum:(NSArray *)phoneNum
{
    BOOL couldSend = NO;
    
    if (nil == phoneNum || phoneNum.count < 1)
    {
        return couldSend ;
    }
    
    couldSend = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"sms:"]];
    if (!couldSend)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        Class smsClass = NSClassFromString(@"MFMessageComposeViewController");
        
        if (nil != smsClass && [smsClass canSendText])
        {
            //跳到 短信 界面
            [self launchMessageAppOnController:target phoneNum:phoneNum];
        }
        else
        { // TODO: 未完成群发短信
            [self launchMessageAppOnDevice:[phoneNum objectAtIndex:0]];
        }
    }
    
    return couldSend;
}

+ (BOOL)sendEmails:(UIViewController *)target email:(NSArray *)email
{
    BOOL couldSend = NO;
    
    if (nil == email || email.count < 1)
    {
        return couldSend;
    }
    
    couldSend = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mailto:"]];
    
    if (couldSend)
    {
        Class mailClass = NSClassFromString(@"MFMailComposeViewController");
        
        if (nil != mailClass && [mailClass canSendMail])
        {
            [self launchEmailAppOnController:target email:email];
        }
        else
        { // TODO: 未完成群发邮件
            [self launchMailAppOnDevice:[email objectAtIndex:0]];
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持邮件功能"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
    
    return couldSend;
}

// 调用程序内 短信 界面，支持 4.0 以及 以上
+ (void)launchMessageAppOnController:(UIViewController *)target phoneNum:(NSArray *)phoneNums
{
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    picker.messageComposeDelegate = [self sharePhoneCall];
    picker.recipients = phoneNums;
    //picker.navigationBar.tintColor =[UIColor colorWithRed:97/255.0 green:59/255.0 blue:42/255.0 alpha:1];
    if ([target respondsToSelector:@selector(presentViewController:animated:completion:)])
    {
        [target presentViewController:picker animated:YES completion:nil];
    }
    else
    {
        //[target presentModalViewController:picker animated:YES];
    }
}

+ (void)launchMessageAppOnDevice:(NSString *)phoneNum
{
    NSString *smsStr = [@"sms://" stringByAppendingString:phoneNum];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:smsStr]];
}

+ (void)launchEmailAppOnController:(UIViewController *)target email:(NSArray *)emails
{
    // 4.0 版本以上才支持
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = [self sharePhoneCall];
    //picker.navigationBar.tintColor =[UIColor colorWithRed:97/255.0 green:59/255.0 blue:42/255.0 alpha:1];
    [picker setToRecipients:emails];
    [picker setMessageBody:nil isHTML:NO];
    if ([target respondsToSelector:@selector(presentViewController:animated:completion:)])
    {
        [target presentViewController:picker animated:YES completion:nil];
    }
}


// 跳出 程序 外 的 emil sender
+ (void)launchMailAppOnDevice:(NSString *)email
{
    NSString *recipients = email;
    NSString *body = @"";
    NSString *_email = [NSString stringWithFormat:@"mailto://%@%@", recipients, body];
    _email = [_email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_email]];
}



#pragma mark - MFMessageComposeViewControllerDelegate

// 发送 短信结果 响应
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result)
	{
		case MessageComposeResultCancelled:  // 退出发送
			break;
            
		case MessageComposeResultSent:  // 发送
			break;
            
		case MessageComposeResultFailed:  // 发送失败
			break;
            
		default:
			break;
	}
	
    if ([controller respondsToSelector:@selector(dismissViewControllerAnimated:completion:)])
    {
        [controller dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        //[controller dismissModalViewControllerAnimated:YES];
    }

}


#pragma mark MFMailComposeViewController

// 发送邮件
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
		case MFMailComposeResultCancelled: // 退出
            break;
            
        case MFMailComposeResultSaved: // 邮件 保存
            break;
            
        case MFMailComposeResultSent: //邮件 发送
            break;
            
        case MFMailComposeResultFailed: // 邮件 发送失败
            break;
            
        default:
            break;
    }

    if ([controller respondsToSelector:@selector(dismissViewControllerAnimated:completion:)])
    {
        [controller dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        //[controller dismissModalViewControllerAnimated:YES];
    }
}


@end
