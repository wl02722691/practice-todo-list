//
//  CreatGoalVC.swift
//  todolist
//
//  Created by 張書涵 on 2018/8/28.
//  Copyright © 2018年 AliceChang. All rights reserved.
//

import UIKit

class CreatGoalVC: UIViewController,UITextViewDelegate {
    var editContentCreatGoalVC:String?
    var tag:Int = 0
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var nextBtn: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextBtn.bindToKeyboard()
        goalTextView.delegate = self
        
        if editContentCreatGoalVC != nil {
            goalTextView.text = editContentCreatGoalVC
            navigationController?.title = "edit"
        }else{
            navigationController?.title = "add"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if editContentCreatGoalVC != nil {
            goalTextView.text = editContentCreatGoalVC
            titleLbl.text = "edit"
            print(tag)
        }else{
            titleLbl.text = "add"
        }
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if goalTextView.text == "What is your goal?"{
            goalTextView.text = ""

        }else{
            return
        }
    }
    

    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        if editContentCreatGoalVC == nil{
            let notificationName = Notification.Name("dataUpdated")
            NotificationCenter.default.post(name: notificationName, object: nil, userInfo: ["goalText":goalTextView.text])
        }else{
            let notificationName = Notification.Name("editUpdated")
            NotificationCenter.default.post(name: notificationName, object: nil, userInfo: ["editText":goalTextView.text])
        }
        dismissDetail()
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
}
