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

// @synthesize is kind of old and has mostly been replaced by @property
// I recommend using @property and never using @synthesize if possible, for consistency/cleanliness
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
        // I recommend using self.suit instead of _suit
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}


- (void)setRank:(NSUInteger)rank
{
    // Stuff with [rankStrings count] and <= make me think there is an off by one error in your logic somewhere,
    // or that there may be one appearing if you make a mistake
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}


// Unclear what this method does. It's something with game logic, but it's made of magic numbers for the score
- (int)match:(NSArray *)otherCards;
{
    // If score is supposed to be 0 in all other cases, initialize it at 0 to make it clear to readers
    int score;
    if([otherCards count] == 1){
        PlayingCard *otherCard = [otherCards firstObject];
        if(otherCard.rank == self.rank){
            score = 4;
        } else if(otherCard.suit == self.suit){
            score = 1;
        }
    }
    return score;
}


@end

