//
//  Card.m
//  MemoryGame
//
//  Created by Sam on 3/28/16.
//  Copyright © 2016 Sam Willsea. All rights reserved.
//

#import "Card.h"
#import "ViewController.h"

@interface Card () <UIGestureRecognizerDelegate>

@end


@implementation Card

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        
        self.gestureRecognizers = @[tap];

        for (UIGestureRecognizer *recognizer in self.gestureRecognizers) {
            recognizer.delegate = self;
        }
    }
    return self;
    
}

-(void)handleTap:(UITapGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan || gestureRecognizer.state == UIGestureRecognizerStateRecognized) {
        
        [self.delegate checkTap:self];
        [self spinCards];
    }
}

-(void)spinCards{
    if (self.hasSpun) {
        [self spinIn];
    } else {
        [self spinOut];
    }
    self.hasSpun = !self.hasSpun;
}

-(void)spinIn{
//    self.cardSize = 50;
//    
//    self.frame = CGRectMake(self.frame.size.width - (self.frame.size.width/4), self.frame.size.height - (self.frame.size.height/4), 0 , self.frame.size.width - (self.frame.size.width/4));

}

-(void)spinOut{
    
}




//-(void)fanButtons{
//    [self.animator removeAllBehaviors];
//    if (self.areButtonsFanned) {
//        [self fanIn];
//    } else {
//        [self fanOut];
//    }
//    
//    self.areButtonsFanned = !self.areButtonsFanned;
//}
//
//
//-(void)fanIn {
//    for (MenuButton *button in self.buttons) {
//        UISnapBehavior *snapBehavior;
//        snapBehavior = [[UISnapBehavior alloc] initWithItem:button snapToPoint:self.mainButton.center];
//        [self.animator addBehavior:snapBehavior];
//    }
//}
//
//-(void)fanOut {
//    for (int i = 0; i < self.buttons.count; i++) {
//        CGPoint point;
//        UISnapBehavior *snapBehavior;;
//        MenuButton *button = self.buttons[i];
//        point = CGPointMake(self.view.frame.size.width - (i * button.frame.size.width) - (self.buttonSize / 2), self.view.frame.size.height - self.buttonSize / 2);
//        snapBehavior = [[UISnapBehavior alloc] initWithItem:button snapToPoint:point];
//        [self.animator addBehavior:snapBehavior];
//    }
//}



@end
