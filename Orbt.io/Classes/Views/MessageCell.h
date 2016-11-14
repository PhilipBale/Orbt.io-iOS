//
//  MessageCell.h
//  Pods
//
//  Created by Philip Bale on 11/14/16.
//
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *textLabel;

+ (NSString *)reuseId;

@end
