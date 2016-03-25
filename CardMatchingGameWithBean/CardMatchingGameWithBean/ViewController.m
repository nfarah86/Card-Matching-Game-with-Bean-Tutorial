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
#import "CardMatchingGame.h"

@interface ViewController () <CardMatchingGameDelegate>



@property(strong, nonatomic) PlayingCardDeck *deck;
@property(nonatomic) CardMatchingGame* game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameDescriptionLabel;

@property (weak, nonatomic) IBOutlet UIButton *dealButton;

// Assignment 2, Task 3
// Dragged UISegmentedIndex from UI to ViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


-(PlayingCardDeck *)deck
{
    // Every time someone deals a deck or chooses a game, we will
    // just create a new deck; so the deck is never exhausted
    return [[PlayingCardDeck alloc] init];
}


-(CardMatchingGame *) game{
    if (! _game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self deck]];
        // We assign ourselves as the delegate
        _game.delegate = self;
    }
    
    return _game;
}


- (IBAction)touchCardButton:(UIButton *)sender
{

    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    // Assignment 2, Task 4
    [self.segmentedControl setEnabled: NO];
    
    // Assignment 2, Task 3
    // modified chooseCardAtIndex: method to include the segmentedControl index that indicates which game the user want to play
    
    NSInteger segmentIndex = [self.segmentedControl selectedSegmentIndex];
    [self.game chooseCardAtIndex:(NSUInteger)cardIndex getSegmentedControlIndex: (NSInteger) segmentIndex];
    [self updateUI];

}


-(void)updateUI
{
    for (UIButton* cardButton in self.cardButtons){
        NSInteger cardIndex = [self.cardButtons indexOfObject:cardButton]; //cardButton is a card object
        Card *card = [self.game cardAtIndex:cardIndex];        
        [cardButton setTitle: [self titleForCard:card] forState: UIControlStateNormal];
        [cardButton setBackgroundImage: [self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.matched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
    }
}


-(NSString*) titleForCard: (Card *) card
{
    // return card.isChosen ? card.contents : @"";
    return card.chosen ? @"": card.contents;

}


-(UIImage*) backgroundImageForCard: (Card *) card
{
    // return [UIImage imageNamed:(card.isChosen) ? @"plainCard" : @"pt-back-card.png"];
    return [UIImage imageNamed:(card.chosen) ? @"pt-back-card.png" : @"plainCard"];
}


// Assignment 2, Task 2
- (IBAction)clickOnDeal:(UIButton *)sender
{
    if(sender) {
        self.game = nil;
        // Assignment 2, Task 4
        [self.segmentedControl setEnabled: YES];
        [self updateUI];
    }
}


// Assignment 2, Task 3
// This method gets the segmentIndex of what game is played
- (IBAction)pickMatchGame:(UISegmentedControl *)sender
{
    if (sender) {
        self.game = nil;
        [self.segmentedControl setEnabled: NO];
        [self updateUI];
    }
}


-(void)gameDescription:(NSMutableArray* ) pickedCards didCardsMatch: (BOOL) status
{
    
    // NSLog(@"these are the cards matched cound %d", status);
    
    if (status) {
        
       NSMutableString* labelDescription = [[NSMutableString alloc]initWithString:@"Matched: "];
        for (int i = 0; i < [pickedCards count]; i+= 1)
        {
            PlayingCard* matchingCard = pickedCards[i];
            [labelDescription appendFormat:@"%ld%@ and ", matchingCard.rank, matchingCard.suit];
        }
        NSString* newLabelDescription = [NSString stringWithString:labelDescription];
        NSRange replaceAnd= [labelDescription rangeOfString:@"and " options:NSBackwardsSearch];
        if (replaceAnd.location != NSNotFound)
        {
            newLabelDescription = [newLabelDescription stringByReplacingCharactersInRange:replaceAnd withString:@""];
        }
        self.gameDescriptionLabel.text = newLabelDescription;
    } else {
            self.gameDescriptionLabel.text = @"Sorry, No Matches";
    }
}

@end
