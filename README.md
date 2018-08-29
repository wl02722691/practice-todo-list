# todo-list
# Key-Value Observing
# 兩個controller間的資料溝通： 用Key-Value Observing回傳CreatGoalVC的goalTextView.text值到GoalVC，並呈現在tableView上。





因為KVO只能監控NSObject的關係。所以建立一個ViewModel.swift檔案放一個value1，之後改變這個value1時會用KVO去監控。

``` 
class ViewModel : NSObject{
    @objc dynamic var value1: String = ""
}

``` 


在GoalVC設定變數observation: NSKeyValueObservation與viewModel

``` 
class GoalVC: UIViewController {
    var observation: NSKeyValueObservation?
    @objc dynamic var viewModel: ViewModel = ViewModel()
    
    }

``` 

在GoalVC的viewDidLoad中註冊observation，observation被觸發後用debugPrint印出改變的值後，判斷資料與呈現。

``` 
override func viewDidLoad() {
        super.viewDidLoad()
        observation = observe(\.viewModel.value1, options:[.old, .new]) { (object, change) in
            debugPrint("old \(change.oldValue)")
            debugPrint("new \(change.newValue)")
            debugPrint(object.viewModel.value1)
            
            if self.tag == nil {
                self.goalArray.append(object.viewModel.value1)
                self.tableView.reloadData()
            }else{
                self.goalArray[self.tag!] = object.viewModel.value1
                self.tableView.reloadData()
                }
            }
        }

``` 

在prepare時，讓GoalVC的viewModel與CreatGoalVC的viewModel同步，不然即使CreatGoalVC的viewModel觸發，GoalVC中的observe也不會反應。

``` 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreatGoalVC"{
        if let createGoalVC = segue.destination as? CreatGoalVC{
            createGoalVC.editContentCreatGoalVC = editGoal
            createGoalVC.tag = tag
            createGoalVC.viewModel = viewModel
       
            }
        }
    }

```

GoalVC的viewModel與CreatGoalVC的viewModel的建立方法
``` 
class GoalVC: UIViewController {
    @objc dynamic var viewModel: ViewModel = ViewModel()
    //創建一個新的
class CreatGoalVC: UIViewController,UITextViewDelegate {
    @objc dynamic var viewModel: ViewModel?
    //只有格式沒有值

``` 
 
在CreatGoalVC中的nextBtnWasPressed（從CreatGoalVC到GoalVC的button），改變viewModel?.value1的值為goalTextView.text，就會觸發GoalVC的viewDidLoad中的observation。
``` 

    @IBAction func nextBtnWasPressed(_ sender: Any) {
            if goalTextView.text != nil {
                viewModel?.value1 = goalTextView.text
                let data = goalTextView.text
                delegate?.userDidEnterData(data: data!)
                dismissDetail()
                
        }
    }
    
``` 

參考：【iOS】Key-Value Observing：https://goo.gl/VigY69
