//
//  ViewController.m
//  MemoryGame
//
//  Created by Sam on 3/28/16.
//  Copyright © 2016 Sam Willsea. All rights reserved.
//

#import "ViewController.h"
#import "Card.h"

@interface ViewController () <CardDelegate>
@property (weak, nonatomic) IBOutlet UIButton *startNewGameButton;

@property NSMutableArray *cardsArray;
@property NSMutableArray *checkingCardsArray;
@property UIAlertController *finishedGameAlert;


@property (weak, nonatomic) IBOutlet Card *card1;
@property (weak, nonatomic) IBOutlet Card *card2;
@property (weak, nonatomic) IBOutlet Card *card3;
@property (weak, nonatomic) IBOutlet Card *card4;
@property (weak, nonatomic) IBOutlet Card *card5;
@property (weak, nonatomic) IBOutlet Card *card6;
@property (weak, nonatomic) IBOutlet Card *card7;
@property (weak, nonatomic) IBOutlet Card *card8;
@property (weak, nonatomic) IBOutlet Card *card9;
@property (weak, nonatomic) IBOutlet Card *card10;
@property (weak, nonatomic) IBOutlet Card *card11;
@property (weak, nonatomic) IBOutlet Card *card12;
@property (weak, nonatomic) IBOutlet Card *card13;
@property (weak, nonatomic) IBOutlet Card *card14;
@property (weak, nonatomic) IBOutlet Card *card15;
@property (weak, nonatomic) IBOutlet Card *card16;

@property int totalMatchedSets;
@property (weak, nonatomic) IBOutlet UILabel *totalMatchedSetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *bestTimeLabel;

@property NSTimer *timer;
@property float ticks;
@property float bestTime;
@property NSUserDefaults *defaults;


@end

@implementation ViewController

#pragma mark Game Setup
- (void)viewDidLoad {
    [super viewDidLoad];

    //allows us to save and load information that is permanently stored in the device memory, regardless of app state
    self.defaults = [NSUserDefaults standardUserDefaults];
    self.currentTimeLabel.text = [self.defaults objectForKey:@"LastGameTime"];
    if ([self.defaults objectForKey:@"BestTime"]) {
        self.bestTimeLabel.text = [self.defaults objectForKey:@"BestTime"];
        self.bestTimeLabel.hidden = NO;
    } else {
        self.bestTime = 500.0;
    }

    //set up all cards
    self.checkingCardsArray = [NSMutableArray new];
    self.cardsArray = [[NSMutableArray alloc] initWithObjects: self.card1, self.card2, self.card3, self.card4, self.card5, self.card6, self.card7, self.card8, self.card9, self.card10, self.card11, self.card12, self.card13, self.card14, self.card15, self.card16, nil];

    
    [self resetCards];
    
    //shuffle the cards
    [self shuffleCards];
    
    self.startNewGameButton.layer.cornerRadius = 6;
    self.startNewGameButton.layer.masksToBounds = YES;
    
    [self createNewTimer];
    
}

-(void)createNewTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval: 0.1f
                                                  target: self
                                                selector: @selector(timerTick:)
                                                userInfo: nil
                                                 repeats: YES];
}

- (void)resetCards {
    //make sure they're all face down
    for (Card *card in self.cardsArray) {
        card.highlighted = YES;
        //and make sure they all set their card delegate to
        card.delegate = self;
    }
}

//this gives us the right counter
- (void)timerTick:(NSTimer *)timer
{
    _ticks += 0.1;
    double seconds = fmod(_ticks, 60.0);
    double minutes = fmod(trunc(_ticks / 60.0), 60.0);
    self.currentTimeLabel.text = [NSString stringWithFormat:@"Time: %02.0f:%04.1f", minutes, seconds];
}


-(void)shuffleCards {
    
    //shuffles the card array
    for (NSUInteger i = self.cardsArray.count; i > 1; i--) [self.cardsArray exchangeObjectAtIndex:i - 1 withObjectAtIndex:arc4random_uniform((u_int32_t)i)];
    
    //goes throught the array and assigns two cards images corresponding to each number 1-8
    for (int i = 0; i < 16; i++) {
        Card *card = [Card new];
        card = [self.cardsArray objectAtIndex:i];
        card.image = [UIImage imageNamed:[NSString stringWithFormat:@"%i", ((i + (i +1)% 2)/2)+1]];
        card.cardID = ((i + (i +1)% 2)/2)+1;
        
    }
}

#pragma mark Game Play

-(void)checkTap:(Card *)imageView {

    if (imageView.highlighted) {
    [self.checkingCardsArray addObject:imageView];

        if (self.checkingCardsArray.count == 2) {
            
            Card *card = self.checkingCardsArray[0];
            if (imageView.cardID == card.cardID) {
                imageView.highlighted = NO;
                self.totalMatchedSets++;
                self.totalMatchedSetsLabel.text = [NSString stringWithFormat:@"Total matched sets: %i", self.totalMatchedSets];
                [self.checkingCardsArray removeAllObjects];
                
            } else {
                card.highlighted = YES;
                [self.checkingCardsArray removeAllObjects];
            }
            
        } else if (self.checkingCardsArray.count == 1) {
            imageView.highlighted = NO;
        } else {
            //do nothing
        }
        [self checkIfFinishedGame];

    } else {
        //do nothing
    }
    
    
    //this below can help us add in delays to cards turning back over
    
//    [self performSelector:<#(nonnull SEL)#> withObject:imageView afterDelay:3.0]
    
}

- (IBAction)onResetButtonPressed:(UIButton *)sender {
    
    _ticks = 0.0;
    self.bestTime = 500.0;
    self.bestTimeLabel.hidden = YES;
    self.totalMatchedSets = 0;
    self.totalMatchedSetsLabel.text = [NSString stringWithFormat:@"Total matched sets: %i", self.totalMatchedSets];
    [self createNewTimer];
    [self resetCards];
    
}





#pragma mark Start New Game

- (IBAction)startNewGamePressed:(UIButton *)sender {
    for (Card *card in self.cardsArray) {
        card.highlighted = YES;
    }
    [self shuffleCards];
//    [self resetCards];
}

-(void)checkIfFinishedGame {
    
    if (!self.card1.isHighlighted &&
        !self.card2.isHighlighted &&
        !self.card3.isHighlighted &&
        !self.card4.isHighlighted &&
        !self.card5.isHighlighted &&
        !self.card6.isHighlighted &&
        !self.card7.isHighlighted &&
        !self.card8.isHighlighted &&
        !self.card9.isHighlighted &&
        !self.card10.isHighlighted &&
        !self.card11.isHighlighted &&
        !self.card12.isHighlighted &&
        !self.card13.isHighlighted &&
        !self.card14.isHighlighted &&
        !self.card15.isHighlighted &&
        !self.card16.isHighlighted) {
     
        [self didFinishGame];
        
        //creates temporary float to store current time and checks for Best Time - if it is, then sets to memory
        float timeForThisRound = self.ticks;
        if (timeForThisRound < self.bestTime) {
            self.bestTime = timeForThisRound;
            self.bestTimeLabel.hidden = NO;
            self.bestTimeLabel.text = [NSString stringWithFormat:@"Best Time:%.01f", self.bestTime];
            [self.defaults setObject:self.bestTimeLabel.text forKey:@"BestTime"];
            [self.defaults synchronize];

        }
        // saves state and resets the timer values
        _ticks = 0.0;
        [self createNewTimer];

    }
}




-(void)didFinishGame {
    
    self.finishedGameAlert = [UIAlertController alertControllerWithTitle:@"Well done!" message:@"Want to play again?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"Start New Game" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        for (Card *card in self.cardsArray) {
            card.highlighted = YES;
        }
        [self shuffleCards];
    }];
    [self.finishedGameAlert addAction:confirm];
    
    [self presentViewController:self.finishedGameAlert animated:true completion:nil];
    
    

    
}



//to programattically create the buttons

//self.cardSize = 50;
//self.padding = 10;

//    for (int i = 0; i < 16; i++) {
//        Card *card = [[Card alloc] initWithFrame:CGRectMake(self.view.frame.size.height-self.cardSize-self.padding, self.view.frame.size.height-self.cardSize-self.padding, self.cardSize, self.cardSize)];
//        [self.cardsArray addObject:card];
//    }
//    NSLog(@"%@", self.cardsArray);



@end
