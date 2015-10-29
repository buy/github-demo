//
//  RepoResultsViewController.m
//  GithubDemo
//
//  Created by Nicholas Aiwazian on 9/15/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "RepoResultsViewController.h"
#import "MBProgressHUD.h"
#import "GithubRepo.h"
#import "GithubRepoSearchSettings.h"
#import "RepoCellTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface RepoResultsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) GithubRepoSearchSettings *searchSettings;
@property (weak, nonatomic) IBOutlet UITableView *repoResultView;
@property (strong, nonatomic) NSArray *repos;
@end

@implementation RepoResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.repoResultView.estimatedRowHeight = 1000;
    self.repoResultView.rowHeight = UITableViewAutomaticDimension;
    self.repoResultView.dataSource = self;
    self.repoResultView.delegate = self;

    self.searchSettings = [[GithubRepoSearchSettings alloc] init];
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    [self.searchBar sizeToFit];
    self.navigationItem.titleView = self.searchBar;
    [self doSearch];
}

- (void)doSearch {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [GithubRepo fetchRepos:self.searchSettings successCallback:^(NSArray *repos) {
        self.repos =repos;
        [self.repoResultView reloadData];

        for (GithubRepo *repo in repos) {
            NSLog(@"%@", repo);
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self.searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    [self.searchBar setShowsCancelButton:NO animated:YES];
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = @"";
    [searchBar resignFirstResponder];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.searchSettings.searchString = searchBar.text;
    [searchBar resignFirstResponder];
    [self doSearch];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.repos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RepoCellTableViewCell *cell = [self.repoResultView dequeueReusableCellWithIdentifier:@"RepoCell"];
    GithubRepo *repo = self.repos[indexPath.row];
    cell.repoName.text = repo.name;
    cell.starsLabel.text = [NSString stringWithFormat:@"%ld",repo.stars];
    cell.forksLabel.text = [NSString stringWithFormat:@"%ld",repo.forks];

    cell.ownerLabel.text = repo.ownerHandle;
    cell.descriptionLabel.text = repo.repoDescription;
    NSURL *imageURL = [[NSURL alloc] initWithString: repo.ownerAvatarURL];
    [cell.ownerImage setImageWithURL:imageURL];

    return cell;
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    MovieDetailsViewController *movieDetailsViewController = [segue destinationViewController];
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
//    NSDictionary *movie = self.movies[indexPath.row];
//    
//    movieDetailsViewController.movie = movie;
//}
@end
