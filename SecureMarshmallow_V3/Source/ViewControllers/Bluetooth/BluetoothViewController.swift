import UIKit
import CoreBluetooth
import SnapKit

//코드 사용하지 않음
class BluetoothViewController: UIViewController, CBCentralManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    private var centralManager: CBCentralManager!
    private var peripherals: [CBPeripheral] = []
    private var tableView: UITableView!
    private var statusLabel: UILabel!
    private var connectButton: UIButton!
    private var disconnectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BluetoothCell")
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.snp.centerY)
        }
        
        statusLabel = UILabel()
        statusLabel.text = "Bluetooth Status: Unknown"
        statusLabel.textAlignment = .center
        view.addSubview(statusLabel)
        
        statusLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tableView.snp.bottom).offset(20)
        }
        
        connectButton = UIButton(type: .system)
        connectButton.setTitle("Connect", for: .normal)
        connectButton.addTarget(self, action: #selector(connectButtonTapped), for: .touchUpInside)
        view.addSubview(connectButton)
        
        connectButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-70)
            make.top.equalTo(statusLabel.snp.bottom).offset(20)
        }
        
        disconnectButton = UIButton(type: .system)
        disconnectButton.setTitle("Disconnect", for: .normal)
        disconnectButton.addTarget(self, action: #selector(disconnectButtonTapped), for: .touchUpInside)
        view.addSubview(disconnectButton)
        
        disconnectButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(70)
            make.top.equalTo(statusLabel.snp.bottom).offset(20)
        }
        
        updateUIForBluetoothState(centralManager.state)
    }
    
    @objc private func connectButtonTapped() {
    }
    
    @objc private func disconnectButtonTapped() {
        guard let connectedPeripheral = centralManager.retrieveConnectedPeripherals(withServices: [CBUUID(string: "YourServiceUUID")]).first else {
            print("주변장치를 찾을 수 없습니다")
            return
        }
        
        centralManager.cancelPeripheralConnection(connectedPeripheral)
    }
    
    // MARK: - CBCentralManagerDelegate Methods
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        updateUIForBluetoothState(central.state)
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        if peripheral.name == "준하의 AirPods Max - Find My" {
            if !peripherals.contains(peripheral) {
                peripherals.append(peripheral)
                tableView.reloadData()
            }
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected to peripheral: \(peripheral)")
        updateUIForBluetoothConnection(true)
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("Failed to connect to peripheral: \(peripheral), error: \(error?.localizedDescription ?? "")")
        updateUIForBluetoothConnection(false)
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Disconnected from peripheral: \(peripheral)")
        updateUIForBluetoothConnection(false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripherals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BluetoothCell", for: indexPath)
        let peripheral = peripherals[indexPath.row]
        cell.textLabel?.text = peripheral.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let peripheral = peripherals[indexPath.row]
        centralManager.stopScan()
        centralManager.connect(peripheral, options: nil)
    }
    
    private func updateUIForBluetoothState(_ state: CBManagerState) {
        switch state {
        case .poweredOn:
            statusLabel.text = "Bluetooth Status: 켜짐"
            startScan()
        case .poweredOff:
            statusLabel.text = "Bluetooth Status: 꺼짐"
        case .unsupported:
            statusLabel.text = "Bluetooth Status: 지원하지 않음"
        case .unauthorized:
            statusLabel.text = "Bluetooth Status: 권한이 없음"
        case .resetting:
            statusLabel.text = "Bluetooth Status: 재설정"
        case .unknown:
            statusLabel.text = "Bluetooth Status: 찾을 수 없음"
        @unknown default:
            statusLabel.text = "Bluetooth Status: 찾을 수 없음"
        }
        
        connectButton.isEnabled = (state == .poweredOn)
        disconnectButton.isEnabled = (state == .poweredOn)
    }
    
    private func updateUIForBluetoothConnection(_ isConnected: Bool) {
        if isConnected {
            statusLabel.text = "Bluetooth Status: Connected"
        } else {
            statusLabel.text = "Bluetooth Status: Disconnected"
        }
        
        tableView.isUserInteractionEnabled = !isConnected
        connectButton.isEnabled = !isConnected
        disconnectButton.isEnabled = isConnected
    }
    
    private func startScan() {
        if centralManager.state == .poweredOn {
            centralManager.scanForPeripherals(withServices: nil, options: nil)
        } else {
            print("Bluetooth is powered off or unavailable")
        }
    }
}
