//
//  CreatGoalVC.swift
//  todolist
//
//  Created by 張書涵 on 2018/8/28.
//  Copyright © 2018年 AliceChang. All rights reserved.
//
import UIKit

class CreatGoalVC: UIViewController,UITextViewDelegate {
    var contextFromGoalVC:String?
    var tag:Int?
    
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
            goalTextView.text = contextFromGoalVC
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
    
    //closure傳資料
    func getData() -> (String){
        let post: String = goalTextView.text
        return post
    }
    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        if goalTextView.text != nil {
            if let controller = presentingViewController as? GoalVC{
                dismiss(animated: true) {
                    controller.dataEntered(self.getData())
                }
            }
        }
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
}
