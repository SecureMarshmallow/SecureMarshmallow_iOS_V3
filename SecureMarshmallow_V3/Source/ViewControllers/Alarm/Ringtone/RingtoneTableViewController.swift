import UIKit

class RingtoneTableViewController: UITableViewController {
    
    let viewModel = RingtoneTableViewModel()
    let currentClockIndex: Int
    
    init(index: Int) {
        self.currentClockIndex = index
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ringtoneCell")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel.ringtones.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ringtoneCell", for: indexPath)

        cell.textLabel?.text = viewModel.ringtones[indexPath.row]
        
        if (clocks[currentClockIndex].selectedRingtone[indexPath.row] == true) {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: false)
        
        print(clocks[currentClockIndex].selectedRingtone.count)

        for i in 0...clocks[currentClockIndex].selectedRingtone.count - 1 {
            print("i: \(i)")
            clocks[currentClockIndex].selectedRingtone[i] = false
            let myIndexPath = IndexPath(row: i, section: 0)
            let cell = tableView.cellForRow(at: myIndexPath)
            cell!.accessoryType = .none
        }
        
        clocks[currentClockIndex].selectedRingtone[indexPath.row] = true
        let cell = tableView.cellForRow(at: indexPath)
        cell!.accessoryType = .checkmark
        
        writeToFile(location: subUrl!)
    }
}
