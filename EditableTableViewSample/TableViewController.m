//
//  TableViewController.m
//  EditableTableViewSample
//
//  Created on 2015/03/30.
//
//

#import "TableViewController.h"
#import "TableViewCell.h"

/**
 *  テーブルビューコントローラです。
 */
@interface TableViewController () <UITextFieldDelegate>

@property NSArray *sectionList;
@property NSMutableArray *list;

- (IBAction)tapAddButton:(id)sender;

@end

@implementation TableViewController

@synthesize sectionList;
@synthesize list;

const NSString *TABLEVIEWCELL_ID = @"TableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // カスタムセルをテーブルビューに登録します。
    UINib *nibTableViewCell = [UINib nibWithNibName:TABLEVIEWCELL_ID
                                             bundle:nil];
    [self.tableView registerNib:nibTableViewCell
         forCellReuseIdentifier:TABLEVIEWCELL_ID];
    
    // セクション情報を初期化します。
    sectionList = [[NSArray alloc] initWithObjects:@"Item List", nil];
    
    // テーブルビューのアイテムリストを初期化します。
    list = [[NSMutableArray alloc] initWithObjects:@"test",
            @"test1",
            @"test2",
            nil];
    
    // テーブルビューの編集フラグの初期値を設定します。
    [self.tableView setEditing:YES animated:NO];
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
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TABLEVIEWCELL_ID];
    if (cell == nil) {
        cell = [[TableViewCell alloc] init];
    }
    cell.txtItem.text = list[indexPath.row];
    cell.txtItem.delegate = self;
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
    // リストに新規項目を追加します。
    [list addObject:@""];
    // テーブルビューにセルを追加します
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    // 新規追加の入力項目にフォーカスをセットします。
    TableViewCell *newCell = (TableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    [newCell.txtItem becomeFirstResponder];
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
 *  キーボードのリターンキーをタップした時の処理です。
 *
 *  @param textField テキストフィールドです。
 *
 *  @return ブール値。
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // フォーカスを外します。
    [textField resignFirstResponder];
    
    return YES;
}

@end
