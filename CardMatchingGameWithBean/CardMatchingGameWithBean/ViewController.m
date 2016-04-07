//
//  ViewController.m
//  CardMatchingGameWithBean
//
//  Created by Nadine Hachouche on 12/22/15.
//  Copyright © 2015 nadine farah. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "Card.h"
#import "CardMatchingGame.h"
#import "ContentCell.h"


@interface ViewController () <CardMatchingGameDelegate>

@property(strong, nonatomic) PlayingCardDeck *deck;
@property(nonatomic) CardMatchingGame* game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property(weak, nonatomic) IBOutlet UILabel *gameDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *dealButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(strong, nonatomic) NSMutableArray *arrayOfCards;

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}

-(PlayingCardDeck *)deck
{
    return [[PlayingCardDeck alloc] init];
}

-(CardMatchingGame *) game{
    if (! _game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:30
                                                  usingDeck:[self deck]];
        _game.delegate = self;
        self.gameDescriptionLabel.text = @"New Match Game";
        self.arrayOfCards = [NSMutableArray new];
        [self generateCards];
    }
    return _game;
}

-(void)generateCards
{
    for (int i = 0; i < 30; i++){
        PlayingCard* newCardAtIndex = (PlayingCard *)[self.game cardAtIndex:i];
        [self.arrayOfCards addObject:newCardAtIndex];
    }
    [self.collectionView reloadData];
}

-(NSString*) titleForCard: (Card *) card
{
    return card.chosen ? card.contents : @"";
}

-(UIImage*) backgroundImageForCard: (Card *) card
{
    return [UIImage imageNamed:(card.chosen) ? @"plainCard" : @"pt-back-card.png"];
}

- (IBAction)clickOnDeal:(UIButton *)sender
{
    if(sender) {
        self.game = nil;
        [self game];
        [self.segmentedControl setEnabled: YES];
        
    }
}

- (IBAction)pickMatchGame:(UISegmentedControl *)sender
{
    if (sender) {
        self.game = nil;
        [self.segmentedControl setEnabled: NO];
    }
}

-(void)matchDescription:(NSMutableArray *) pickedCards didCardsMatch: (BOOL) status
{
    NSString* descriptionText = [self _labelDescription:pickedCards];
    NSMutableString* describeMatchText = [descriptionText mutableCopy];
    
    if ([pickedCards count] == 0) {
        [describeMatchText appendFormat: @"Please pick a card"];
        self.gameDescriptionLabel.text = describeMatchText;
    } else if ([pickedCards count] >= 1 && !(status)) {
        self.gameDescriptionLabel.text = descriptionText;
    } else if (status) {
        [describeMatchText appendFormat: @"match"];
        self.gameDescriptionLabel.text = describeMatchText;
    } else {
        [describeMatchText appendFormat: @"don't match"];
        self.gameDescriptionLabel.text = describeMatchText;
    }
}

-(NSString *) _labelDescription: (NSMutableArray *) pickedCards
{
    NSMutableString* labelDescription = [[NSMutableString alloc]init];
    for (int i = 0; i < [pickedCards count]; i++) {
        PlayingCard* pickedCard = pickedCards[i];
        [labelDescription appendFormat:@"%ld%@ and ", pickedCard.rank, pickedCard.suit];
    }
    NSString* newLabelDescription = [NSString stringWithString:labelDescription];
    NSRange replaceAnd= [labelDescription rangeOfString:@"and " options:NSBackwardsSearch];
    if (replaceAnd.location != NSNotFound) {
        newLabelDescription = [newLabelDescription stringByReplacingCharactersInRange:replaceAnd withString:@""];
    }
    return newLabelDescription;
}

-(void) cardDescription: (NSMutableArray *)pickedCards
{
    NSString* cardDescriptionText = [self _labelDescription:pickedCards];
    self.gameDescriptionLabel.text = cardDescriptionText;
}


#pragma UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 30;
}

-(UICollectionViewCell* )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ContentCell alloc] init];
    }
    
    PlayingCard *card = self.arrayOfCards[indexPath.row];
    NSString* cardTitle = [self titleForCard:card];
    cell.cardDescriptionLabel.text = cardTitle;
    cell.imageView.image = [self backgroundImageForCard:card];
    [cell setSelected:YES];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"deselecting item");
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.game chooseCardAtIndex:indexPath.row getSegmentedControlIndex:[self.segmentedControl selectedSegmentIndex]];
    [self.segmentedControl setEnabled: NO];
    [self.segmentedControl selectedSegmentIndex];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];

    [collectionView reloadData];
}

@end
