//
//  GoalVC.swift
//  todolist
//
//  Created by 張書涵 on 2018/8/28.
//  Copyright © 2018年 AliceChang. All rights reserved.
//

import UIKit

class GoalVC: UIViewController {
    
    var goalArray = ["Alice","Nia","Crystal","Ling"]
    var editGoal = ""
    var tag:Int?
    var post = ""
    
    func dataEntered(_ post:String) {
        self.post = post
        if self.tag == nil {
            self.goalArray.append(post)
            self.tableView.reloadData()
        }else{
            self.goalArray[self.tag!] = post
            self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
        
    }
    
    @IBAction func addGoalBtnWasPressed(_ sender: UIButton) {
        tag = nil
    }
    
    @objc func editBtn(sender: UIButton) {
        editGoal = goalArray[sender.tag]
        tag = sender.tag
        print(sender.tag)
        print(editGoal)
        performSegue(withIdentifier: "CreatGoalVC", sender: sender)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreatGoalVC" {
            if let createGoalVC = segue.destination as? CreatGoalVC {
                createGoalVC.contextFromGoalVC = editGoal
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
        tableView.reloadData()
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
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else {return UITableViewCell() }
        let index = goalArray[indexPath.row]
        cell.editBtn.tag = indexPath.row
        cell.editBtn.addTarget(self, action: #selector(GoalVC.editBtn(sender:)), for: .touchUpInside)
        cell.textLabel?.text = index
        
        return cell
    }
}

