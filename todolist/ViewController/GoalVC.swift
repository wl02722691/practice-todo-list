//
//  GoalVC.swift
//  todolist
//
//  Created by 張書涵 on 2018/8/28.
//  Copyright © 2018年 AliceChang. All rights reserved.
//

import UIKit

class GoalVC: UIViewController {
    var editContentGoalVC = ""
    let buttonSelect = ButtonSelect.self
    var goalArray = ["eqweqe","eqweqwe","weqeq","weqweqe"]
    var text = ""
    var editGoal = ""
    var tag = 0
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false

        let editUpdatednotificationName = Notification.Name("editUpdated")
        NotificationCenter.default.addObserver(self, selector: #selector(editUpdated(noti:)), name: editUpdatednotificationName, object: nil)
        
        let notificationName = Notification.Name("dataUpdated")
        NotificationCenter.default.addObserver(self, selector: #selector(dataUpdated(noti:)), name: notificationName, object: nil)
        updateInfo()
    }
 
    func updateInfo(){
        tableView.reloadData()
    }
    
    @objc func editUpdated(noti:Notification) {
      let text = noti.userInfo!["editText"] as! String
        goalArray[tag] = text
        tableView.reloadData()
    }
    
    
    
    @objc func dataUpdated(noti:Notification) {
        text = noti.userInfo!["goalText"] as! String
        goalArray.append(text)
        updateInfo()
    }
    
    @IBAction func addGoalBtnWasPressed(_ sender: UIButton) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreatGoalVC") else {return}
        presentDetail(createGoalVC)
        print(buttonSelect)
        
        reloadInputViews()
    }
    
    @objc func editBtn(sender: UIButton){
        editGoal = goalArray[sender.tag]
        tag = sender.tag
        print(sender.tag)
        print(editGoal)
        performSegue(withIdentifier: "CreatGoalVC", sender: sender)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreatGoalVC"{
        if let createGoalVC = segue.destination as? CreatGoalVC{
            createGoalVC.editContentCreatGoalVC = editGoal
            createGoalVC.tag = tag
            }
        }
    }
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath)
    {
        let select:Int = indexPath.row
        goalArray.remove(at: select)
        tableView.reloadData() // 更新tableView
    }
    
    func tableView(_ tableView: UITableView,
                   titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath)
        -> String?
    {
        return "delete"
    }
}




extension GoalVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goalArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else {return UITableViewCell() }
        let index = goalArray[indexPath.row]
        cell.editBtn.tag = indexPath.row
        cell.editBtn.addTarget(self, action: #selector(GoalVC.editBtn(sender:)), for: .touchUpInside)
        cell.textLabel?.text = index
        
        return cell
    }
    

}

