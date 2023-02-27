//
//  ViewController.swift
//  DoublePickerEx
//
//  Created by KeenKim on 2023/02/28.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var regionPickerView: UIPickerView!
    @IBOutlet weak var resultLabel: UILabel!
    
    let list = RegionData.list
    var firstPickerRow: Int = 0
    var address: (city: String?, gu: String?)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regionPickerView.delegate = self
        regionPickerView.dataSource = self
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return list.count
        case 1:
            return list[firstPickerRow].guList.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == regionPickerView {
            switch component {
            case 0:
                return list[row].city.rawValue
            case 1:
                return list[firstPickerRow].guList[row]
            default:
                return nil
            }
        } else {
            return "-"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            firstPickerRow = row
            let selectedItem = list[firstPickerRow]
            let city = selectedItem.city.rawValue
            address = (city, nil)
            regionPickerView.reloadAllComponents()
        case 1:
            let selectedItem = list[firstPickerRow]
            address.gu = selectedItem.guList[row]
        default:
            return
        }
        
        resultLabel.text = "\(address.city ?? "-") \(address.gu ?? "-")"
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
}
