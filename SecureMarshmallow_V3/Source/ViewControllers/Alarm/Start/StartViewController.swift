//
//  StartViewController.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/14.
//

import UIKit
import SnapKit
import Then

class StartController: UIViewController {
    
    // MARK: Views
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private let viewModel = StartViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cells.removeAll()

        setupCollectionView()

        navigationController?.navigationBar.prefersLargeTitles = true
        title = "알람"
        view.backgroundColor = .white
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        let btnAdd = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = btnAdd
    }
    
    private func setupCollectionView() {
        collectionView.register(ClockCell.self, forCellWithReuseIdentifier: "ClockCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .BackGray
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 16, bottom: 0, right: 16)

        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: Button actions

    @objc func addTapped(_ sender:UIViewController!) {
        addClock()
        collectionView.reloadData()
    }
    
    // MARK: Functions
    
    private func addClock() {
        let newID = UUID.init()
        clocks.append(Clock(id: newID, name: "New Alarm", daysOfWeek: [0], ringDays: [], isActivated: true, ringTime: Calendar.current.dateComponents([.hour, .minute], from: Date.init()), notificationId: UUID().uuidString, selectedDays: [true, true, true, true, true, true, true], selectedRingtone: [true, false]))
        let element = clocks.first(where: {$0.id == newID})
        let index = clocks.firstIndex(of: element!)
        let currentClockIndex = index!
        setRingDays(currentClockIndex:currentClockIndex)
        writeToFile(location: subUrl!)
    }
}

// MARK: Collection view start controller

extension StartController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClockCell", for: indexPath) as? ClockCell else {
            return UICollectionViewCell()
        }
        let clock = clocks[indexPath.item]
        cell.configureWith(clock)
        cell.switchValueChanged = { switchValue in
            clocks[indexPath.item].isActivated = switchValue
            writeToFile(location: subUrl!)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clocks.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let clock = viewModel.itemAt(indexPath.item) else {
            return
        }
        
        let controller = ClockController(viewModel: ClockViewModel(clock: clock, collectionView: collectionView))
 
        navigationController?.pushViewController(controller, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 32, height: 80)
    }
}
