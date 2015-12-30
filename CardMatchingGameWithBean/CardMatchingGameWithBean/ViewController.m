//
//  ViewController.m
//  CardMatchingGameWithBean
//
//  Created by Nadine Hachouche on 12/22/15.
//  Copyright © 2015 nadine farah. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "Card.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property(nonatomic) NSInteger flipsCount;


@property(strong, nonatomic) PlayingCardDeck *deck;

@end

@implementation ViewController

-(PlayingCardDeck *)deck
{
    if (!(_deck)) {
        _deck = [[PlayingCardDeck alloc] init];
    }
    return _deck;
}


-(void)setFlipsCount:(NSInteger)flipsCount
{
    if (flipsCount) {
        _flipsCount = flipsCount;
        self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %ld", self.flipsCount];
        NSLog(@"Flips:%ld", self.flipsCount);
    }
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    
    if ([sender.currentTitle length]) {
     
        [sender setBackgroundImage:[UIImage imageNamed:@"pt-back-card.png"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
        Card *card = [self.deck drawRandomCard];
        if (card) {
        [sender setBackgroundImage:[UIImage imageNamed:@"pt-front-card.png"]
                          forState:UIControlStateNormal];
        [sender setTitle:[card contents] forState:UIControlStateNormal];
    
        }
    }
    self.flipsCount++;

} 

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

@end
