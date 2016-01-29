//
//  Card.h
//  CardMatchingGameWithBean
//
//  Created by Nadine Hachouche on 12/22/15.
//  Copyright © 2015 nadine farah. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=chosen) BOOL chosen;
@property (nonatomic, getter=matched) BOOL matched;


- (int)match:(NSArray* )otherCards;

@end