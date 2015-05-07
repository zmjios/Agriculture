//
//  PersonCenterViewController.m
//  Agriculture
//
//  Created by 曾明剑 on 15/5/3.
//  Copyright (c) 2015年 zmj. All rights reserved.
//

#import "PersonCenterViewController.h"
#import "ATHTTPRequestCenter.h"

@interface PersonCenterViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *httpArry;

@end

@implementation PersonCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"个人中心";
    
    
    self.httpArry = @[@"注册",@"登陆"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.httpArry count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellI = @"cellI";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellI];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellI];
    }
    
    // Configure the cell...
    
    cell.textLabel.text = [self.httpArry objectAtIndex:indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
        {
            NSDictionary *dic = @{@"Uid":@"sa56666334",@"Passwd":@"654321"};
            
            [[ATHTTPRequestCenter defaultCenter] requestForRegister:^(TCHTTPRequest *request){
                
                request.observer = self;
                request.requestIdentifier = NSStringFromSelector(@selector(requestForRegister:withParams:));
                
                // You can set delegate here
                //request.delegate = self;
                // or use resultBlock
                request.resultBlock = ^(TCHTTPRequest *request, BOOL successe) {
                    
                    
                    NSLog(@"request.responseObject = %@", request.responseObject);
                };
                
            } withParams:dic];
            
        }
            break;
            
        case 1:
        {
            
            
            break;
            
        }
            
            
        default:
            break;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
