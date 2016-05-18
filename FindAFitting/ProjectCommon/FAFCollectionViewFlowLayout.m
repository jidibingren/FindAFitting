//
//  FAFCollectionViewFlowLayout.m
//  FindAFitting
//
//  Created by SC on 16/5/6.
//  Copyright © 2016年 SDJY. All rights reserved.
//

#import "FAFCollectionViewFlowLayout.h"


@interface FAFCollectionViewFlowLayout ()

@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes*> *itemAttributes;

@end

@implementation FAFCollectionViewFlowLayout

/**
 *  初始化layout后自动调动，可以在该方法中初始化一些自定义的变量参数
 */

- (void)prepareLayout{
    [super prepareLayout];
    NSInteger itemCount = [[self collectionView] numberOfItemsInSection:0];
    self.itemAttributes = [NSMutableArray arrayWithCapacity:itemCount];
    
    CGFloat xOffset = self.sectionInset.left;
    CGFloat yOffset = self.sectionInset.top;
    CGFloat xNextOffset = self.sectionInset.left;
    for (NSInteger idx = 0; idx < itemCount; idx++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        CGSize itemSize = CGSizeZero;
        if ([self.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
            itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
        }else{
            itemSize = self.itemSize;
        }
        CGFloat itemOffset = 0;
        if ([self.delegate respondsToSelector:@selector(collectionView:layout:offsetForItemAtIndexPath:)]) {
            itemOffset = [self.delegate collectionView:self.collectionView layout:self offsetForItemAtIndexPath:indexPath];
        }
        xNextOffset+=(self.minimumInteritemSpacing + itemSize.width);
        if (xNextOffset > [self collectionView].bounds.size.width - self.sectionInset.right) {            xOffset = self.sectionInset.left + itemOffset;
            xNextOffset = (self.sectionInset.left + self.minimumInteritemSpacing + itemSize.width)+itemOffset;
            yOffset += (itemSize.height + self.minimumLineSpacing);
        }
        else {
            
            xOffset = xNextOffset - (self.minimumInteritemSpacing + itemSize.width);
            xNextOffset+=itemOffset;
        }
        UICollectionViewLayoutAttributes *layoutAttributes =        [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        layoutAttributes.frame = CGRectMake(xOffset, yOffset, itemSize.width, itemSize.height);        [_itemAttributes addObject:layoutAttributes];
    }
}

-(CGSize)collectionViewContentSize{
    return self.collectionView.frame.size;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    return _itemAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return indexPath.row < _itemAttributes.count ? _itemAttributes[indexPath.row] : [UICollectionViewLayoutAttributes new];
}

@end
