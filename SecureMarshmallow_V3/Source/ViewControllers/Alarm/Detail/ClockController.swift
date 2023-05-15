//
//  ClockController.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/14.
//
import UIKit

class ClockController: UIViewController {
    
    private var currentIndex: Int?
    private let viewModel: ClockViewModel

    init(viewModel: ClockViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Views
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let element = clocks.first(where: {$0.id == viewModel.clock.id})
        let index = clocks.firstIndex(of: element!)
        self.currentIndex = index!
        title = clocks[index!].name
        
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .black
        setupCollectionView()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let clockIndex = clocks.firstIndex(where: {$0.id == viewModel.clock.id})
        let timer = String(clocks[clockIndex!].ringTime.hour!) + ":" + String(clocks[clockIndex!].ringTime.minute!)
        timePicker.date = dateFormatter.date(from: timer)!
    }

    private func setupCollectionView() {
        view.addSubview(containerView)

        containerView.addSubviews([
            timePicker,
            internDeleteButton,
            editNameButton,
            repeatDaysButton,
            calendarButton,
            ringtoneButton
        ])

        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            timePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 96),

            editNameButton.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: 48),
            editNameButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            editNameButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),

            repeatDaysButton.topAnchor.constraint(equalTo: editNameButton.bottomAnchor, constant: 16),
            repeatDaysButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            repeatDaysButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),

            calendarButton.topAnchor.constraint(equalTo: repeatDaysButton.bottomAnchor, constant: 16),
            calendarButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            calendarButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            ringtoneButton.topAnchor.constraint(equalTo: calendarButton.bottomAnchor, constant: 16),
            ringtoneButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            ringtoneButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),

            internDeleteButton.topAnchor.constraint(equalTo: ringtoneButton.bottomAnchor, constant: 48),
            internDeleteButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            internDeleteButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
    }

    // MARK: Buttons
    
    private let timePicker: UIDatePicker = {
       let time = UIDatePicker()
        time.datePickerMode = .time
        time.translatesAutoresizingMaskIntoConstraints = false
        time.addTarget(self, action: #selector(timePickerChanged(picker:)), for: .valueChanged)
        return time
    }()

    private let repeatDaysButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Repeat Days", for: .normal)
        btn.addTarget(self, action: #selector(loadRepeatDaysView(_:)), for: .touchUpInside)
        return btn
    }()

    private let internDeleteButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Delete Alarm", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        btn.addTarget(self, action: #selector(deleteAlertMessage(_:)), for: .touchUpInside)

        return btn
    }()

    private let editNameButton: UIButton = {
        let editName = UIButton(type: .system)
        editName.translatesAutoresizingMaskIntoConstraints = false
        editName.setTitle("Edit Title", for: .normal)
        editName.addTarget(self, action: #selector(alertTextField(_:)), for: .touchUpInside)
        return editName

    }()

    private let calendarButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Calendar View", for: .normal)
        btn.addTarget(self, action: #selector(calendarButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    private let ringtoneButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Ringtone", for: .normal)
        btn.addTarget(self, action: #selector(loadRingtoneView(_:)), for: .touchUpInside)
        return btn
    }()

    // MARK: Actions of buttons
    
    @objc func timePickerChanged(picker: UIDatePicker) {
        let clockIndex = clocks.firstIndex(where: {$0.id == viewModel.clock.id})
        clocks[clockIndex!].ringTime = Calendar.current.dateComponents([.hour, .minute], from: picker.date)
    }
    
    @objc func loadRepeatDaysView(_ sender: UIButton!) {
        let element = clocks.first(where: {$0.id == viewModel.clock.id})
        let index = clocks.firstIndex(of: element!)
        let tableViewController = RepeatTableViewController(index: index!)
        navigationController?.pushViewController(tableViewController, animated: true)
    }
    
    @objc func deleteAlertMessage(_ sender:UIButton!) {
        let alertController:UIAlertController = UIAlertController(title: "Delete", message: "Are you sure?", preferredStyle: UIAlertController.Style.alert)

        alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive, handler: { (action: UIAlertAction!) in
            self.choseToDelete()
            }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler:nil))
        present(alertController, animated: true, completion: nil)
    }

    
    @objc func loadRingtoneView(_ sender: UIButton!) {
        let element = clocks.first(where: {$0.id == viewModel.clock.id})
        let index = clocks.firstIndex(of: element!)
        let tableViewController = RingtoneTableViewController(index: index!)
        navigationController?.pushViewController(tableViewController, animated: true)
    }
    
    @objc func alertTextField(_ sender:UIButton!) {
        let alertController:UIAlertController = UIAlertController(title: "Edit Title", message: nil, preferredStyle: UIAlertController.Style.alert)

        alertController.addTextField { (textField) in
            textField.text = clocks[self.currentIndex!].name
        }
        let clockIndex = clocks.firstIndex(where: {$0.id == viewModel.clock.id})
        alertController.addAction(UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
            clocks[clockIndex!].name = alertController.textFields![0].text!
            self.editNameSave()
            }))

        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler:nil))
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func calendarButtonPressed() {
        let today = Date.init()
        let controller = CalendarPickerViewController(baseDate: today, selectedDateChanged: { [weak self] date in
            guard let self = self else { return }
            self.viewModel.today = date
        }, clockId: viewModel.clock.id)
        present(controller, animated: true, completion: nil)
    }
    
    // MARK: Functions
    
    func editNameSave() {
        let clockIndex = clocks.firstIndex(where: {$0.id == viewModel.clock.id})
            title = clocks[clockIndex!].name
            viewModel.collectionView.reloadData()
    }

    func choseToDelete() {
        deleteClock()
        viewModel.collectionView.reloadData()
        _ = navigationController?.popViewController(animated: true)
    }

    func deleteClock() {
        let element = clocks.first(where: {$0.id == viewModel.clock.id})
        let index = clocks.firstIndex(of: element!)
        clocks.remove(at: index!)
    }
}
