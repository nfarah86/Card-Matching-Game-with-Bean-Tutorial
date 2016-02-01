//
//  CardMatchingGame.m
//  CardMatchingGameWithBean
//
//  Created by Nadine Hachouche on 12/30/15.
//  Copyright © 2015 nadine farah. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property(nonatomic, readwrite) NSInteger score;
@property(nonatomic, strong) NSMutableArray* cards; //of Card

// Assignment 2, Task 3
//chosenCards: store users picked cards either from 2 or 3 match game
@property(nonatomic, strong) NSMutableArray* chosenCards;
@end


@implementation CardMatchingGame

- (NSMutableArray *) cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}


-(instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    if (self) {
        // Assignment 2, Task 3
        // Instantiate chosenCards to be an empty array
        self.chosenCards = [NSMutableArray new];
        for (int i=0; i < count; i++) {
            Card* card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            }
            else {
                self = nil;
                break;
            }
        }
    }
    return self;
}


-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}


static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;


// Assignment 2, Task 3
// modified chooseCardAtIndex: method to include the segmentedControl index that indicates which game the user want to play
-(void)chooseCardAtIndex:(NSUInteger)cardIndex getSegmentedControlIndex:(NSInteger) segmentedControlIndex
{
    // Assignment 2, Task 3
    // modify cardAtIndex: below to take cardIndex
    // I just renamed index to cardIndex, so we don't
    // get confused with segmentedControl's index and the
    // card's index
    
    // other edits: since we are only going to be worried about
    // 2 or 3 card game, I modified this function to differentiate between
    // each game and process the info (segmentIndex, cardIndex) with respect
    // to the specific match game.
    
    Card *card = [self cardAtIndex:cardIndex];
    [self.chosenCards addObject:card];
     self.score -= COST_TO_CHOOSE;


    if (!card.matched) {
        if (card.chosen) {
            card.chosen = NO;
            [self.chosenCards removeObject:card];
        } else {
            for (Card *otherCard in self.cards) {
                if (otherCard.chosen && !otherCard.matched) {
                    
                    NSInteger cardsInArray = [self _differentiateTwoAndThreeCardGames:segmentedControlIndex];
                    
                    if (cardsInArray) {
                        int matchScore = [card match:self.chosenCards];

                        if (matchScore) {
                            self.score += (matchScore * MATCH_BONUS);
                            card.matched = YES;
                            otherCard.matched = YES;
                            self.chosenCards = [NSMutableArray array];

                        } else if (matchScore == 0 && cardsInArray == 2) {
                            self.score -= MISMATCH_PENALTY;
                            [self.chosenCards removeObject:otherCard];
                            otherCard.chosen = NO;

                        } else if (matchScore == 0 && cardsInArray == 3) {
                                Card* card1 = self.chosenCards[0];
                                Card* card2 = self.chosenCards [1];
                            
                                self.score -= MISMATCH_PENALTY;
                            
                                card1.chosen = NO;
                                card2.chosen = NO;
                        
                                [self.chosenCards removeObject:card1];
                                [self.chosenCards removeObject:card2];
                        }
                        
                        break;
                    }
                }
                
            }
        
            card.chosen = YES;
        }
    }
}

// helper method to differentiate between a 2 and 3 card game
-(NSInteger) _differentiateTwoAndThreeCardGames:(NSInteger)segmentControlIndex
{
    if ([self.chosenCards count] == 2 && segmentControlIndex == 0) {
        return 2;
    } else if ([self.chosenCards count] == 3 && segmentControlIndex == 1) {
        return 3;
    } else {
        return 0;
    }
}

@end
