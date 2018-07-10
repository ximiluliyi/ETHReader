//
//  PDFRBookListController.m
//  PDFReader
//
//  Created by fangshufeng on 2018/7/10.
//  Copyright © 2018 fangshufeng. All rights reserved.
//

#import "ETHRBookListController.h"
#import "ETHRScanViewController.h"

@interface ETHRBookListController ()

@end

@implementation ETHRBookListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图书列表";
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 200, 40)];
    [btn setTitle:@"点击查看demo——pdf" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    @weakify(self);
    [btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        @strongify(self);
        ETHRScanViewController *vc = [[ETHRScanViewController alloc] init];
        vc.documentName = @"demo";
        [self.navigationController pushViewController:vc animated:YES];
    }];
}


@end
