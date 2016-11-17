//
//  ConversationCell.h
//  Pods
//
//  Created by Philip Bale on 11/12/16.
//
//

#import <UIKit/UIKit.h>

@interface ConversationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastMessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (unsafe_unretained, nonatomic) IBOutlet NSLayoutConstraint *avatarConstraint;
@property (unsafe_unretained, nonatomic) IBOutlet NSLayoutConstraint *ratioConstraint;

+ (NSInteger)height;

@end
