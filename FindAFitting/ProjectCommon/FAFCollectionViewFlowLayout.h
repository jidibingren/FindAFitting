//
//  FAFCollectionViewFlowLayout.h
//  FindAFitting
//
//  Created by SC on 16/5/6.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import <UIKit/UIKit.h>


//layout
@class FAFCollectionViewFlowLayout;
@protocol FAFCollectionViewDelegateFlowLayout <UICollectionViewDelegateFlowLayout>

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout offsetForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface FAFCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (weak, nonatomic) id<FAFCollectionViewDelegateFlowLayout> delegate;

@end
