//
//  PDFTempToolbar.m
//  PDFReader
//
//  Created by fangshufeng on 2018/7/10.
//  Copyright © 2018 fangshufeng. All rights reserved.
//

#import "PDFTempToolbar.h"

@implementation PDFTempToolbar

+ (instancetype)toolbar {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (IBAction)actions:(UIButton *)sender {
    if (self.actionsTypes) {
        self.actionsTypes(sender.tag);
    }
}

@end
