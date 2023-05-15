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
        view.backgroundColor = .BackGray
        setupCollectionView()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let clockIndex = clocks.firstIndex(where: {$0.id == viewModel.clock.id})
        let timer = String(clocks[clockIndex!].ringTime.hour!) + ":" + String(clocks[clockIndex!].ringTime.minute!)
        timePicker.date = dateFormatter.date(from: timer)!
        
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
                
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(dismissTap))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(dismissTap))
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

        let buttonSize = CGSize(width: 360, height: 60)

        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            timePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 96),

            editNameButton.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: 48),
            editNameButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            editNameButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            editNameButton.widthAnchor.constraint(equalToConstant: buttonSize.width),
            editNameButton.heightAnchor.constraint(equalToConstant: buttonSize.height),

            repeatDaysButton.topAnchor.constraint(equalTo: editNameButton.bottomAnchor, constant: 20),
            repeatDaysButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            repeatDaysButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            repeatDaysButton.widthAnchor.constraint(equalToConstant: buttonSize.width),
            repeatDaysButton.heightAnchor.constraint(equalToConstant: buttonSize.height),

            calendarButton.topAnchor.constraint(equalTo: repeatDaysButton.bottomAnchor, constant: 20),
            calendarButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            calendarButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            calendarButton.widthAnchor.constraint(equalToConstant: buttonSize.width),
            calendarButton.heightAnchor.constraint(equalToConstant: buttonSize.height),

            ringtoneButton.topAnchor.constraint(equalTo: calendarButton.bottomAnchor, constant: 20),
            ringtoneButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            ringtoneButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            ringtoneButton.widthAnchor.constraint(equalToConstant: buttonSize.width),
            ringtoneButton.heightAnchor.constraint(equalToConstant: buttonSize.height),

            internDeleteButton.topAnchor.constraint(equalTo: ringtoneButton.bottomAnchor, constant: 48),
            internDeleteButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            internDeleteButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            internDeleteButton.widthAnchor.constraint(equalToConstant: buttonSize.width),
            internDeleteButton.heightAnchor.constraint(equalToConstant: buttonSize.height)
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
    
    private let editNameButton: EditButton = {
        let editName = EditButton(title: "레이블")
        editName.translatesAutoresizingMaskIntoConstraints = false
        editName.addTarget(self, action: #selector(alertTextField(_:)), for: .touchUpInside)
        return editName

    }()
    
    private let repeatDaysButton: EditButton = {
        let btn = EditButton(title: "반복")
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(loadRepeatDaysView(_:)), for: .touchUpInside)
        return btn
    }()

    private let internDeleteButton: EditButton = {
        let btn = EditButton(title: "알람 삭제")
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(deleteAlertMessage(_:)), for: .touchUpInside)

        return btn
    }()
    
    private let calendarButton: EditButton = {
        let btn = EditButton(title: "달력")
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Calendar View", for: .normal)
        btn.addTarget(self, action: #selector(calendarButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    private let ringtoneButton: EditButton = {
        let btn = EditButton(title: "알람 소리")
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(loadRingtoneView(_:)), for: .touchUpInside)
        return btn
    }()

    // MARK: Actions of buttons
    
    @objc func timePickerChanged(picker: UIDatePicker) {
        let clockIndex = clocks.firstIndex(where: { $0.id == viewModel.clock.id })
        clocks[clockIndex!].ringTime = Calendar.current.dateComponents([.hour, .minute], from: picker.date)
    }
    
    @objc func loadRepeatDaysView(_ sender: UIButton!) {
        let element = clocks.first(where: {$0.id == viewModel.clock.id})
        let index = clocks.firstIndex(of: element!)
        let tableViewController = RepeatTableViewController(index: index!)
        navigationController?.pushViewController(tableViewController, animated: true)
    }
    
    @objc func deleteAlertMessage(_ sender: UIButton!) {
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
    
    @objc func alertTextField(_ sender: UIButton!) {
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
    
    @objc func dismissTap() {
        self.dismiss(animated: true)
    }
}
