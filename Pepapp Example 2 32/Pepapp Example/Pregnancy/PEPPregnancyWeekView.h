//
//  PEPPregnancyWeekView.h
//  Pepapp Example
//
//  Created by Ezgi Ustunel on 7.09.2020.
//  Copyright © 2020 Ezgi Ustunel. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PEPPregnancyWeekView;
@protocol PEPPregnancyWeekViewDelegate <NSObject>

-(void)pregnancyWeekView:(PEPPregnancyWeekView *)pregnancyWeekView didSelectIndex:(NSInteger)index;

@end

@interface PEPPregnancyWeekView : UIView
@property (nonatomic, weak) IBOutlet id <PEPPregnancyWeekViewDelegate> delegate;
@property (nonatomic, strong) NSArray *letters;
@property (nonatomic, assign) IBInspectable NSInteger initialIndex;
@end

