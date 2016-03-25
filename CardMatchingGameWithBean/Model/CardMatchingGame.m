//
//  CardMatchingGame.m
//  CardMatchingGameWithBean
//
//  Created by Nadine Hachouche on 12/30/15.
//  Copyright © 2015 nadine farah. All rights reserved.
//

#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"

@interface CardMatchingGame ()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, strong) NSMutableArray *chosenCards;
@property (nonatomic) NSInteger matchScore;
@property(strong, nonatomic) PlayingCardDeck *deck;


@end


@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    if (self) {
        self.chosenCards = [NSMutableArray new];
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)chooseCardAtIndex:(NSUInteger)cardIndex
 getSegmentedControlIndex:(NSInteger)segmentedControlIndex
{
    Card *card = [self cardAtIndex:cardIndex];
    [self.chosenCards addObject:card];
    [self.delegate cardDescription:self.chosenCards];
    [self scoreGame:@"picked a card"];
    
    if (!card.matched) {
        if (card.chosen) {
            card.chosen = NO;
            [self.chosenCards removeObject:card];
        } else {
            card.chosen = YES;
            NSInteger cardsInArray =
                [self _differentiateTwoAndThreeCardGames:
                          segmentedControlIndex];
            if (cardsInArray) {
                self.matchScore = [card match:self.chosenCards];
                if (self.matchScore) {
                    [self matchCards:self.chosenCards];
                } else {
                    [self unmatchCards:self.chosenCards];

                }
            }
        }
    }
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

-(void)scoreGame:(NSString *)indicator;
{
    if ([indicator isEqualToString:@"picked a card"]) {
        self.score -= COST_TO_CHOOSE;
    } else if ([indicator isEqualToString:@"cards matched"]) {
        self.score += (self.matchScore * MATCH_BONUS);
    } else if ([indicator isEqualToString:@"cards don't match"]) {
        self.score -= MISMATCH_PENALTY;
    }
}

-(void)matchCards: (NSMutableArray* ) userCards
{
    for (int i = 0; i < [userCards count]; i++) {
        Card* cardToBeMatched = userCards[i];
        [self scoreGame: @"cards matched"];
        cardToBeMatched.matched = YES;
        [self _didCardsMatch: true];
    }
    self.chosenCards = [NSMutableArray array];
}

-(void) unmatchCards: (NSMutableArray *) usersCards
{
    for (int i = 0; (i < [usersCards count]-1); i++) {
        Card* cardToBeUnMatched = usersCards[i];
        [self scoreGame:@"cards don't match"];
        [self _didCardsMatch: false];
        [self.chosenCards removeObject:cardToBeUnMatched];
        cardToBeUnMatched.chosen = NO;
    }
}

- (NSInteger)_differentiateTwoAndThreeCardGames:(NSInteger)segmentControlIndex
{
    return [self.chosenCards count] == segmentControlIndex + 2 ? [self.chosenCards count]: 0;
}

-(void) _didCardsMatch: (BOOL) resultOfCardMatch
{
    [self.delegate matchDescription: self.chosenCards didCardsMatch: resultOfCardMatch];
}

@end
