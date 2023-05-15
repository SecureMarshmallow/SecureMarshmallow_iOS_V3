import UIKit

class RepeatTableViewController: UITableViewController {

    let viewModel = RepeatTableViewModel()
    let currentClockIndex: Int
    let backupSelectedDays: [Bool]

    init(index: Int) {

        self.currentClockIndex = index
        self.backupSelectedDays = clocks[currentClockIndex].selectedDays
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.backAction(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "dayCell")
    }

    @objc func backAction(sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Are You Sure?", message: "If You Proceed, The Calendar data will be overriden", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { (result : UIAlertAction) -> Void in
            clocks[self.currentClockIndex].ringDays = []
            setRingDays(currentClockIndex:self.currentClockIndex)
            writeToFile(location: subUrl!)
            self.navigationController?.popViewController(animated: true)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (result : UIAlertAction) -> Void in
            clocks[self.currentClockIndex].selectedDays = self.backupSelectedDays
            self.navigationController?.popViewController(animated: true)
        }

        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        if (clocks[self.currentClockIndex].selectedDays != self.backupSelectedDays) {
            self.present(alertController, animated: true)
        }
        else {
            self.navigationController?.popViewController(animated: true)
        }
        removeClocksInPast()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel.repeatDays.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath)

        cell.textLabel?.text = viewModel.repeatDays[indexPath.row]
        if (clocks[currentClockIndex].selectedDays[indexPath.row] == true) {
            cell.accessoryType = .checkmark
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: false)

        if(clocks[currentClockIndex].selectedDays[indexPath.row] == true) {
            let cell = tableView.cellForRow(at: indexPath)
            cell!.accessoryType = .none
            clocks[currentClockIndex].selectedDays[indexPath.row] = false
        }

        else if (clocks[currentClockIndex].selectedDays[indexPath.row] == false) {
            let cell = tableView.cellForRow(at: indexPath)
            cell!.accessoryType = .checkmark
            clocks[currentClockIndex].selectedDays[indexPath.row] = true
        }
    }
}
