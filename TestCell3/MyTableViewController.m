//
//  MyTableViewController.m
//  TestCell3
//
//  Created by pachie on 12/8/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "MyTableViewController.h"
#import "MyXTableViewCell.h"
#import "PageDetailViewController.h"
//#import "NSString+URLEncode.h"



@interface MyTableViewController ()
{
    NSMutableArray *mArray;
    NSXMLParser *parser;
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *link;
    NSMutableString *description;
    NSMutableString *pubdate;
    NSString *element;
}

@end

@implementation MyTableViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    
    if ([element isEqualToString:@"item"]) {
        
        item    = [[NSMutableDictionary alloc] init];
        title   = [[NSMutableString alloc] init];
        link    = [[NSMutableString alloc] init];
        description = [[NSMutableString alloc]init];
        pubdate = [[NSMutableString alloc]init];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:@"title"]) {
        [title appendString:string];
    } else if ([element isEqualToString:@"link"]) {
        [link appendString:string];
    } else if ([element isEqualToString:@"description"]) {
        [description appendString:string];

    }
 else if ([element isEqualToString:@"pubDate"]) {
    [pubdate appendString:string];
    
}


}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"item"]) {
        
        [item setObject:title forKey:@"title"];
        [item setObject:link forKey:@"link"];
        [item setObject:description forKey:@"description"];
        [item setObject:pubdate forKey:@"pubDate"];
        
        [mArray addObject:[item copy]];
        
    }
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self.tableView reloadData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"View" bundle:nil] forCellReuseIdentifier:@"Cell"];
    mArray = [[NSMutableArray alloc]init];
    
    
    //feeds = [[NSMutableArray alloc] init];
    NSURL *url = [NSURL URLWithString:@"http://images.apple.com/main/rss/hotnews/hotnews.rss"];
    //NSURL *url = [NSURL URLWithString:@"http://feeds.bbci.co.uk/news/rss.xml"];
    
    
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    
    
//    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:
//                         @"Hindi kaba napapagod Hindi kaba napapagod Hindi kaba kaba napapagod Hindi kaba napapagod Hindi kaba napapagod Hindi kaba napapagod Vestibulum ligula quam, gravida ut convallis semper, bibendum in turpis. Break on objc_exception_throw to catch this in the debugger.The methods in the UIConstraintBasedLayoutDebugging \n\ncategory on UIView listed in <UIKit/UIView.h> may also be helpful.2014-08-13 18:49:34.816 TestCell3[9856:60b] Unable to simultaneously satisfy constraints123",@"Message",
//                         @"Jun 30, 2014 11:55 AM",@"SentDate",
//                         @"Kasi ayaw ko syo",@"Answer",
//                         @"Boy Basag",@"CreatedBy",
//                         nil];
//    
//    [mArray addObject:dic];
//    
//    dic = [[NSDictionary alloc]initWithObjectsAndKeys:
//           @"Duling Kaba Hindi kaba napapagod Hindi kaba napapagod Hindi kaba kaba napapagod Hindi kaba napapagod Hindi kaba napapagod Hindi kaba napapagod Vestibulum ligula quam, gravida ut convallis semper, bibendum in turpis. Break on objc_exception_throw to catch this in the debugger.The methods in the UIConstraintBasedLayoutDebugging \n\ncategory on UIView listed in <UIKit/UIView.h> may also be helpful.2014-08-13 18:49:34.816 TestCell3[9856:60b] Unable to simultaneously satisfy constraints123Hindi kaba napapagod Hindi kaba napapagod Hindi kaba kaba napapagod Hindi kaba napapagod Hindi kaba napapagod Hindi kaba napapagod Vestibulum ligula quam, gravida ut convallis semper, bibendum in turpis. Break on objc_exception_throw to catch this in the debugger.The methods in the UIConstraintBasedLayoutDebugging \n\ncategory on UIView listed in <UIKit/UIView.h> may also be helpful.2014-08-13 18:49:34.816 TestCell3[9856:60b] Unable to simultaneously satisfy constraints123Hindi kaba napapagod Hindi kaba napapagod Hindi kaba kaba napapagod Hindi kaba napapagod Hindi kaba napapagod Hindi kaba napapagod Vestibulum ligula quam, gravida ut convallis semper, bibendum in turpis. Break on objc_exception_throw to catch this in the debugger.The methods in the UIConstraintBasedLayoutDebugging \n\ncategory on UIView listed in <UIKit/UIView.h> may also be helpful.2014-08-13 18:49:34.816 TestCell3[9856:60b] Unable to simultaneously satisfy constraints123Hindi kaba napapagod Hindi kaba napapagod Hindi kaba kaba napapagod Hindi kaba napapagod Hindi kaba napapagod Hindi kaba napapagod Vestibulum ligula quam, gravida ut convallis semper, bibendum in turpis. Break on objc_exception_throw to catch this in the debugger.The methods in the UIConstraintBasedLayoutDebugging \n\ncategory on UIView listed in <UIKit/UIView.h> may also be helpful.2014-08-13 18:49:34.816 TestCell3[9856:60b] Unable to simultaneously satisfy constraints123Hindi kaba napapagod Hindi kaba napapagod Hindi kaba kaba napapagod Hindi kaba napapagod Hindi kaba napapagod Hindi kaba napapagod Vestibulum ligula quam, gravida ut convallis semper, bibendum in turpis. Break on objc_exception_throw to catch this in the debugger.The methods in the UIConstraintBasedLayoutDebugging \n\ncategory on UIView listed in <UIKit/UIView.h> may also be helpful.2014-08-13 18:49:34.816 TestCell3[9856:60b] Unable to simultaneously satisfy constraints123",@"Message",
//           @"Jun 30, 2014 11:55 AM",@"SentDate",
//           @"Kasi baho mo eh",@"Answer",
//           @"Boy Konyat",@"CreatedBy",
//           nil];
//    
//    [mArray addObject:dic];
//    
//    dic = [[NSDictionary alloc]initWithObjectsAndKeys:
//           @"Duling Kaba kasi ayaw ko syo eh, anu ba gusto mo mangyari?",@"Message",
//           @"Jun 30, 2014 11:55 AM",@"SentDate",
//           @"Kasi baho mo eh",@"Answer",
//           @"Boy Konyat",@"CreatedBy",
//           nil];
//    
//    [mArray addObject:dic];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [mArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    //register cell identifier from custom cell NIB
    static NSString *CellIdentifier = @"Cell";
    MyXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = [mArray objectAtIndex:indexPath.row];
    
    //NSString *x = [dic objectForKey:@"Message"];
    
    cell.labelMessage.text = [dic objectForKey:@"description"] ;
    [cell.labelMessage setNumberOfLines:0];
    [cell.labelMessage setLineBreakMode:NSLineBreakByWordWrapping];
    //[cell.labelMessage setBackgroundColor:[UIColor greenColor]];

    CGFloat width = 283;
    UIFont *font = [UIFont fontWithName:@"TrebuchetMS" size:12];
    
    NSMutableParagraphStyle *pStyle =  [[NSMutableParagraphStyle alloc]init];
    [pStyle setLineSpacing:4];
    
    
    NSMutableAttributedString
    *attributedText =  [[NSMutableAttributedString alloc] initWithString:[dic objectForKey:@"description"]
     attributes:@
     {
     NSFontAttributeName: font
     }];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    
    [attributedText addAttribute:NSParagraphStyleAttributeName value:pStyle range:NSMakeRange(0, attributedText.length)];
    
    
    
    UIFont *myboldFont = [UIFont fontWithName:@"TrebuchetMS-Bold" size:12];
    
    NSMutableAttributedString
    *attributedText2 =  [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%1@\n", [dic objectForKey:@"title"]]
              attributes:@
                        {
                        NSFontAttributeName: myboldFont
                        }];
    //CGRect rect = [attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                               //options:NSStringDrawingUsesLineFragmentOrigin
                                               //context:nil];
    
    [attributedText2 appendAttributedString:attributedText];
    
    cell.labelMessage.attributedText = attributedText2 ;
    
    
    [cell.labelMessage setFrame:rect];
    
    [cell.labelMessage sizeToFit];
    
    
   // NSDateFormatter *format = [[NSDateFormatter alloc]init];
    //[format setDateFormat:@"dd MMM yyyy hh:mm a"];
    
   // NSDate *date = [format dateFromString:[dic objectForKey:@"pubDate"]];
    
    
    NSString *datestr =  [[dic objectForKey:@"pubDate"] stringByReplacingOccurrencesOfString:@" PDT" withString:@""];
    
    cell.labelDate.text = datestr;
    
    [cell setFrame:rect];
    
    return cell;
       
    

}

- (NSString *)quotationTextForRow:(int)row {
    
    NSDictionary *dic = [[NSDictionary alloc]init];
    
    dic = [mArray objectAtIndex:row];
    
    return [dic objectForKey:@"description"];
}



- (CGSize)sizeOfLabel:(UILabel *)label withText:(NSString *)text withText2:(NSString *)text2{

//    CGFloat width = 280;
//    UIFont *font = [UIFont systemFontOfSize:12];
//    NSAttributedString *attributedText =
//    [[NSAttributedString alloc]
//     initWithString:text
//     attributes:@
//     {
//     NSFontAttributeName: font
//     }];
//    
//
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenWidth = screenSize.width;
    //CGFloat screenHeight = screenSize.height;
    
    CGFloat width =    screenWidth;
    UIFont *font = [UIFont fontWithName:@"TrebuchetMS" size:12];
    UIFont *myboldFont = [UIFont fontWithName:@"TrebuchetMS-Bold" size:12];

    
    NSMutableParagraphStyle *pStyle =  [[NSMutableParagraphStyle alloc]init];
    [pStyle setLineSpacing:4];
    
    NSMutableAttributedString
    *attributedText2 =  [[NSMutableAttributedString alloc] initWithString:text2
                                                               attributes:@
                         {
                         NSFontAttributeName: myboldFont
                         }];
    
    NSMutableAttributedString
    *attributedText =  [[NSMutableAttributedString alloc] initWithString:text
                                                              attributes:@
                        {
                        NSFontAttributeName: font
                        }];
//    CGRect rect = [attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
//                                               options:NSStringDrawingUsesLineFragmentOrigin
//                                               context:nil];
    
    [attributedText addAttribute:NSParagraphStyleAttributeName value:pStyle range:NSMakeRange(0, attributedText.length)];
    
    
    
    
    [attributedText appendAttributedString:attributedText2];
    
    
    [label sizeToFit];
    
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    
    return size;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        [self performSegueWithIdentifier: @"showdetail" sender: self];
   
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqual:@"showdetail"]) {
        NSIndexPath *indexpath = [self.tableView indexPathForSelectedRow];
        
        NSDictionary *dic = [mArray objectAtIndex:indexpath.row];
        NSString *str = [dic objectForKey:@"link"];
        
        PageDetailViewController *dv = segue.destinationViewController;
        
        dv.strURL = str;
        
//        [[segue destinationViewController] setURL:[NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    }
    
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //set width depending on device orientation
    self.cellPrototype.frame = CGRectMake(self.cellPrototype.frame.origin.x, self.cellPrototype.frame.origin.y, tableView.frame.size.width, self.cellPrototype.frame.size.height);
    
    NSDictionary *dic = [mArray objectAtIndex:indexPath.row];
    NSString *ti = [dic objectForKey:@"title"];
    
    CGFloat quotationLabelHeight = [self sizeOfLabel:self.cellPrototype.labelMessage withText:[self quotationTextForRow:indexPath.row] withText2:ti].height;
//    CGFloat attributionLabelHeight = [self sizeOfLabel:self.cellPrototype.labelMessage withText:[self attributionTextForRow:indexPath.row]].height;
    //CGFloat padding = self.cellPrototype.labelMessage.frame.origin.y;
    
    //CGFloat combinedHeight = padding + quotationLabelHeight + padding/2 + padding;
    //CGFloat minHeight = padding + self.cellPrototype.labelMessage.frame.size.height + padding;
    
    
    
    if (UIDeviceOrientationIsPortrait(self.interfaceOrientation)){
        //DO Portrait
        return quotationLabelHeight + 60;
    }else{
        //DO Landscape
        return quotationLabelHeight - 40;
    }
    //;//MAX(combinedHeight, minHeight);


}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
