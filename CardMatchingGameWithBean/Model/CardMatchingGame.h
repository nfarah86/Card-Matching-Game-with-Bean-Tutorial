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

@protocol CardMatchingGameDelegate <NSObject>
@required

-(void)matchDescription: (NSMutableArray* )pickedCards didCardsMatch: (BOOL) status;
-(void)cardDescription: (NSMutableArray *)pickedCards;


@end

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;
- (void)chooseCardAtIndex:(NSUInteger)cardIndex
 getSegmentedControlIndex:(NSInteger)segmentedControlIndex;
- (Card *)cardAtIndex:(NSUInteger)index;

@property(nonatomic, readonly) NSInteger score;
@property (nonatomic, strong) NSNumber* scoreGame;
@property(nonatomic, weak) id<CardMatchingGameDelegate> delegate;


@end
