import UIKit
import SnapKit
import Then

enum Operator {
    case plus
    case minus
    case multiply
    case divide
}

class CalculatorViewController: UIViewController {

    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .cellColor
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.register(CalculatorCell.self, forCellWithReuseIdentifier: CalculatorCell.identifier)
    }

    private var buttons: [[String]] = [
        ["AC", "±", "%", "÷"],
        ["7", "8", "9", "×"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", ".", "="]
    ]

    private var currentNumber = ""
    private var currentOperator: Operator?

    private let resultLabel = UILabel().then {
        $0.textAlignment = .right
        $0.font = UIFont.systemFont(ofSize: 60)
        $0.text = "0"
    }

    private var movingCellSnapshot: UIView?
    private var sourceIndexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .cellColor
        layout()
        navigationTitle()

        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(_:)))
        collectionView.addGestureRecognizer(longPressGesture)
        
        collectionView.register(CalculatorCell.self, forCellWithReuseIdentifier: CalculatorCell.identifier)
    }

    private func navigationTitle() {
        title = "계산기"
    }

    private func layout() {
        view.addSubview(resultLabel)
        view.addSubview(collectionView)

        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        collectionView.collectionViewLayout = layout

        collectionView.delegate = self
        collectionView.dataSource = self

        resultLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.leading.equalToSuperview().offset(20)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(resultLabel.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CalculatorViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 30) / 4

        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == buttons.count - 1 {
            return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        } else {
            return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension CalculatorViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalculatorCell.identifier, for: indexPath) as! CalculatorCell
        let buttonText = buttons[indexPath.section][indexPath.row]
        cell.button.setTitle(buttonText, for: .normal)
        cell.button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)

        switch buttonText {
        case "+":
            cell.button.backgroundColor = .white
        case "-":
            cell.button.backgroundColor = .white
        case "×":
            cell.button.backgroundColor = .white
        case "÷":
            cell.button.backgroundColor = .white
        case "=":
            cell.button.backgroundColor = .white
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            cell.button.setTitleColor(.cellTitleColor, for: .normal)
        default:
            cell.button.backgroundColor = .white
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttons[section].count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return buttons.count
    }
}

// MARK: - UICollectionViewDelegate

extension CalculatorViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedButton = buttons[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        buttons[destinationIndexPath.section].insert(movedButton, at: destinationIndexPath.row)

        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let buttonText = buttons[indexPath.section][indexPath.row]
        handleButtonInput(buttonText)
    }
    
    @objc private func handleLongGesture(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }

//    @objc private func handleLongGesture(_ gesture: UILongPressGestureRecognizer) {
//        switch gesture.state {
//        case .began:
//            guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)),
//                  let cell = collectionView.cellForItem(at: selectedIndexPath) else {
//                break
//            }
//            sourceIndexPath = selectedIndexPath
//            movingCellSnapshot = cell.snapshotView(afterScreenUpdates: false)
//            if let snapshot = movingCellSnapshot {
//                snapshot.frame = cell.frame
//                collectionView.addSubview(snapshot)
//                UIView.animate(withDuration: 0.2) {
//                    snapshot.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
//                    snapshot.alpha = 0.9
//                }
//                cell.isHidden = true
//            }
//        case .changed:
//            guard let movingCellSnapshot = movingCellSnapshot else {
//                break
//            }
//            movingCellSnapshot.center = gesture.location(in: collectionView)
//            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
//        case .ended:
//            guard let movingCellSnapshot = movingCellSnapshot,
//                  let sourceIndexPath = sourceIndexPath,
//                  let indexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
//                break
//            }
//            collectionView.endInteractiveMovement()
//            buttons.swapAt(sourceIndexPath.section, indexPath.section)
//            collectionView.moveItem(at: sourceIndexPath, to: indexPath)
//            UIView.animate(withDuration: 0.2, animations: {
//                movingCellSnapshot.transform = CGAffineTransform.identity
//                movingCellSnapshot.alpha = 1.0
//            }) { _ in
//                movingCellSnapshot.removeFromSuperview()
//                self.collectionView.cellForItem(at: indexPath)?.isHidden = false
//            }
//            self.sourceIndexPath = nil
//        default:
//            collectionView.cancelInteractiveMovement()
//            sourceIndexPath = nil
//        }
//    }
}

extension CalculatorViewController {
    @objc private func didTapButton(_ sender: UIButton) {
        guard let buttonText = sender.titleLabel?.text else {
            return
        }
        handleButtonInput(buttonText)
    }

    private func handleButtonInput(_ buttonText: String) {
        switch buttonText {
        case "AC":
            currentNumber = ""
            resultLabel.text = "0"
        case "±":
            if currentNumber.hasPrefix("-") {
                currentNumber.removeFirst()
            } else {
                currentNumber.insert("-", at: currentNumber.startIndex)
            }
            resultLabel.text = currentNumber
        case "%":
            if let number = Double(currentNumber) {
                currentNumber = String(number / 100)
                resultLabel.text = currentNumber
            }
        case "+", "-", "×", "÷":
            if let number = Double(currentNumber) {
                currentNumber = ""
                currentOperator = operatorForSymbol(buttonText)
                resultLabel.text = currentNumber
            }
        case "=":
            calculateResult()
        case ".":
            if !currentNumber.contains(".") {
                currentNumber += buttonText
                resultLabel.text = currentNumber
            }
        default:
            currentNumber += buttonText
            resultLabel.text = currentNumber
        }
    }
    
    private func operatorForSymbol(_ symbol: String) -> Operator? {
        switch symbol {
        case "+":
            return .plus
        case "-":
            return .minus
        case "×":
            return .multiply
        case "÷":
            return .divide
        default:
            return nil
        }
    }

    private func calculateResult() {
        guard let number1 = Double(currentNumber),
              let operator1 = currentOperator else {
            return
        }

        var result: Double = 0

        guard let number2 = Double(currentNumber) else {
            return
        }

        switch operator1 {
        case .plus:
            result = number1 + number2
        case .minus:
            result = number1 - number2
        case .multiply:
            result = number1 * number2
        case .divide:
            result = number1 / number2
        }

        currentNumber = String(result)
        resultLabel.text = currentNumber
        currentOperator = nil
    }
    
}
