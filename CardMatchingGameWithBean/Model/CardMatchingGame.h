//
//  CardMatchingGame.h
//  CardMatchingGameWithBean
//
//  Created by Nadine Hachouche on 12/30/15.
//  Copyright © 2015 nadine farah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

// Assignment 2, Task 4
// Implemented delegate
@protocol CardMatchingGameDelegate <NSObject>
@required
-(void)matchDescription: (NSMutableArray* )pickedCards didCardsMatch: (BOOL) status;
-(void)cardDescription: (NSMutableArray *)pickedCards;
@end

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

// Assignment 2, Task 3
// modified chooseCardAtIndex: method to include the segmentedControl index that
// indicates which game the user want to play
- (void)chooseCardAtIndex:(NSUInteger)cardIndex
 getSegmentedControlIndex:(NSInteger)segmentedControlIndex;

- (Card *)cardAtIndex:(NSUInteger)index;

@property(nonatomic, readonly) NSInteger score;
@property (nonatomic, strong) NSNumber* scoreGame;
@property(nonatomic, weak) id<CardMatchingGameDelegate> delegate;

@end
