//
//  ChatInteractionViewController.swift
//  viossvc
//
//  Created by abx’s mac on 2016/12/1.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class ChatInteractionViewController: BaseCustomPageListTableViewController {

    @IBOutlet weak var inputBar: InputBarView!
    @IBOutlet weak var inputBarHeight: NSLayoutConstraint!
    
    @IBOutlet weak var inputBarBottom: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "张晓君"
        
    }
    
    override func didRequest(pageIndex: Int) {
        let model = ChatMsgModel()
        model.content = "adad我我奥多姆拉丁名"
        
        let modelMe = ChatMsgModel()
        modelMe.content = "adladlmclcmlamlacnancla"
        modelMe.from_uid = CurrentUserHelper.shared.uid
        
        var array = [ChatMsgModel]()
        for i  in 0 ... 9 {
            let model = ChatMsgModel()
            model.content = "按揭款打底裤" + "\(arc4random() % 10)"  + " 圣诞节疯狂" + "\(i)" + (i % 3 > 1 ? "andadnl 案例及大量的 到家了的" : "莱文斯基")
            model.from_uid = arc4random() % 3 == 1 ? CurrentUserHelper.shared.uid : 123
            array.append(model)
            
        }
        
        
        
     didRequestComplete(array)
        
    }

  override  func isCalculateCellHeight() -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, cellIdentifierForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        let model = self.tableView(tableView, cellDataForRowAtIndexPath: indexPath) as! ChatMsgModel
        
        
        return  model.from_uid == CurrentUserHelper.shared.uid ? "ChatWithISayCell" : "ChatWithAnotherSayCell"
    }
    
    
  
}
