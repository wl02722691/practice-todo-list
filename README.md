# todo-list
# Notification
# 兩個controller間的資料溝通： 用Notification回傳CreatGoalVC的goalTextView.text值到GoalVC，並呈現在tableView上。


在CreatGoalVC的nextBtnWasPressed中判斷editContentCreatGoalVC是否有從GoalVC傳過來的text來當作判斷add與edit的依據，在這裡post Notification，userInfo就放想傳回GoalVC的goalTextView.text。

``` 
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        if editContentCreatGoalVC == nil{
            let notificationName = Notification.Name("addUpdated")
            NotificationCenter.default.post(name: notificationName, object: nil, userInfo: ["goalText":goalTextView.text])
        }else{
            let notificationName = Notification.Name("editUpdated")
            NotificationCenter.default.post(name: notificationName, object: nil, userInfo: ["editText":goalTextView.text])
        }
        dismissDetail()
    }
``` 

在GoalVC中寫接到資料後的function，接到資料後呼叫selector做準備。

``` 
    func updateInfo(){
        tableView.reloadData()
    }

    @objc func editUpdated(noti:Notification) {
      let text = noti.userInfo!["editText"] as! String
        goalArray[tag] = text
        updateInfo()
    }
    
    
    
    @objc func dataUpdated(noti:Notification) {
        text = noti.userInfo!["addText"] as! String
        goalArray.append(text)
        updateInfo()
    }
    
``` 


在GoalVC的viewDidLoad放入接收NotificationCenter的方法，selector就連結到上面的editUpdated跟dataUpdated的function。
``` 
   override func viewDidLoad() {
          let editUpdatednotificationName = Notification.Name("editUpdated")
        NotificationCenter.default.addObserver(self, selector: #selector(editUpdated(noti:)), name: editUpdatednotificationName, object: nil)
        
        let notificationName = Notification.Name("addUpdated")
        NotificationCenter.default.addObserver(self, selector: #selector(dataUpdated(noti:)), name: notificationName, object: nil)

``` 

參考：多頁面app間的資料傳遞：https://goo.gl/BNurUC
