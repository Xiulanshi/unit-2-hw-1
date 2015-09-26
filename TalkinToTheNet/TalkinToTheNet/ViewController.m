//
//  ViewController.m
//  TalkinToTheNet
//
//  Created by Michael Kavouras on 9/20/15.
//  Copyright © 2015 Mike Kavouras. All rights reserved.
//

#import "ViewController.h"
#import "APIManager.h"
#import "PlaceResult.h"
#import "DetailViewController.h"


@interface ViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
UITextFieldDelegate
>

@property (weak, nonatomic) IBOutlet UITextField *findTextField;
@property (weak, nonatomic) IBOutlet UITextField *searchPlaceTextField;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSMutableArray *searchResults;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.searchPlaceTextField.delegate = self;
}

- (void) makeNewAPIRequestWithSearchTerm:(NSString*)searchTerm andLocation:(NSString*)location
                           callbackBlock:(void(^)())block{
    
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?near=%@&query=%@&client_id=SVBBDTUHT5WOBDQ5NINYVTLNDNTHGD0XGRRE0LMB304VMWG1&client_secret=ZHPO4GOAGH3YSPQNQZAYC13YJ420Q2IPXAI0CRHQ0I3SB0HL&v=20150925", location, searchTerm];
    
    NSString *encodedString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:encodedString];
    
    [APIManager GETRequestWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (data != nil) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            NSArray *results = json[@"response"][@"venues"];
            
            self.searchResults =[[NSMutableArray alloc] init];
            
            for (NSDictionary *result in results) {
                
                NSString *name = result[@"name"];
                NSString *address = result[@"location"][@"address"];
                NSString *city = result[@"location"][@"city"];
                NSString *state = result[@"location"][@"state"];
                NSString *postCode = result[@"location"][@"postalCode"];
                
                PlaceResult *placeObject = [[PlaceResult alloc] init];
                placeObject.name = name;
                placeObject.address = [NSString stringWithFormat:@"%@, %@, %@ %@", address, city, state, postCode];
                
                [self.searchResults addObject:placeObject];
                
            }
            
            block();
        }
        
    }];
    
}


# pragma mark - tableView delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.searchResults.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    PlaceResult *result = [self.searchResults objectAtIndex:indexPath.row];
    
    cell.textLabel.text = result.name;
    cell.detailTextLabel.text = result.address;

    return cell;
}

# pragma mark - text field delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.view endEditing:YES];
    
    [self makeNewAPIRequestWithSearchTerm:self.findTextField.text andLocation:textField.text callbackBlock:^{
        [self.tableView reloadData];
    }];
    
    return YES;
}

# pragma mark - segua

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    PlaceResult *currentPlace = self.searchResults[indexPath.row];
    
    DetailViewController *viewController = segue.destinationViewController;
    
    viewController.place = currentPlace;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
