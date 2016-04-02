//
//  ContentCell.h
//  CardMatchingGameWithBean
//
//  Created by Nadine Hachouche on 4/1/16.
//  Copyright © 2016 nadine farah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *cardDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
