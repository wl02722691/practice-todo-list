//
//  CreatGoalVC.swift
//  todolist
//
//  Created by 張書涵 on 2018/8/28.
//  Copyright © 2018年 AliceChang. All rights reserved.
//

import UIKit

protocol DataSentDelegate{
    func userDidEnterData(data:String)
}

class CreatGoalVC: UIViewController,UITextViewDelegate {
    var observation: NSKeyValueObservation?
    @objc dynamic var viewModel: ViewModel?
    
    var editContentCreatGoalVC:String?
    var tag:Int?
    var delegate:DataSentDelegate? = nil
    
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var nextBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.bindToKeyboard()
        goalTextView.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if tag == nil {
            titleLbl.text = "add"
        }else{
            goalTextView.text = editContentCreatGoalVC
            titleLbl.text = "edit"
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
            if goalTextView.text != nil {
                viewModel?.value1 = goalTextView.text
                let data = goalTextView.text
                delegate?.userDidEnterData(data: data!)
                dismissDetail()
        }
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
}
