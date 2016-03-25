//
//  Card.m
//  CardMatchingGameWithBean
//
//  Created by Nadine Hachouche on 12/22/15.
//  Copyright © 2015 nadine farah. All rights reserved.
//

#import "Card.h"

@interface Card ()

@end

@implementation Card

// We don't need to have a 'score' here.  However it is readonly
// in the CardMatchingGame.h file.  We can just simply return a value here.
// Score is not doing much here.
// The CardMatchingGame will implement a 'score'.
- (int)match:(NSArray *)otherCards
{
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.
             contents]) {
            return 1;
        }
    }
    
    return 0;
}

@end
