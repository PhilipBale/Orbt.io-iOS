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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        
        [nameLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [textLabel setNumberOfLines:0];
        
        [self addSubview:nameLabel];
        [self addSubview:textLabel];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(nameLabel, textLabel);
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[nameLabel]-10-|" options:nil metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[textLabel]-10-|" options:nil metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[nameLabel]-5-[textLabel]-10-|" options:nil metrics:nil views:views]];
        
        self.nameLabel = nameLabel;
        self.messageTextLabel = textLabel;
    }
    
    return self;
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
