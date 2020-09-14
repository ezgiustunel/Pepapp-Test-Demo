//
//  PEPPregnancyWeekView.m
//  Pepapp Example
//
//  Created by Ezgi Ustunel on 7.09.2020.
//  Copyright © 2020 Ezgi Ustunel. All rights reserved.
//

#import "PEPPregnancyWeekView.h"
#import "PEPPregnancyWeekViewCell.h"
#import "PEPPregnancyWeekViewHeaderFooter.h"
#import "KKUtils.h"

CGFloat const kPEPPregnancyWeekViewHeaderFooterWidth = 200;
CGFloat const kPEPPregnancyWeekViewCellWidth = 100;
CGFloat const kPEPPregnancyWeekViewCellHeight = 150;
CGFloat weekIndex;
NSString *notificationBroadcast = @"pregnancyWeekReceived";

@interface PEPPregnancyWeekView() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@end

@implementation PEPPregnancyWeekView {
    __weak IBOutlet UICollectionView *collectionView;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void) commonInit {
    [self attachAndLoadXib:NSStringFromClass([self class])];
    UINib *cellNib = [UINib nibWithNibName:[PEPPregnancyWeekViewCell identifier] bundle:nil];
    [collectionView registerNib:cellNib forCellWithReuseIdentifier:[PEPPregnancyWeekViewCell identifier]];
    
    [collectionView registerHeaderNib:[PEPPregnancyWeekViewHeaderFooter identifier]];
    [collectionView registerFooterNib:[PEPPregnancyWeekViewHeaderFooter identifier]];
}

#pragma mark - Setters

- (void)setLetters:(NSArray *)letters {
    _letters = letters;
    [collectionView reloadData];
}

- (void)setInitialIndex:(NSInteger)initialIndex {
    _initialIndex = initialIndex;
    weekIndex = initialIndex;
     dispatch_async(dispatch_get_main_queue(), ^ {
         [self snapToCell:initialIndex inScrollView:self->collectionView animated:NO];
     });
}

#pragma mark - <UICollectionViewDataSource>

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:[PEPPregnancyWeekViewCell identifier] forIndexPath:indexPath];
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _letters.count;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kPEPPregnancyWeekViewCellWidth, kPEPPregnancyWeekViewCellHeight);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kPEPPregnancyWeekViewHeaderFooterWidth, kPEPPregnancyWeekViewCellHeight);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
   return CGSizeMake(kPEPPregnancyWeekViewHeaderFooterWidth, kPEPPregnancyWeekViewCellHeight);
}


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    ((PEPPregnancyWeekViewCell *)cell).week = self.letters[indexPath.row];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:[PEPPregnancyWeekViewHeaderFooter identifier] forIndexPath:indexPath];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate pregnancyWeekView:self didSelectIndex:indexPath.row];
    [collectionView scrollToItemAtIndexPath:indexPath
    atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if(!decelerate) {
        [self snapToNearestNeighbour:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self snapToNearestNeighbour:scrollView];
}

- (void)snapToNearestNeighbour:(UIScrollView *)scrollView {

    CGFloat totall = kPEPPregnancyWeekViewCellWidth/2 + scrollView.contentOffset.x + scrollView.frame.size.width/2;
    NSLog(@"%f", totall);
    totall = totall - kPEPPregnancyWeekViewHeaderFooterWidth;
    NSInteger nearestNeighbour = MIN(_letters.count, MAX(1, round(totall / kPEPPregnancyWeekViewCellWidth)));
    [self snapToCell:nearestNeighbour inScrollView:scrollView animated:YES];
}

- (void)snapToCell:(NSInteger)index inScrollView:(UIScrollView *)scrollView animated:(BOOL)animated {
    CGFloat total =  kPEPPregnancyWeekViewHeaderFooterWidth + (index - 1 ) * kPEPPregnancyWeekViewCellWidth + kPEPPregnancyWeekViewCellWidth/2;
    
    total = total - scrollView.frame.size.width/2;
    [scrollView setContentOffset:CGPointMake( total, 0) animated:animated];
    [self.delegate pregnancyWeekView:self didSelectIndex:index - 1];
    weekIndex = index;
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationBroadcast object:nil userInfo:@{@"pregnancyWeek": @(index)}];
}

-(void) scrollToSectionHeader:(int)section {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    UICollectionViewLayoutAttributes *attribs = [collectionView layoutAttributesForSupplementaryElementOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
    CGPoint topOfHeader = CGPointMake(0, attribs.frame.origin.y - collectionView.contentInset.top);
    [collectionView setContentOffset:topOfHeader animated:YES];
}

-(void) scrollToSectionFooter:(int)section {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    UICollectionViewLayoutAttributes *attribs = [collectionView layoutAttributesForSupplementaryElementOfKind:UICollectionElementKindSectionFooter atIndexPath:indexPath];
    CGPoint topOfFooter = CGPointMake(0, attribs.frame.origin.y - collectionView.contentInset.top);
    [collectionView setContentOffset:topOfFooter animated:YES];
}

@end
