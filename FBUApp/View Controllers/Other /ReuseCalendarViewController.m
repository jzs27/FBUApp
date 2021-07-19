//
//  ReuseCalendarViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/19/21.
//

#import "ReuseCalendarViewController.h"

@interface ReuseCalendarViewController ()

@end

NSUInteger numDays;//1-31
int thisYear;//2015
int weekday;//1-7
int thisMonth;//1-12

@implementation ReuseCalendarViewController

@synthesize monthly;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self myCalView];
    
}

- (IBAction)didTapNext:(id)sender {
    thisMonth++;
    [self removeTags];
    [self updateCalNow];
}

- (IBAction)didTapPrev:(id)sender {
    thisMonth--;
    [self removeTags];
    [self updateCalNow];
    
}

-(void) removeTags{
    int x=1;
    while (x<=31){
        [[self.view viewWithTag:x] removeFromSuperview];
        x++;
    }
}

//this method creates the calendar
-(void)myCalView{
    thisYear = [[[NSCalendar currentCalendar]
                 components:NSCalendarUnitYear fromDate:[NSDate date]]
                year];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comps2 = [cal components:NSCalendarUnitMonth fromDate:[NSDate date]];
    thisMonth=[comps2 month];
    [self moreDateInfo];
}

-(NSUInteger)getCurrDateInfo:(NSDate *)myDate{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSRange rng = [cal rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:myDate];
    NSUInteger numberOfDaysInMonth = rng.length;
    
    return numberOfDaysInMonth;
}

-(void)updateCalNow{
    if(thisMonth>12){
        thisMonth=1;
        thisYear++;
    }
    
    if(thisMonth<1){
        thisMonth=12;
        thisYear--;
    }
    [self moreDateInfo];
}

-(void)moreDateInfo{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //get first day of month's weekday
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:1];
    [components setMonth:thisMonth];
    [components setYear:thisYear];
    NSDate * newDate = [calendar dateFromComponents:components];
     NSDateComponents *comps = [gregorian components:NSCalendarUnitWeekday fromDate:newDate];
      weekday=[comps weekday];

    //Get number of days in the month
    numDays=[self getCurrDateInfo:newDate];
    
    int newWeekDay=weekday-1;//make weekday zero based
    
    //coordinates for displaying the buttons
    int yVal=175;
    int yCount=1;
    //Display name of month++++++++++++++++++++++++++++++++++++++++++++
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //NSLog(@"%@",[[formatter monthSymbols] objectAtIndex:(thisMonth - 1)]);
    monthly.text=[[formatter monthSymbols] objectAtIndex:(thisMonth - 1)];
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 
    //use for loop to display each day
    for(int startD=1; startD<=numDays;startD++){
        UIButton *addProject = [UIButton buttonWithType: UIButtonTypeRoundedRect];
        
        int xCoord=(newWeekDay*40)+15;
        int yCoord=(yCount*30)+yVal;
        
        newWeekDay++;
        if(newWeekDay>6){//drops buttons on y axis every 7 days
            newWeekDay=0;
            yCount++;
        }
        
        //Creates the buttons and gives them each a tag (id)
        //int popInt=startD;
        addProject.frame = CGRectMake(xCoord, yCoord, 35, 25);
        [addProject setTitle:[NSString stringWithFormat:@"%d", startD] forState:UIControlStateNormal];
        [addProject addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventTouchUpInside];
        [addProject setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        addProject.tag = startD;
        addProject.backgroundColor = [UIColor grayColor];
        [self.view addSubview:addProject];
    }
}

-(void)selectDate: (id) sender {
    UIButton* btn = (UIButton *) sender;

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:[btn.currentTitle integerValue]];
    [components setMonth:thisMonth];
    [components setYear:thisYear];
    NSDate * newDate = [calendar dateFromComponents:components];
    //Formats date to YYYY-MM-DD
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-dd"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

/*
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}
*/

@end
