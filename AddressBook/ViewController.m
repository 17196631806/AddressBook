//
//  ViewController.m
//  AddressBook
//
//  Created by YaSha_Tom on 2017/8/21.
//  Copyright © 2017年 YaSha-Tom. All rights reserved.
//

#import "ViewController.h"
#import "MyScrollView.h"
#import "DingDingHeader.h"
#import "MyTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic,strong) UITableView *table;
@property(strong,nonatomic)MyScrollView * mScrollView;//导航栏标题
@property(nonatomic,assign)BOOL isBack;



@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    __weak typeof(self) weakSelf = self;
    self.navigationController.interactivePopGestureRecognizer.delegate = weakSelf;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer{
    //判断是否为rootViewController
    if (self.navigationController && self.navigationController.viewControllers.count == 1) {
        return NO;
    }else{
        if ([DingDingHeader shareHelper].titleList.count > 1) {
            [[DingDingHeader shareHelper].titleList removeObjectAtIndex:[DingDingHeader shareHelper].titleList.count-1];
        }
        if ([DingDingHeader shareHelper].titleList.count == 1) {
            [[DingDingHeader shareHelper].titleList removeAllObjects];
        }
        return YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [leftButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backOnView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    if (self.isHomePage) {
        self.peopleArray = [NSMutableArray arrayWithCapacity:100];
        self.organizatinArray = [NSMutableArray arrayWithCapacity:100];
        [self getAddressBookData:@"OnePageData" isTop:YES getName:nil];
    }
    
    self.table = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table registerClass:[MyTableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:self.table];
    
     [[DingDingHeader shareHelper].titleList addObject:self.title];
   
    
}

- (UIScrollView *)mScrollView {
    if (!_mScrollView) {
        _mScrollView = [[MyScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
        _mScrollView.backgroundColor = [UIColor whiteColor];
        _mScrollView.delegate = self;
        
        _mScrollView.showsHorizontalScrollIndicator = NO;
        _mScrollView.showsVerticalScrollIndicator = NO;
        __weak typeof(self) weakSelf = self;
        [_mScrollView setBtnClick:^(NSString * title, NSInteger tag) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"back" object:nil];
            if (tag==0) {
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                [[DingDingHeader shareHelper].titleList removeAllObjects];
            }
            else{
                
                [[DingDingHeader shareHelper].titleList removeObjectsInRange:NSMakeRange(tag+1, [DingDingHeader shareHelper].titleList.count-tag-1)];
                [weakSelf.navigationController.viewControllers
                 enumerateObjectsUsingBlock:^(id obj, NSUInteger idx,
                                              BOOL *stop) {
                     if ([obj isKindOfClass:ViewController
                          .class]) {
                         
                         for (int i=0; i<[DingDingHeader shareHelper].titleList.count; i++) {
                             NSLog(@"--%@,%d------%@",[[DingDingHeader shareHelper].titleList objectAtIndex:i],i,title);
                             NSLog(@"=========%@",weakSelf.navigationController
                                   .viewControllers);
                             if ([title isEqualToString:[[DingDingHeader shareHelper].titleList objectAtIndex:i]]) {
                                 idx = i;
                                 [weakSelf.navigationController
                                  popToViewController:weakSelf.navigationController
                                  .viewControllers[idx-1]
                                  animated:YES];
                                 
                                 return ;
                                 
                             }
                         }
                     }
                 }];
                weakSelf.mScrollView.titleArr = [DingDingHeader shareHelper].titleList;
            }
        }];
        
    }
    return _mScrollView;
}
- (void)backOnView {
    if ([DingDingHeader shareHelper].titleList.count > 0) {
        [[DingDingHeader shareHelper].titleList removeObjectAtIndex:[DingDingHeader shareHelper].titleList.count-1];
    }
    if ([DingDingHeader shareHelper].titleList.count == 1) {
        [[DingDingHeader shareHelper].titleList removeAllObjects];
    }
    [self.navigationController popViewControllerAnimated:YES];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return self.peopleArray.count;
    }else{
        return self.organizatinArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 60;
    }else{
        return 48;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[MyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 1) {
        cell.nameLabel.text = self.peopleArray[indexPath.row];
        cell.imgView.image = [UIImage imageNamed:@"头像"];
    }else if (indexPath.section == 2) {
        cell.nameLabel.text = self.organizatinArray[indexPath.row];
        cell.imgView.image = [UIImage imageNamed:@"文件夹"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else {
        [cell.imgView removeFromSuperview];
        [cell.nameLabel removeFromSuperview];
        [cell.contentView addSubview:self.mScrollView];
        self.mScrollView.titleArr = [DingDingHeader shareHelper].titleList;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"好消息" message:@"你可以查看人员私密信息啦！" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"----------");
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }else if (indexPath.section == 2){
        NSLog(@"-----%@",self.organizatinArray[0]);
        if (indexPath.row == 0) {
            [self getAddressBookData:@"TwoPageData" isTop:NO getName:self.organizatinArray[indexPath.row]];
        }else if(indexPath.row == 1){
            [self getAddressBookData:@"ThreePageData" isTop:NO getName:self.organizatinArray[indexPath.row]];
        }
    }
}

- (void)getAddressBookData:(NSString *)str isTop:(BOOL )top getName:(NSString *)name {
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:str ofType:@"plist"];
    
    if (top) {
        self.allDataArray = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
        for (NSDictionary *dic in self.allDataArray){
            NSLog(@"---------%@",dic[@"type"]);
            if ([dic[@"type"] isEqual:@1]) {
                [self.organizatinArray addObject:dic[@"name"]];
            }else{
                [self.peopleArray addObject:dic[@"name"]];
            }
        }
    }else {
        ViewController *vc = [[ViewController alloc]init];
        vc.allDataArray = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
        NSLog(@"======%@",vc.allDataArray);
        vc.title = name;
        vc.isHomePage = NO;
        vc.peopleArray = [NSMutableArray arrayWithCapacity:100];
        vc.organizatinArray = [NSMutableArray arrayWithCapacity:100];
        for (NSDictionary *dic in vc.allDataArray){
            NSLog(@"---------%@",dic[@"type"]);
            if ([dic[@"type"] isEqual:@1]) {
                [vc.organizatinArray addObject:dic[@"name"]];
            }else{
                [vc.peopleArray addObject:dic[@"name"]];
            }
        }
        NSLog(@"------%@",vc.peopleArray);
        [self.navigationController pushViewController:vc animated:YES];    
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
