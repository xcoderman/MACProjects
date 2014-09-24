//
//  RemittanceTableViewController.m
//  ToPeso
//
//  Created by pachie on 12/9/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "RemittanceTableViewController.h"
#import "com_pachie_topesoAppDelegate.h"
#import "CustomTableViewCell.h"
#import "Remittance.h"
#import "AgentDetailsTableViewController.h"
#import "CoreDataToPeso.h"
#import "SendAndRequest.h"

@interface RemittanceTableViewController ()

{
    com_pachie_topesoAppDelegate *del;
    UIRefreshControl *refreshControl;
}

@end

@implementation RemittanceTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"View" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
//    del = (com_pachie_topesoAppDelegate *)[[UIApplication sharedApplication]delegate];
//    
//    NSError *error;
//    if (![[self fetched] performFetch:&error]) {
//        // Update to handle the error appropriately.
//        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//        exit(-1);  // Fail
//    }
    
    
    

    
    refreshControl = [[UIRefreshControl alloc]init];
    
    [self.tableView addSubview:refreshControl];
    
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    
    [self refreshTable];

    
    
}

-(void)refreshTable
{
    
    del = (com_pachie_topesoAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    CoreDataToPeso *core = [[CoreDataToPeso alloc]init];
    //[core insertTempData];
    SendAndRequest *send = [[SendAndRequest alloc]init];
    
    NSString *lastModified = [core getLastUpdatedAgent];
    
    
    
    [send getLastesAgent:lastModified withBlock:^(NSArray *array, NSError *connectionError)
     {
         
         
         if (connectionError!=nil) {
             
             UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"Unable to connect to fetched latest updates" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];//, nil
             
             [alert show];
             
         }
         else
         {
             //image
             
             for (NSDictionary *dic in array) {
                 NSString *strImg = [dic objectForKey:@"logo"];
                 NSString *strURL = [NSString stringWithFormat:@"%@%@",[SendAndRequest UrlImageConnection],strImg];
                 
                 [send downloadImageWithURL:[NSURL URLWithString:strURL] completionBlock:^(BOOL succeeded, UIImage *image) {
                     
                     //UIImage *im = image;
                     
                     if (image != nil)
                     {
                         
                         NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
                         NSString *documentsDirectory = [paths objectAtIndex:0];
                         NSString *path = [documentsDirectory stringByAppendingPathComponent:strImg];
                         NSData *data = UIImagePNGRepresentation(image);
                         [data writeToFile:path atomically:YES];
                         
                     }
                     
                 }];
             }
             
             
             
             [core syncCoreDataAgent:array];
             
             
         }
         
         NSError *error;
         if (![self.fetched performFetch:&error]) {
             // Update to handle the error appropriately.
             NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
             exit(-1);  // Fail
         }
         

         [self performSelector:@selector(Done) withObject:nil afterDelay:1];
         
         if (del.isFromNotification== true) {
             
             [self performSegueWithIdentifier:@"agentDetails" sender:self];
         }
         
         
     }];
    
    
    
    
    
}

-(void)Done
{
    [refreshControl endRefreshing];
    [self.tableView reloadData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    id sections = [self.fetched sections];
    
    return [sections count];
    
    //return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    id sections = [[self.fetched sections]objectAtIndex:section];
    
    return  [sections numberOfObjects];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.fetched sections]objectAtIndex:section];
    
    return [sectionInfo name];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    if (cell == nil)
    {
        //cell = [[PickupLineTableViewCell alloc] initWithStyle:uita reuseIdentifier:CellIdentifier];
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"View" owner:self options:nil];
        cell = (CustomTableViewCell *) [nib objectAtIndex:0];
        
    }
    
//    
//    NSSet *unique = [NSSet setWithArray:[mArray valueForKey:@"CountryName"]];
//    
//    NSString *arUnique = [[unique allObjects] objectAtIndex:indexPath.section];
//    
//    NSArray *ar = [mArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"CountryName like [cd] %@",arUnique]];
//    
//    
//    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"CountryName" ascending:YES];
//    
//    NSArray * sortedArray=[ar sortedArrayUsingDescriptors:@[sort]];
    
    //    NSArray *sortedArray = [ar sortedArrayUsingComparator:^NSComparisonResult(NSString *p1, NSString *p2){
    //
    //        return [p1 compare:p2];
    //
    //    }];
    
    //NSArray * sortedArray = [ar sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    Remittance *rem = [self.fetched objectAtIndexPath:indexPath];
    
    
    
    cell.lblRemmitanceName.text = rem.remittanceName;
    
    NSNumberFormatter *numberformatter = [[NSNumberFormatter alloc]init];
    
    [numberformatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSString *str = [numberformatter stringFromNumber:rem.rate];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc]init];
    
    [dateFormat setDateFormat:@"dd MMM yyyy"];
    [timeFormat setDateFormat:@"hh:mm a"];
    
    NSString *strDate = [dateFormat stringFromDate:rem.asofDate];
    //NSString *strTime = [timeFormat stringFromDate:rem.asofDate];
    
    cell.lblRate.text =[NSString stringWithFormat:@"%@ as of %@",str,strDate];
    

    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"hh:mm a"];
    
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    
    [format setTimeZone:gmt];
    
    
    
    
    cell.lbltime.text = [format stringFromDate:rem.asofDate];
    
    

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      [rem valueForKey:@"logo"]];
    UIImage* image = [UIImage imageWithContentsOfFile:path];

    
    
    if (image == nil) {
        image = [UIImage imageNamed:@"default.png"];
    }
    
    
    cell.imgRemittanceImage.image = image;
    
//    cell.imageView.image = [UIImage imageNamed:@"default.png"];
    cell.imgRemittanceImage.layer.cornerRadius = 10;
    cell.imgRemittanceImage.clipsToBounds = YES;
    cell.imgRemittanceImage.layer.borderWidth = .4;
    cell.imgRemittanceImage.layer.borderColor = [UIColor lightGrayColor].CGColor;

    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
                            
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"agentDetails" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual:@"agentDetails"]) {
        
        NSIndexPath *indexpath = [self.tableView indexPathForSelectedRow];
        
        AgentDetailsTableViewController *agent = (AgentDetailsTableViewController *)segue.destinationViewController;
        
        Remittance *rem = [self.fetched objectAtIndexPath:indexpath];
        
        if (del.isFromNotification== true) {
            rem = [self getAgentDetail:del.notifcationAgentID];
        }
        else
        {
            rem  = [self.fetched objectAtIndexPath:indexpath];
        }
        
        
        
        agent.remitanceAgent = rem;
        agent.country = self.country;
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

#pragma mark -fetched controller

-(NSFetchedResultsController *)fetched
{
//    if (_fetched) {
//        return  _fetched;
//    }
//    
//    NSFetchRequest *request = [[NSFetchRequest alloc]init];
//    
//    NSEntityDescription *des = [NSEntityDescripti	on entityForName:@"Remittance" inManagedObjectContext:del.managedObjectContext];
//    
//    [request setEntity:des];
//    
//    NSSortDescriptor *sort1 = [[NSSortDescriptor alloc]initWithKey:@"remittanceName" ascending:YES];
//    
//    [request setSortDescriptors:[NSArray arrayWithObject:sort1]];
//    
//    [request setFetchBatchSize:20];
//    
//    
//    NSFetchedResultsController *f = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:del.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
//    
//    
//    self.fetched = f;
//    
//    [self.fetched setDelegate:self];
//    
//    return _fetched;
    
    
    if (_fetched) {
        return _fetched;
    }
    
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Remittance" inManagedObjectContext:del.managedObjectContext];
    
    [request setEntity:entity];
    
    NSSortDescriptor *sort1 = [[NSSortDescriptor alloc]initWithKey:@"currencyKey" ascending:YES];
   
    NSSortDescriptor *sort2 = [[NSSortDescriptor alloc]initWithKey:@"remittanceName" ascending:YES];
    
    
    [request setSortDescriptors:[NSArray arrayWithObjects:sort1,sort2, nil]];
    
    //[request setPredicate:[NSPredicate predicateWithFormat:@"isDeleted1 == YES"]];
    
    
    NSPredicate *pred ;
    
    if (del.isFromNotification == true) {
        pred = [NSPredicate predicateWithFormat:@"countryCode = %@ AND isDeleted1 = %@",del.notficationCountryCode,@"NO"];
    }
    else
    {
        pred = [NSPredicate predicateWithFormat:@"countryCode = %@ AND isDeleted1 = %@",self.country.countryCode,@"NO"];
    }
    
    
    
    
    [request setPredicate:pred];
    
    NSFetchedResultsController *f = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:del.managedObjectContext sectionNameKeyPath:@"currencyKey" cacheName:nil];
    
    self.fetched = f;
    
    [self.fetched setDelegate: self];
    
    return self.fetched;
    
    
}

-(Remittance *)getAgentDetail :(NSString *)remittanceGUID
{
    CoreDataToPeso *core = [[CoreDataToPeso alloc]init];
    
    return [core getRemittanceByID:del.notifcationAgentID];
    
    
}

@end
