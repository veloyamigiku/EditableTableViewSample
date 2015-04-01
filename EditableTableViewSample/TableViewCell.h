//
//  TableViewCell.h
//  EditableTableViewSample
//
//  Created on 2015/04/01.
//
//

#import <UIKit/UIKit.h>

/**
 *  テーブルビューのカスタムセルです。
 */
@interface TableViewCell : UITableViewCell

/**
 *  入力項目です。
 */
@property (weak, nonatomic) IBOutlet UITextField *txtItem;

@end
