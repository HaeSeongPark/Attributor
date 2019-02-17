//
//  TextStatusViewController.m
//  Attributor
//
//  Created by rhino Q on 17/02/2019.
//  Copyright © 2019 rhino Q. All rights reserved.
//

#import "TextStatusViewController.h"

@interface TextStatusViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorfulCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharactersLabel;

@end

@implementation TextStatusViewController

- (void)setTextToAnalyze:(NSAttributedString *)textToAnalyze {
    _textToAnalyze = textToAnalyze;
    
    if ( self.view.window ) [self updateUI];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}

- (NSAttributedString *)chracterWithAttribute:(NSString *)attributeName {
    NSMutableAttributedString *characters = [NSMutableAttributedString new];
    
    int index = 0;
    while ( index < [self.textToAnalyze length] ) {
        NSRange range;
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        if ( value ) {
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = (int)range.location + (int)range.length;
        } else {
            index++;
        }
    }
    
    return characters;
}

-(void) updateUI {
    self.colorfulCharactersLabel.text = [NSString stringWithFormat:@"%d colorful chracters",
                                         (int)[[self chracterWithAttribute:NSForegroundColorAttributeName] length]];
    self.outlinedCharactersLabel.text = [NSString stringWithFormat:@"%d colorful chracters",
                                         (int)[[self chracterWithAttribute:NSStrokeWidthAttributeName] length]];
}

@end
