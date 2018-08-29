# todo-list
# Delegates
# 兩個controller間的資料溝通： 用Delegates回傳CreatGoalVC的goalTextView.text值到GoalVC，並呈現在tableView上。


在CreatGoalVC寫一個protocol DataSentDelegate

``` 
protocol DataSentDelegate{
    func userDidEnterData(data:String)
}

``` 


在CreatGoalVC讓delegate:DataSentDelegate? = nil

``` 
class CreatGoalVC: UIViewController,UITextViewDelegate {
    var delegate:DataSentDelegate? = nil
    
``` 


在GoalVC的segue時，要把createGoalVC.delegate = self，讓createGoalVC.delegate知道GoalVC的存在記憶體，才能傳資料回來。
``` 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreatGoalVC"{
        if let createGoalVC = segue.destination as? CreatGoalVC{
            createGoalVC.editContentCreatGoalVC = editGoal
            createGoalVC.tag = tag
            createGoalVC.delegate = self
            }
        }
    }

``` 

讓GoalVC繼承DataSentDelegate的protocal，並且必須實作func userDidEnterData(data:String)的方法
``` 
class GoalVC: UIViewController,DataSentDelegate {

```

userDidEnterData(data:String)的方法，預設接到資料後將data放到goalArray裡，呈現到畫面上。
``` 
    func userDidEnterData(data: String) {
        if tag == nil{
            print(data)
            goalArray.append(data)
            tableView.reloadData()
        }else{
            goalArray[tag!] = data
            tableView.reloadData()
        }
     
    }
``` 
 
在CreatGoalVC的nextBtnWasPressed，讓delegate的userDidEnterData傳data到GoalVC的userDidEnterData。
``` 

  @IBAction func nextBtnWasPressed(_ sender: Any) {
        if delegate != nil{
            if goalTextView.text != nil {
                let data = goalTextView.text
                delegate?.userDidEnterData(data: data!)
                dismissDetail()
            }
        }
    }
    
``` 

參考：iOS Swift 3 Beginner Tutorial: Protocols & Delegates - Passing Data using the Delegate Method：https://goo.gl/iqVm1j
