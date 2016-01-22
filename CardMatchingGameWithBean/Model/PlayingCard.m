//
//  PlayingCard.m
//  CardMatchingGameWithBean
//
//  Created by Nadine Hachouche on 12/28/15.
//  Copyright © 2015 nadine farah. All rights reserved.
//

#import "PlayingCard.h"

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


- (int)match:(NSArray *)otherCards;
{
    int score = 0;
    PlayingCard *card1 = otherCards[0];
    PlayingCard *card2 = otherCards[1];
    
    NSLog(@"HI");
    
    if([otherCards count] == 2){
        if(card1.rank == card2.rank){
            score = 4;
            NSLog(@"rank matched %ld, %ld", card1.rank, card2.rank);
        } else if(card1.suit == card2.suit) {
            score = 1;
            NSLog(@"suit matched %@, %@", card1.suit, card2.suit);
        }
    }
    
    if ([otherCards count] == 3 ) {
        NSLog(@"3-CARD GAME MATCH");
        score = 1;
    }
    
    //NSLog(@"suit matched %@, %@", card1.suit, card2.suit);
    
    NSLog(@"SCORE IS: %d", score);
    return score;

}


@end

