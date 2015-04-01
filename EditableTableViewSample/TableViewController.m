//
//  TableViewController.m
//  EditableTableViewSample
//
//  Created on 2015/03/30.
//
//

#import "TableViewController.h"

@interface TableViewController ()

@property NSArray *sectionList;
@property NSMutableArray *list;
@property BOOL editFlag;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (weak, nonatomic) IBOutlet UITextField *addTextField;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

- (IBAction)tapEdit:(id)sender;
- (IBAction)tapAddButton:(id)sender;

@end

@implementation TableViewController

@synthesize sectionList;
@synthesize list;
@synthesize editFlag;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // セクション情報を初期化します。
    sectionList = [[NSArray alloc] initWithObjects:@"UUID List", nil];
    
    // テーブルビューの編集フラグの初期値を設定します。
    editFlag = NO;
    
    // 追加コンポーネントの利用可能を設定します。
    [self setAddComponentEnable:editFlag];
    
    //list = [[NSMutableArray alloc] init];
    // テーブルビューのアイテムリストを初期化します。
    list = [[NSMutableArray alloc] initWithObjects:@"test",
            @"test1",
            @"test2",
            nil];
}

/**
 *  (オーバーライドです。)
 *
 *  @param tableView テーブルビューです。
 *
 *  @return セクション数。
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return sectionList.count;
}

/**
 *  (オーバーライドです。)
 *
 *  @param tableView テーブルビューです。
 *  @param section   セクションです。
 *
 *  @return セクションのヘッダタイトル。
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return sectionList[section];
}

/**
 *  (オーバーライドです。)
 *
 *  @param tableView テーブルビューです。
 *  @param section   セクションです。
 *
 *  @return セクション内のセル数です。
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return list.count;
}

/**
 *  (オーバーライドです。)
 *
 *  @param tableView テーブルビューです。
 *  @param indexPath インデックスパスです。
 *
 *  @return セル。
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    cell.textLabel.text = list[indexPath.row];
    
    return cell;
}

/**
 *  追加ボタンタップ時の処理です。
 *
 *  @param sender センダーです。
 */
- (IBAction)tapAddButton:(id)sender
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:list.count inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObjects:indexPath, nil];
    [list addObject:self.addTextField.text];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
}

/**
 *  編集ボタンタップ時の処理です。
 *
 *  @param sender センダーです。
 */
- (IBAction)tapEdit:(id)sender
{
    editFlag = !editFlag;
    [self.tableView setEditing:editFlag animated:YES];
    if (editFlag) {
        self.editButton.title = @"done";
    } else {
        self.editButton.title = @"edit";
    }
    // 追加コンポーネントの利用可能を設定します。
    [self setAddComponentEnable:editFlag];
}

/**
 *  (オーバーライドです。)
 *
 *  @param tableView    テーブルビューです。
 *  @param editingStyle 編集スタイルです。
 *  @param indexPath    インデックスパスです。
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 削除時の処理です。
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // アイテムリストを更新します。
        [list removeObjectAtIndex:indexPath.row];
        // テーブルビューを更新します。
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

/**
 *  追加コンポーネントの利用可能を設定をします。
 *
 *  @param enableFlag 利用可能フラグです。
 */
- (void)setAddComponentEnable:(BOOL)enableFlag
{
    self.addButton.enabled = enableFlag;
    self.addTextField.enabled = enableFlag;
}

@end
