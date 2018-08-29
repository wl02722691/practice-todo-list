# todo-list
# Closure
# 兩個controller間的資料溝通： 用closure回傳CreatGoalVC的goalTextView.text值到GoalVC，並呈現在tableView上。

先在GoalVC寫了一個function，等待回傳值。

``` 
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
``` 
 
到CreatGoalVC寫一個getData()的function，定義回傳的內容是post是goalTextView.text。
``` 
    func getData() -> (String){
        let post: String = goalTextView.text
        return post
    }
``` 

在dismiss的時候在completion將getData()傳到GoalVC第一頁的controller.dataEntered
``` 
      @IBAction func nextBtnWasPressed(_ sender: Any) {
        if goalTextView.text != nil {
            if let controller = presentingViewController as? GoalVC{
                dismiss(animated: true) {
                    controller.dataEntered(self.getData())
                }
            }
        }
    }
    
```
參考：Closures in iOS to pass data :Swift Sidebars xCode：https://goo.gl/iccGo4

