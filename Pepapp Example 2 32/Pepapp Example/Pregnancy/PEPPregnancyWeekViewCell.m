//
//  PEPPregnancyWeekViewCell.m
//  Pepapp Example
//
//  Created by Ezgi Ustunel on 7.09.2020.
//  Copyright © 2020 Ezgi Ustunel. All rights reserved.
//

#import "PEPPregnancyWeekViewCell.h"



@implementation PEPPregnancyWeekViewCell{
    
    __weak IBOutlet UILabel *LBLWeek;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self clean];
    // Initialization code
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self clean];
}

- (void) clean {
    LBLWeek.text = @"";
}

- (void)setWeek:(NSString *)week {
    _week = week;
    LBLWeek.text = _week;
}

#pragma mark - <PEPIdentifiable>
+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}

@end
