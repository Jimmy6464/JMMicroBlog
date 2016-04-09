//
//  ContactViewController.m
//  ZQMicroBlog
//
//  Created by Ibokan on 15/11/26.
//  Copyright (c) 2015年 Cooperation. All rights reserved.
//

#import "ContactViewController.h"
#import "BaseMicorologEditViewController.h"
#import "UserTool.h"
#import "Users.h"
#import "pinyin.h"
#import "UIImageView+WebCache.h"
@interface ContactViewController ()<UITableViewDataSource,UITableViewDelegate>
/**
 *  显示tableView
 */
@property (nonatomic, strong) UITableView *contactView;
/**
 *  搜索框
 */
@property (nonatomic, strong) UISearchBar *searchBar;
/**
 *  分组字典
 */
@property (nonatomic, strong) NSMutableDictionary *groupDitc;
/**
 *  分组title
 */
@property (nonatomic, strong) NSArray *allKeys;
/**
 *  user数组
 */
@property (nonatomic, strong) NSMutableArray *users;
@end

@implementation ContactViewController
- (NSMutableDictionary *)groupDitc
{
    if (_groupDitc == nil) {
        NSMutableDictionary *dcit = [NSMutableDictionary new];
        _groupDitc = dcit;
    }
    return _groupDitc;
}
- (NSMutableArray *)users
{
    if (_users == nil) {
        NSMutableArray *marr = [NSMutableArray array];
        _users  = marr;
    }
    return _users;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *cancelBtnItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelBtnAction)];
    self.title = @"联系人";
    self.navigationItem.leftBarButtonItem = cancelBtnItem;
    
    [self setUpSubviews];
    [self setUpData];
    // Do any additional setup after loading the view.
}
- (void)setUpSubviews
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:KeyWindow.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    tableView.sectionIndexColor = [UIColor lightGrayColor];
    
    [self.view addSubview:tableView];
    _contactView = tableView;
    
    UISearchBar *search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, KeyWindow.bounds.size.width, 44)];
    _searchBar = search;
    _contactView.tableHeaderView = search;
}
-(void)cancelBtnAction
{
    [self.navigationController dismissViewControllerAnimated:self completion:nil];
}
- (void)setUpData
{
    [UserTool conatcts:^(NSArray *contacts) {
        NSIndexSet *set = [[NSIndexSet alloc]initWithIndexesInRange:NSMakeRange(0, contacts.count)];
        [self.users insertObjects:contacts atIndexes:set];
        NSLog(@"%@",self.users);
        [self adjustedData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (void)adjustedData
{
    [self.groupDitc setObject:[NSMutableArray new] forKey:@"*"];
    for (char charater = 'a'; charater <= 'z'; charater++) {
        NSMutableArray *arr = [NSMutableArray array];
        [self.groupDitc setObject:arr forKey:[NSString stringWithFormat:@"%c",charater]];
    }
    for (Users *user in self.users) {
        //用作判断开头是否为英文字母
        BOOL flag = NO;
        for (char charater = 'a'; charater <= 'z'; charater++) {
            char chinese = tolower(pinyinFirstLetter([user.name characterAtIndex:0]));
            
            char english = tolower([user.name characterAtIndex:0]);
            if (chinese == charater || english == charater) {
                NSMutableArray *arr = [self.groupDitc objectForKey:[NSString stringWithFormat:@"%c",charater]];
                [arr addObject:user];
                [self.groupDitc setObject:arr forKey:[NSString stringWithFormat:@"%c",charater]];
                flag = YES;
            }
        }
        if (flag == NO) {
            NSMutableArray *arr = [self.groupDitc objectForKey:@"*"];
            [arr addObject:user];
            [self.groupDitc setObject:arr forKey:@"*"];
        }
    }
    //移除空数组
    for (NSString *key in self.groupDitc.allKeys) {
        NSMutableArray *arr = [self.groupDitc objectForKey:key];
        if (arr.count == 0) {
            [self.groupDitc removeObjectForKey:key];
        }
    }
    NSLog(@"%@",self.groupDitc);
    self.allKeys = [self.groupDitc.allKeys sortedArrayUsingSelector:@selector(compare:)];
    NSLog(@"%@",self.allKeys);
    [self.contactView reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.allKeys.count) {
        NSMutableArray *arr = self.groupDitc[[self.allKeys objectAtIndex:section ]];
        return arr.count;
    }else {
        return 0;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.allKeys.count) {
        return self.allKeys.count;
    }else {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"contacts";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    Users *user = [[self.groupDitc objectForKey:self.allKeys[indexPath.section]] objectAtIndex:indexPath.row];
    [cell.imageView sd_setImageWithURL:user.profile_image_url placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    cell.textLabel.text = user.name;
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([self.allKeys[section] isEqualToString:@"*"]) {
        return @"最近联系人";
    }
    char c = toupper([self.allKeys[section] characterAtIndex:0]);
    return [NSString stringWithFormat:@"%c",c];
}
//设置索条
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *marr = [NSMutableArray array];
    for (NSString *str in self.allKeys) {
        char ch = toupper([str characterAtIndex:0]);
        [marr addObject:[NSString stringWithFormat:@"%c",ch]];
    }
    return marr;
}
@end
