//
//  ViewController.m
//  Twitterizer
//
//  Created by Wong You Jing on 13/01/2016.
//  Copyright © 2016 NoNonsense. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *charCount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.delegate = self;
}

- (IBAction)twitterizeButtonTapped:(id)sender {
    NSString *text = [self.textView.text lowercaseString];
    NSMutableString *mutableText = [[NSMutableString alloc]init];
    NSUInteger length = text.length;
    
    for (int i = 0; i < length; i++) {
        if([text characterAtIndex:i] == 'a'){
            continue;
        }
        if([text characterAtIndex:i] == 'e'){
            continue;
        }
        if([text characterAtIndex:i] == 'i'){
            continue;
        }
        if([text characterAtIndex:i] == 'o'){
            continue;
        }
        if([text characterAtIndex:i] == 'u'){
            continue;
        }
        [mutableText appendString:[NSString stringWithFormat:@"%c", [self.textView.text characterAtIndex:i] ]];
    }
    
    self.textView.text = mutableText;
    
}

//- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if(textView.text.length >= 140){
//        return NO;
//    }
//    else{
//        return YES;
//    }
//}

- (void)textViewDidChange:(UITextView *)textView{
    if(self.textView.text.length > 140){
        self.textView.text = [self.textView.text substringToIndex:140];
    }
    
    self.charCount.text = [NSString stringWithFormat:@"Chars typed: %lu", self.textView.text.length ];
}

@end
