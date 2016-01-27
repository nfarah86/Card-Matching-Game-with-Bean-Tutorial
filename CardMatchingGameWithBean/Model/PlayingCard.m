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

- (int)match:(NSArray *)otherCards;
{
    int score = 0;
    
    // This is how a 2-card game matches against itself
    if([otherCards count] == 2){
        if([otherCards[0]rank] == [otherCards[1]rank]){
            score = 4;
        } else if([otherCards[0]suit] == [otherCards[0]suit]) {
            score = 1;
        }
    }
    
    // This is how a 3-card game matches against itself
    if ([otherCards count] == 3 ) {
        
         if(!(self.matchedCards)) self.matchedCards = [NSMutableArray new];
        
        
        // We check to see if there are matches
        for (int i = 0; i <= ([otherCards count]-1); i++) {
            for (int j= 1; j<= ([otherCards count]-1); j++) {
                if (i != j) {
                    PlayingCard* firstCard = otherCards[i];
                    PlayingCard* secondCard = otherCards[j];
                
                        if (firstCard.rank == secondCard.rank) {
                        
                            if ([self.matchedCards count] == 0) {
                                [self.matchedCards addObject:firstCard];
                                [self.matchedCards addObject:secondCard];
                            } else if (![self.matchedCards containsObject:firstCard]) {
                                [self.matchedCards addObject:firstCard];
                            } else if (![self.matchedCards containsObject:secondCard]) {
                                [self.matchedCards addObject:secondCard];
                            }
                            
                        } else if(firstCard.suit == secondCard.suit) {
                            if ([self.matchedCards count] == 0) {
                                [self.matchedCards addObject:firstCard];
                                [self.matchedCards addObject:secondCard];
                            } else if (![self.matchedCards containsObject:firstCard]) {
                                [self.matchedCards addObject:firstCard];
                            } else if (![self.matchedCards containsObject:secondCard]) {
                                [self.matchedCards addObject:secondCard];
                            }
                        }
                }
            }
        }
    
    
        // Depending on how many cards are in the array and what the match is, a score is returned.
        
        if ([self.matchedCards count] == 3) {
            
            if (([self.matchedCards[0]rank] == [self.matchedCards[1]rank] && [self.matchedCards[1]rank] == [self.matchedCards[2]rank]))
            {
                score = 6;
            } else if (([self.matchedCards[0]suit] == [self.matchedCards[1]suit] && [self.matchedCards[1]suit] == [self.matchedCards[2]suit])) {
                score = 5;
            }
        } else if ([self.matchedCards count] == 2) {
            if (([self.matchedCards[0]rank] == [self.matchedCards[1]rank])) {
                score = 3;
            } else if (([self.matchedCards[0]suit] == [self.matchedCards[1]suit])) {
                score = 2;
            }
        }
    
    }
    
    return score;
}


@end

