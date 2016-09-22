//
//  TextStatsViewController.m
//  Attributor
//
//  Created by Dishant Kapadiya on 8/8/16.
//  Copyright © 2016 Dishant Kapadiya. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *coloredCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharactersLabel;

@end

@implementation TextStatsViewController


-(void)setTextToAnalyze:(NSAttributedString *)textToAnalyze{
    _textToAnalyze = textToAnalyze;
    if (self.view.window) [self updateUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

-(NSAttributedString *) charactersWithAtrributes: (NSString*) attributeName{
    NSMutableAttributedString* characters = [[NSMutableAttributedString alloc] init];
    int index = 0;
    
    while(index < [self.textToAnalyze length]){
        NSRange rng;
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&rng];
        if (value){
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:rng]];
            index += rng.location + rng.length;
        } else {
            index++;
        }
    }
    return characters;
}

-(void)updateUI
{
    self.coloredCharactersLabel.text = [NSString stringWithFormat:@"%lu colorful characters", (unsigned long)[[self charactersWithAtrributes:NSForegroundColorAttributeName] length]];
    self.outlinedCharactersLabel.text = [NSString stringWithFormat:@"%lu outlined characters", (unsigned long)[[self charactersWithAtrributes:NSStrokeWidthAttributeName] length]];
}

@end
