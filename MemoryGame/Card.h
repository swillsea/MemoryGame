//
//  Card.h
//  MemoryGame
//
//  Created by Sam on 3/28/16.
//  Copyright © 2016 Sam Willsea. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CardDelegate
-(void)checkTap:(UIImageView *)imageView;
//Can't pass Card type...
@optional
-(instancetype)initWithCoder:(NSCoder *)aDecoder;
@end

@interface Card : UIImageView
@property (nonatomic, assign) id <CardDelegate> delegate;
@property int cardID;
@property BOOL hasSpun;
@property int cardSize;
@property int cardPadding;
@end
