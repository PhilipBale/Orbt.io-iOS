//
//  ConversationCell.m
//  Pods
//
//  Created by Philip Bale on 11/12/16.
//
//

#import "ConversationCell.h"

@implementation ConversationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(NSInteger)height
{
    return 55;
}

@end
