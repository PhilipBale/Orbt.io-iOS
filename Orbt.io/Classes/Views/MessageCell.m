//
//  MessageCell.m
//  Pods
//
//  Created by Philip Bale on 11/14/16.
//
//

#import "MessageCell.h"

@implementation MessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    
//    [self.nameLabel setFont:[UIFont boldSystemFontOfSize:14]];
//    [self.nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self.textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self.textLabel setNumberOfLines:0];
//    
//    [self addSubview:self.nameLabel];
//    [self addSubview:self.textLabel];
//    
//    NSDictionary *views = @{@"nameLabel":self.nameLabel, @"textLabel":self.textLabel};
//    [self addConstraint:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[nameLabel]-10-|" options:nil metrics:nil views:views]];
//    [self addConstraint:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[textLabel]-10-|" options:nil metrics:nil views:views]];
//    [self addConstraint:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[nameLabel]-5-[textLabel]-10-|" options:nil metrics:nil views:views]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)reuseId
{
    return @"MessageCell";
}

@end
