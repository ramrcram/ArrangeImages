//
//  ViewController.m
//  ArrangeImages
//
//  Created by Ramesh on 09/08/16.
//  Copyright © 2016 rubixtechnologies. All rights reserved.
//

#import "ViewController.h"
#import "Slide.h"

@interface ViewController ()
{
    CGSize wideSlideSize;
    CGSize normalSlideSize_big;
    CGSize normalSlideSize_small;
    NSMutableArray* slideArray;
    int currentIndex;
}
@property(nonatomic,assign) CGRect currentSlideFrame;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    wideSlideSize = CGSizeMake(self.view.frame.size.width, 100);
    normalSlideSize_big = CGSizeMake(self.view.frame.size.width, 400);
    normalSlideSize_small = CGSizeMake(self.view.frame.size.width/2, 200);
    self.currentSlideFrame = CGRectZero;
    
    slideArray = [self createSlide];
    currentIndex = 0;
    
    [self prepareSlides];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Methods

-(void)prepareSlides{
    
    [self addSlide:currentIndex];
    
    if ([self isNextSlideAvailble:currentIndex]) {
        [self prepareSlides];
    }
    
    //Add default Slide
}

-(void)addSlide:(int)indexValue{
    
    if (indexValue == 0)
        self.currentSlideFrame = CGRectZero;
    
    if (((Slide*)slideArray[indexValue]).slideType == WIDE) {
        Slide* sObj = (Slide*)slideArray[indexValue];
        [self.view addSubview:[self createWideSlide:[UIImage imageNamed:sObj.imageName]]];
    }else if (((Slide*)slideArray[indexValue]).slideType == NORMAL &&
             [self isNextSlideAvailble:indexValue + 1]  &&
             ((Slide*)slideArray[indexValue + 1]).slideType == NORMAL) {
        
        Slide* sObj_1 = (Slide*)slideArray[indexValue];
        Slide* sObj_2 = (Slide*)slideArray[indexValue + 1];
        [self.view addSubview:[self createSplitSlide:[UIImage imageNamed:sObj_1.imageName]
                                              image2:[UIImage imageNamed:sObj_2.imageName]]];
        
        currentIndex = currentIndex + 1;
    }else if (((Slide*)slideArray[indexValue]).slideType == NORMAL &&
             [self isNextSlideAvailble:indexValue + 1]  &&
             ((Slide*)slideArray[indexValue + 1]).slideType == WIDE) {
        
        Slide* sObj_1 = (Slide*)slideArray[indexValue];
        [self.view addSubview:[self createNormalSlide:[UIImage imageNamed:sObj_1.imageName]]];
    }else if (((Slide*)slideArray[indexValue]).slideType == NORMAL) {
        
        Slide* sObj = (Slide*)slideArray[indexValue];
        [self.view addSubview:[self createNormalSlide:[UIImage imageNamed:sObj.imageName]]];
        
    }
    
    currentIndex = currentIndex + 1;
}

-(BOOL)isNextSlideAvailble:(int)indexValue{
    
    if([slideArray count] > indexValue)
        return YES;
    
    return NO;
    
}

-(UIImageView*)createWideSlide :(UIImage*)imgWideSilde{
    
    UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.currentSlideFrame.origin.x,
                                                                        self.currentSlideFrame.origin.y,
                                                                        wideSlideSize.width, wideSlideSize.height)];
    imgView.image =imgWideSilde;

    self.currentSlideFrame = CGRectMake(self.currentSlideFrame.origin.x,
                                        (self.currentSlideFrame.origin.y + wideSlideSize.height),
                                        wideSlideSize.width, wideSlideSize.height);
    return imgView;
}

-(UIImageView*)createNormalSlide :(UIImage*)imgWideSilde{
    
    UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.currentSlideFrame.origin.x,
                                                                         self.currentSlideFrame.origin.y,
                                                                         normalSlideSize_big.width, normalSlideSize_big.height)];
    imgView.image =imgWideSilde;
    
    self.currentSlideFrame = CGRectMake(self.currentSlideFrame.origin.x,
                                        (self.currentSlideFrame.origin.y + normalSlideSize_big.height),
                                        wideSlideSize.width, wideSlideSize.height);
    
    return imgView;
}

-(UIView*)createSplitSlide :(UIImage*)imgWideSilde1 image2:(UIImage*)imgWideSilde2{
    
    UIView* viewHolder = [[UIView alloc] initWithFrame:CGRectMake(self.currentSlideFrame.origin.x,
                                                                 self.currentSlideFrame.origin.y,
                                                                 normalSlideSize_big.width,
                                                                  normalSlideSize_small.height)];
    
    
    UIImageView* imgView_1 = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,
                                                                         normalSlideSize_small.width, normalSlideSize_small.height)];
    imgView_1.image =imgWideSilde1;
    
    UIImageView* imgView_2 = [[UIImageView alloc] initWithFrame:CGRectMake(normalSlideSize_small.width,0,
                                                                         normalSlideSize_small.width, normalSlideSize_small.height)];
    imgView_2.image =imgWideSilde2;
    
    [viewHolder addSubview:imgView_1];
    [viewHolder addSubview:imgView_2];
    
    self.currentSlideFrame = CGRectMake(self.currentSlideFrame.origin.x,
                                        (self.currentSlideFrame.origin.y + viewHolder.frame.size.height),
                                        wideSlideSize.width, wideSlideSize.height);
    return viewHolder;
}

-(NSMutableArray*)createSlide{
    
    NSMutableArray* mArray = [[NSMutableArray alloc] init];
    
    Slide* slide_1 = [[Slide alloc] init];
    slide_1.imageName = @"image_1";
    slide_1.slideType = NORMAL;
    [mArray addObject:slide_1];
    
    Slide* slide_2 = [[Slide alloc] init];
    slide_2.imageName = @"image_2";
    slide_2.slideType = NORMAL;
    [mArray addObject:slide_2];
    
    Slide* slide_3 = [[Slide alloc] init];
    slide_3.imageName = @"image_3";
    slide_3.slideType = NORMAL;
    [mArray addObject:slide_3];
    
    Slide* slide_4 = [[Slide alloc] init];
    slide_4.imageName = @"image_4";
    slide_4.slideType = WIDE;
    [mArray addObject:slide_4];
    
    return mArray;
}

@end
