//
//  DetailViewController.m
//  TalkinToTheNet
//
//  Created by Xiulan Shi on 9/25/15.
//  Copyright © 2015 Mike Kavouras. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *instagramPosts;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.nameLabel.text = self.place.name;
    self.addressLabel.text = self.place.address;
//    [self fetchInstagramData];
}
//
//- (void)fetchInstagramData {
//    // create an instagram url
//    NSURL *instagramURL = [NSURL URLWithString:@"https://api.instagram.com/v1/tags/starbucks/media/recent?client_id=ac0ee52ebb154199bfabfb15b498c067"];
//    
//    // fetch data from the instagram endpoint and print json response
//    [APIManager GETRequestWithURL:instagramURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        
//        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        
//        self.instagramPosts = json[@"data"];
//        
//        [self.tableView reloadData];
//        
//    }];
//    
//}

# pragma mark -tableView delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.instagramPosts.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCellIdentifier" forIndexPath:indexPath];
    NSDictionary *post = [self.instagramPosts objectAtIndex:indexPath.row];
    NSDictionary *user = post[@"user"];
    NSString *userName = user[@"username"];
    cell.textLabel.text = userName;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
