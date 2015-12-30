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

//Assignment: 1
//create a property of type Deck type called _game
@property(strong, nonatomic) PlayingCardDeck *deck;

@end

@implementation ViewController


//Assignment: 1
//lazy instatiation of deck of cards
//if there is no deck, create it
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
    
    //Assignment: 1
    // Everytime the user clicks on a card, we will draw a random card
    // We use the instance of our deck that we will draw from
    // We return a Card type
    Card *card = [self.deck drawRandomCard];
    
    if ([sender.currentTitle length]) {
        // show the back of a card
        [sender setBackgroundImage:[UIImage imageNamed:@"pt-back-card.png"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
        [sender setBackgroundImage:[UIImage imageNamed:@"pt-front-card.png"]
                          forState:UIControlStateNormal];
        
        //Assignment: 1
        //We created contents that returns a string of rank + suit
        //We implement that method so we don't have to manually type (@"%@, %@",card.rank, card.suit);
        [sender setTitle:[card contents] forState:UIControlStateNormal];

    }
    
    self.flipsCount++;

} 

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

@end
