//
//  CardMatchingGameWithBeanTests.m
//  CardMatchingGameWithBeanTests
//
//  Created by Nadine Hachouche on 12/22/15.
//  Copyright © 2015 nadine farah. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface CardMatchingGameWithBeanTests : XCTestCase

@end

@implementation CardMatchingGameWithBeanTests

// This app is PERFECT for testing. You have models that do stuff and game logic to test.
// You should make the tests deal a few example games where you deal the cards and set their values,
// then verify that your hands are scored the way you want them to be scored.

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
