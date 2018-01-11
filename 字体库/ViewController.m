//
//  ViewController.m
//  字体库
//
//  Created by iSongWei on 2017/11/14.
//  Copyright © 2017年 iSong. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()<UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) IBOutlet UITableView * tableView;

@property (nonatomic,strong) NSMutableArray  * dataArr;



@property (strong, nonatomic) NSArray *list;
@property (strong, nonatomic) NSMutableArray *searchList;
@property (nonatomic,strong) UISearchController * searchVC;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    _dataArr = [UIFont familyNames].mutableCopy;
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
        
        
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    
    
    
    _searchVC= [[UISearchController alloc]initWithSearchResultsController:nil];
    _searchVC.searchBar.backgroundColor = [UIColor lightGrayColor];
    //是否添加半透明覆盖层。为YES，搜索时，背景会变暗（背景变模糊）。默认为YES
    _searchVC.dimsBackgroundDuringPresentation = NO;
    //是否隐藏导航栏。为YES，搜索时，UINavigationBar会隐藏。默认为YES
    _searchVC.hidesNavigationBarDuringPresentation  = YES;
    
//    [self.navigationController setNavigationBarHidden:YES];
    _tableView.tableHeaderView  = _searchVC.searchBar;
    
    
    self.definesPresentationContext = YES;
    

    _searchVC.searchResultsUpdater = self;

    
    
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:@"取消"];
    _searchVC.searchBar.placeholder=@"请输入名称或者数字";
    _searchVC.searchBar.autocapitalizationType=UITextAutocapitalizationTypeNone;
//    _searchVC.searchBar.showsCancelButton=YES;//显示取消按钮
    
    
    
    
    
    
    
}



#pragma mark - ===============UITableViewDelegate===============


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * acell = @"UITableViewCell";
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:acell];
    NSArray *ff = [UIFont fontNamesForFamilyName:_dataArr[indexPath.section]];
    
    
    
    if (ff.count) {
        cell.textLabel.text = ff[indexPath.row];
        cell.textLabel.font = [UIFont fontWithName:ff[indexPath.row] size:20];
        
        cell.detailTextLabel.text = @"苹果字体&ABC&abc&0123456789";
        cell.detailTextLabel.font = [UIFont fontWithName:ff[indexPath.row] size:20];
        
        
    }else{
        cell.textLabel.text = _dataArr[indexPath.section];
        cell.textLabel.font = [UIFont fontWithName:_dataArr[indexPath.section] size:20];
        
        cell.detailTextLabel.text = @"苹果字体&ABC&abc&0123456789";
        cell.detailTextLabel.font = [UIFont fontWithName:_dataArr[indexPath.section] size:20];
        cell.detailTextLabel.numberOfLines = 0;
    }
    
    return cell;
    
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView * view  =[[UIView alloc]initWithFrame:(CGRectMake(0, 0, 375, 36))];
    view.backgroundColor = [UIColor colorWithRed:.93 green:.93 blue:.93 alpha:1.00];;
    UILabel * ll = [[UILabel alloc]initWithFrame:(CGRectMake(30, 0, 250, 36))];
    ll.textColor = [UIColor colorWithRed:.63 green:.63 blue:.64 alpha:1.00];;
    ll.text = _dataArr[section];
    
    [view addSubview:ll];
    
    
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    NSArray *ff = [UIFont fontNamesForFamilyName:_dataArr[section]];
    if (ff.count) {
        return ff.count;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_dataArr[indexPath.section] isEqualToString:@"Zapfino"]) {
        return 180;
    }
    return 80;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    
    return 36;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
    
    NSArray *ff = [UIFont fontNamesForFamilyName:_dataArr[indexPath.section]];
    
    if (ff.count) {
        pasteboard.string = ff[indexPath.row];
    }else{
        pasteboard.string = _dataArr[indexPath.section];
    }
    DetailViewController * vc  = [[DetailViewController alloc]init];
    if (ff.count) {
        vc.Fname = ff[indexPath.row];
    }else{
        vc.Fname = _dataArr[indexPath.section];
    }
    self.searchVC .active = NO;
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}



- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    NSString *searchString = searchController.searchBar.text;
    //NSPredicate 谓词
    
    if (searchString && ![searchString isEqualToString:@""]) {
        
        _searchList = @[].mutableCopy;
        
        for (NSString * str in [UIFont familyNames]) {
            
            if ([str.lowercaseString rangeOfString:searchString.lowercaseString].length > 0) {
                [_searchList addObject:str];
            }
    
        }
        
        _dataArr = _searchList;
        
        
    }else{
        _dataArr = [UIFont familyNames].mutableCopy;
    }
    
    [_tableView reloadData];

    NSLog(@"%@", searchString);
    
    
    
}




@end
