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


- (IBAction)hashtagButtonTapped:(id)sender {
    NSArray *sentence = [self.textView.text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    sentence = [sentence filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
    NSMutableArray *hashtagSentence = [NSMutableArray new];

    NSString *joinedSentence  = [sentence componentsJoinedByString:@" "];

    NSUInteger charsRemaining = 140 - joinedSentence.length;



    for(int i = 0; i < sentence.count; i++){

        NSString *word = [sentence objectAtIndex:i];
        NSLog(@"word in sentence is %@", word);

        if (i % 2 == 1 && [word characterAtIndex:0] != '#' && charsRemaining > 0){
            [hashtagSentence addObject:[NSString stringWithFormat:@"#%@", word]];
            charsRemaining--;
            NSLog(@"%lu", charsRemaining);
        }
        else{
            [hashtagSentence addObject:word];
        }
    }
    NSString *joinedHashtagString  = [hashtagSentence componentsJoinedByString:@" "];

    self.textView.text = joinedHashtagString;
}



- (void)textViewDidChange:(UITextView *)textView{
    if(self.textView.text.length > 140){
        self.textView.text = [self.textView.text substringToIndex:140];
    }
    
    self.charCount.text = [NSString stringWithFormat:@"Chars typed: %lu", self.textView.text.length ];
}

- (IBAction)reverseButtonTapped:(id)sender {
    NSArray *sentence = [self.textView.text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    sentence = [sentence filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
    NSMutableArray *addReverse = [NSMutableArray new];

    for (int i = 0 ; i < sentence.count; i++) {
        NSString *word = [sentence objectAtIndex:i];

        if ([word characterAtIndex:0] != '#'){
            NSMutableString *reverse = [NSMutableString stringWithString:@""];


            for(int i = 0; i < word.length; i++){
                [reverse appendFormat:@"%c",[word characterAtIndex:(word.length-1)-i]];
            }

            [addReverse addObject:reverse];
        }
        else{
            [addReverse addObject:word];
        }
    }
    NSString *joinedReverseString  = [addReverse componentsJoinedByString:@" "];
    self.textView.text = joinedReverseString;
}

@end
