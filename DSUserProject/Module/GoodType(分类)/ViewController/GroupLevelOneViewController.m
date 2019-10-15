//
//  GroupLevelOneViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2019/1/3.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "GroupLevelOneViewController.h"
#import "GroupCell.h"

@interface GroupLevelOneViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableData;
@property (nonatomic, strong) GroupModel *selectGroup;
@end

@implementation GroupLevelOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initControl{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
    self.tableView.rowHeight = 50;
}

-(void)initData{
    [self requestLevelOneList];
    
    /*
    self.tableData = [[NSMutableArray alloc] init];
    GroupModel *model = [[GroupModel alloc] init];
    model.isSelect = NO;
    model.groupName = @"翡翠";
    [self.tableData addObject:model];
    GroupModel *model1 = [[GroupModel alloc] init];
    model1.isSelect = NO;
    model1.groupName = @"和田玉";
    [self.tableData addObject:model1];
    self.selectGroup = model;
     */
}

-(void)setSelectGroup:(GroupModel *)selectGroup{
    if(self.selectGroup){
        self.selectGroup.isSelect = NO;
    }
    _selectGroup = selectGroup;
    self.selectGroup.isSelect = YES;
    if(self.changeGroupBlock){
        self.changeGroupBlock(self.selectGroup.groupId);
    }
}

#pragma mark - UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupCell"];
    cell.cellData = self.tableData[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GroupModel *model = self.tableData[indexPath.row];
    self.selectGroup = model;
    [self.tableView reloadData];
}


#pragma mark - 网络
-(void)requestLevelOneList{
    //一级分类
    [[JMRequestManager sharedManager] POST:kUrlTypeLevelOne parameters:nil completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            NSArray *dataArray = response.responseObject[@"data"];
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for(NSDictionary *dic in dataArray){
                GroupModel *group = [[GroupModel alloc] initWithDictionary:dic];
                [array addObject:group];
            }
            self.tableData = array;
            self.selectGroup = self.tableData.firstObject;
            [self.tableView reloadData];
        }
    }];
}
@end
