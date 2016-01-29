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

// Important: 99% of the time you want to use BOOL myvar instead of BOOL *myvar.
// If you use BOOL *myvar, you have to access it like this: *myvar = YES

// I recommend against using getter=myCustomGetter. Just use the one Obj-C names for you by default.
// In this case, just name your getter "chosen" and your setter (if you want one) "setChosen".
// More info: http://rypress.com/tutorials/objective-c/properties
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

// consistent spacing
- (int)match:(NSArray *)otherCards;

@end