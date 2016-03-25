//
//  PlayingCard.m
//  CardMatchingGameWithBean
//
//  Created by Nadine Hachouche on 12/28/15.
//  Copyright © 2015 nadine farah. All rights reserved.
//

#import "PlayingCard.h"

@interface PlayingCard ()

@property (nonatomic, strong) NSMutableArray* matchedCards;


@end

@implementation PlayingCard

-(NSString* )contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit; // because we provide setter AND getter


+ (NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4", @"5", @"6", @"7", @"8", @"9", @"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count]-1;
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

// Assignment 2, Task 3
// This is how the card matches against themselves and returns the score
- (int)match:(NSMutableArray *)cardsToBeMatched;
{
    NSMutableArray* comboOfCards = [self combinationOfCards:cardsToBeMatched];
    
    int rankMatches = 0;
    int suitMatches = 0;
    
    for (NSMutableArray* cardCombo in comboOfCards) {
        PlayingCard* firstCard = cardCombo[0];
        PlayingCard* secondCard = cardCombo[1];
        
        if (firstCard.rank == secondCard.rank) {
            rankMatches += 1;
        }
        
        if (firstCard.suit == secondCard.suit) {
            suitMatches += 1;
        }
    }
    
    if ([comboOfCards count] == 3) {
        if (rankMatches == 3) {
            return 7;
        } else if (suitMatches == 3) {
            return 6;
        } else if (rankMatches == 1) {
            return 4;
        } else if (suitMatches == 1) {
            return 3;
        }
    } else {
        if (rankMatches == 1) {
            return 2;
        } else if (suitMatches == 1) {
            return 1;
        }
    }

    return 0;
}

-(NSMutableArray *)combinationOfCards: (NSMutableArray *)cardsToGenerateCombos
{
    NSMutableArray* cardCombo = [NSMutableArray new];
    for (int x = 0; x < [cardsToGenerateCombos count] - 1; x++) {
        for (int y = x + 1; y < [cardsToGenerateCombos count]; y++) {
            [cardCombo addObject:@[cardsToGenerateCombos[x], cardsToGenerateCombos[y]]];
        }
    }
    
    return cardCombo;
}

@end
