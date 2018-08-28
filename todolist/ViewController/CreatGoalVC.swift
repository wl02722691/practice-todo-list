//
//  CreatGoalVC.swift
//  todolist
//
//  Created by 張書涵 on 2018/8/28.
//  Copyright © 2018年 AliceChang. All rights reserved.
//

import UIKit

class CreatGoalVC: UIViewController,UITextViewDelegate {


    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var nextBtn: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.bindToKeyboard()
        goalTextView.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalTextView.text = ""
    }
    

    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        let notificationName = Notification.Name("dataUpdated")
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: ["goalText":goalTextView.text])
        dismissDetail()
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
}
