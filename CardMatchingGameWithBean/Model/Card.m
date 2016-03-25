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
