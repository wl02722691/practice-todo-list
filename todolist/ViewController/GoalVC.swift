//
//  GoalVC.swift
//  todolist
//
//  Created by 張書涵 on 2018/8/28.
//  Copyright © 2018年 AliceChang. All rights reserved.
//

import UIKit

class GoalVC: UIViewController {
    let buttonSelect = ButtonSelect.self
    var goalArray = ["eqweqe","eqweqwe","weqeq","weqweqe"]
    var text = ""
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false

        let notificationName = Notification.Name("dataUpdated")
        NotificationCenter.default.addObserver(self, selector: #selector(dataUpdated(noti:)), name: notificationName, object: nil)
        updateInfo()
    }
 
    func updateInfo(){
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
        let buttonSelect = ButtonSelect.add
        print(buttonSelect)
        
    }

}

extension GoalVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goalArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else {return UITableViewCell() }
        let index = goalArray[indexPath.row]
        
        cell.textLabel?.text = index
        
        return cell
    }
}

