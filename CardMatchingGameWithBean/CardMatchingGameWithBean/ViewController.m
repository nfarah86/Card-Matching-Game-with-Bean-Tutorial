//
//  ViewController.m
//  CardMatchingGameWithBean
//
//  Created by Nadine Hachouche on 12/22/15.
//  Copyright © 2015 nadine farah. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property(nonatomic) NSInteger flipsCount;

@end

@implementation ViewController

-(void)setFlipsCount:(NSInteger)flipsCount
{
    if (flipsCount) {
        _flipsCount = flipsCount;
        self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipsCount];
        NSLog(@"Flips:%d", self.flipsCount);
    }
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    if ([sender.currentTitle length]) {
        // show the back of a card
        [sender setBackgroundImage:[UIImage imageNamed:@"pt-back-card.png"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
        [sender setBackgroundImage:[UIImage imageNamed:@"pt-front-card.png"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"A♣︎" forState:UIControlStateNormal];

    }
    
    self.flipsCount++;

}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

@end
