# Notification
# 兩個 controller 間的資料溝通： 用 Notification 回傳 CreatGoalVC的goalTextView.text 值到 GoalVC ，並呈現在 tableView 上。


在 CreatGoalVC 的 nextBtnWasPressed 中判斷 editContentCreatGoalVC 是否有從 GoalVC 傳過來的 text 來當作判斷 add 與 edit 的依據，在這裡 post Notification ， userInfo 就放想傳回 GoalVC 的 goalTextView.text 。

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

在 GoalVC 中寫接到資料後的 function ，接到資料後呼叫 selector 做準備。

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


在 GoalVC 的 viewDidLoad 放入接收 NotificationCenter 的方法， selector 就連結到上面的 editUpdated 跟 dataUpdated 的 function 。
``` 
   override func viewDidLoad() {
        let editUpdatednotificationName = Notification.Name("editUpdated")
        NotificationCenter.default.addObserver(self, selector: #selector(editUpdated(noti:)), name: editUpdatednotificationName, object: nil)
        
        let notificationName = Notification.Name("addUpdated")
        NotificationCenter.default.addObserver(self, selector: #selector(dataUpdated(noti:)), name: notificationName, object: nil)

``` 
>Delegate實作方法

>1.先去宣告 protocol ，把想實作的能力寫在protocol裡面

>2.有一個變數型別是 protocol type

>3.想溝通的物件要 conform protocol 

>4.要在目標頁面實作 protocal 的能力

>5.並將 delegate 指向目標頁


參考：多頁面 app 間的資料傳遞：https://goo.gl/BNurUC
