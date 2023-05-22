//
//  MainBluetoothViewController.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/22.
//
import UIKit
import CoreBluetooth
import SnapKit

class MainBluetoothViewController: UIViewController {
    
    private var bluetoothViewController: BluetoothViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBluetoothViewController()
    }
    
    private func setupBluetoothViewController() {
        bluetoothViewController = BluetoothViewController()
        addChild(bluetoothViewController)
        view.addSubview(bluetoothViewController.view)
        
        bluetoothViewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bluetoothViewController.didMove(toParent: self)
    }
}
