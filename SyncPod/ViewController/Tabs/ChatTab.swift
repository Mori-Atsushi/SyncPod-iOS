//
//  ChatTab.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/27.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ChatTab: UIViewController, IndicatorInfoProvider, ChatListDelegate, UITableViewDataSource, UITableViewDelegate {
    var itemInfo: IndicatorInfo = "チャット"
    let chatList = DataStore.CurrentRoom.chatList
    let center = NotificationCenter.default
    var isShowKeyboard = false
    var keyboardFrame: CGRect?
    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var MainView: UIStackView!
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var chatButton: UIButton!
    
    @IBAction func postChat(_ sender: UIButton) {
        let message = messageField.text!
        if message != "" {
            DataStore.roomChannel?.sendChat(message)
            messageField.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatList.delegate = self
        TableView.transform = CGAffineTransform(rotationAngle: -(CGFloat)(Double.pi))
        MainView.translatesAutoresizingMaskIntoConstraints = true
        chatButton.layer.cornerRadius = DeviceConst.buttonCornerRadius
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let innerOffset: CGFloat = 9.0
        TableView.scrollIndicatorInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: TableView.frame.width - innerOffset)
        
        checkViewSize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        center.addObserver(
            self,
            selector: #selector(ChatTab.showKeyboard(notification:)),
            name: .UIKeyboardWillShow,
            object: nil)
        center.addObserver(
            self,
            selector: #selector(ChatTab.hideKeyboard(notification:)),
            name: .UIKeyboardWillHide,
            object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        isShowKeyboard = false
        center.removeObserver(self)
    }
    
    @objc func showKeyboard(notification: Notification) {
        isShowKeyboard = true
        let info = notification.userInfo!
        self.keyboardFrame = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        checkViewSize()
    }
    
    @objc func hideKeyboard(notification: Notification) {
        isShowKeyboard = false
        checkViewSize()
    }
    
    func checkViewSize() {
        let width = MainView.superview!.frame.width
        let height = isShowKeyboard ? MainView.superview!.frame.height - (keyboardFrame?.height ?? 0):
            MainView.superview!.frame.height
        
        MainView.frame = CGRect(x: 0,
            y: 0,
            width: width,
            height: height)
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    func updatedChatList() {
        print("chat updated")
        self.TableView.reloadData()
    }
    
    //データを返すメソッド（スクロールなどでページを更新する必要が出るたびに呼び出される）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Chat", for: indexPath as IndexPath) as! ChatTableViewCell
        cell.setCell(chat: chatList.get(index: chatList.count - indexPath.row - 1))
        cell.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi));
        return cell
    }
    
    //データの個数を返すメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList.count
    }
}

