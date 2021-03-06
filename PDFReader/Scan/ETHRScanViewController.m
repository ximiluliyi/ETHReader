//
//  PDFRScanViewController.m
//  PDFReader
//
//  Created by fangshufeng on 2018/7/10.
//  Copyright © 2018 fangshufeng. All rights reserved.
//

#import <PDFKit/PDFKit.h>

#import "ETHRScanViewController.h"
#import "PDFTempToolbar.h"

@interface ETHRScanViewController ()

@property (nonatomic, strong) PDFDocument *pdfdocument;
@property (nonatomic, strong) PDFView *pdfView;

@property (nonatomic, strong) PDFTempToolbar *toolbar;

@end

@implementation ETHRScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.documentName;
    
    NSString *path =  [[NSBundle mainBundle] pathForResource:self.documentName ofType:@"pdf"];
    
    PDFDocument *pdfdocument = [[PDFDocument alloc] initWithURL:[NSURL fileURLWithPath:path]];
    _pdfdocument = pdfdocument;
    
    PDFView *pdfView = [[PDFView alloc] init];
    pdfView.displayMode =  kPDFDisplaySinglePage;
    pdfView.displayDirection = kPDFDisplayDirectionHorizontal;
    pdfView.document = pdfdocument;
    pdfView.frame = CGRectMake(0, 0, self.view.width, self.view.height - 80);
    pdfView.autoScales = YES;
    _pdfView = pdfView;
    [self.view addSubview:pdfView];

    self.toolbar.frame = CGRectMake(0, pdfView.bottom,self.view.width, 80);
    [self.view addSubview:self.toolbar];
}

- (PDFTempToolbar *)toolbar {
    if (!_toolbar) {
        _toolbar = [PDFTempToolbar toolbar];
        @weakify(self);
        _toolbar.actionsTypes = ^(NSInteger type) {
            @strongify(self);
            if (type == 100) {
                if ([self.pdfView canGoToPreviousPage]) {
                    [self.pdfView goToPreviousPage:self.pdfdocument];
                }
            } else if (type == 200) {
                if ([self.pdfView canGoToNextPage]) {
                    [self.pdfView goToNextPage:self.pdfdocument];
                }
            } else if (type == 300) {
                // 可通过定义一个view来定义style
                PDFBorder *border = [[PDFBorder alloc] init];
                border.style = kPDFBorderStyleDashed;
                border.lineWidth = 10;
                PDFAnnotation *annotation = [[PDFAnnotation alloc] initWithBounds:CGRectMake(50, 100, 300, 300) forType:PDFAnnotationSubtypeCircle withProperties:@{PDFAnnotationKeyColor:[UIColor redColor]}];
                annotation.border = border;
                [[self.pdfView currentPage] addAnnotation:annotation];
            
            } else if (type == 400) {
               
                PDFAnnotation *annotation = [[PDFAnnotation alloc] initWithBounds:CGRectMake(50, 100, 300, 300) forType:PDFAnnotationSubtypeFreeText withProperties:@{PDFAnnotationKeyContents:@"test"}];
                [[self.pdfView currentPage] addAnnotation:annotation];
             
            }
        };
    }
    return _toolbar;
}

@end
