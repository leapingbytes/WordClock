//
//  LBViewController.m
//  WordClock
//
//  Created by Andrei Tchijov on 2/10/12.
//  Copyright (c) 2012 Leaping Bytes, LLC. All rights reserved.
//

#import "LBViewController.h"

@implementation LBViewController

#define IT_IS   [ NSNumber numberWithInt: 1 ]
#define HALF    [ NSNumber numberWithInt: 2 ]
#define TEN_M   [ NSNumber numberWithInt: 3 ]
#define QUARTER [ NSNumber numberWithInt: 4 ]
#define TWENTY  [ NSNumber numberWithInt: 5 ]
#define FIVE_M  [ NSNumber numberWithInt: 6 ]
#define MINUTES [ NSNumber numberWithInt: 7 ]
#define TO      [ NSNumber numberWithInt: 8 ]
#define PAST    [ NSNumber numberWithInt: 9 ]
#define ONE     [ NSNumber numberWithInt: 10 ]
#define THREE   [ NSNumber numberWithInt: 11 ]
#define TWO     [ NSNumber numberWithInt: 12 ]
#define FOUR    [ NSNumber numberWithInt: 13 ]
#define FIVE    [ NSNumber numberWithInt: 14 ]
#define SIX     [ NSNumber numberWithInt: 15 ]
#define SEVEN   [ NSNumber numberWithInt: 16 ]
#define EIGHT   [ NSNumber numberWithInt: 17 ]
#define NINE    [ NSNumber numberWithInt: 18 ]
#define TEN     [ NSNumber numberWithInt: 19 ]
#define ELEVEN  [ NSNumber numberWithInt: 20 ]
#define TWELVE  [ NSNumber numberWithInt: 21 ]
#define OCLOCK  [ NSNumber numberWithInt: 22 ]


@synthesize ticks;
@synthesize currentTicks;

- (void) initTicks {
    ticks = [ NSDictionary dictionaryWithObjectsAndKeys:
        [ NSArray arrayWithObjects: IT_IS, nil ],                           [ NSNumber numberWithInt: 0 ],
        [ NSArray arrayWithObjects: IT_IS, FIVE_M, MINUTES, PAST, nil ],             [ NSNumber numberWithInt: 5 ],
        [ NSArray arrayWithObjects: IT_IS, TEN_M, MINUTES, PAST, nil ],              [ NSNumber numberWithInt: 10 ],
        [ NSArray arrayWithObjects: IT_IS, QUARTER, PAST, nil ],            [ NSNumber numberWithInt: 15 ],
        [ NSArray arrayWithObjects: IT_IS, TWENTY, MINUTES, PAST, nil ],             [ NSNumber numberWithInt: 20 ],
        [ NSArray arrayWithObjects: IT_IS, TWENTY, FIVE_M, MINUTES, PAST, nil ],     [ NSNumber numberWithInt: 25 ],
        [ NSArray arrayWithObjects: IT_IS, HALF, PAST, nil ],               [ NSNumber numberWithInt: 30 ],
        [ NSArray arrayWithObjects: IT_IS, TWENTY, FIVE_M, MINUTES, TO, nil ],       [ NSNumber numberWithInt: 35 ],
        [ NSArray arrayWithObjects: IT_IS, TWENTY, MINUTES, TO, nil ],               [ NSNumber numberWithInt: 40 ],
        [ NSArray arrayWithObjects: IT_IS, QUARTER, TO, nil ],              [ NSNumber numberWithInt: 45 ],
        [ NSArray arrayWithObjects: IT_IS, TEN_M, MINUTES, TO, nil ],                [ NSNumber numberWithInt: 50 ],
        [ NSArray arrayWithObjects: IT_IS, FIVE_M, MINUTES, TO, nil ],               [ NSNumber numberWithInt: 55 ],        
        nil 
    ];
}

- (void) hideTicks: (NSArray*) anArray {
    for ( NSNumber* n in anArray ) {
        UILabel* l = (UILabel*)[ self.view viewWithTag: [ n intValue ]];
        
        l.textColor = [ UIColor grayColor ];
    }
}

- (void) showTicks: (NSArray*) anArray {
    for ( NSNumber* n in anArray ) {
        UILabel* l = (UILabel*)[ self.view viewWithTag: [ n intValue ]];
        
        l.textColor = [ UIColor whiteColor ];
    }
}

- (NSNumber*) tickH: (int) h {
    switch ( h ) {
        case 0: return  TWELVE;
        case 1: return  ONE;
        case 2: return  TWO;
        case 3: return  THREE;
        case 4: return  FOUR;
        case 5: return  FIVE;
        case 6: return  SIX;
        case 7: return  SEVEN;
        case 8: return  EIGHT;
        case 9: return  NINE;
        case 10: return  TEN;
        case 11: return  ELEVEN;
        case 12: return  TWELVE;

        default: return TWELVE;
    }
}

- (void) showTickH: (int) h M: (int) m {
    m = floor( m / 5 ) * 5;
    
    if( currentTicks != nil ) {
        [ self hideTicks: currentTicks ];
    }
    
    NSNumber* hTick = [ self tickH: h ];
    
    currentTicks = [ NSMutableArray arrayWithArray: [ self.ticks objectForKey: [ NSNumber numberWithInt: m ]]];
    
    [ currentTicks addObject: hTick ];
    
    if( m == 0 ) {
        [ currentTicks addObject: OCLOCK ];
    }
    
    [ self showTicks: currentTicks ];
}

- (void) doTick: (id) dummy {
    NSDate* date = [ NSDate date ];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];

    [ self showTickH: hour M: minute ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ self initTicks ];
    
    [ self doTick: nil ];
    
    [ NSTimer scheduledTimerWithTimeInterval: 60 target: self selector: @selector( doTick: ) userInfo: nil repeats: YES ];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsPortrait( interfaceOrientation );
}

@end
