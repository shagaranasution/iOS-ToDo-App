//
//  TimePickerViewController.swift
//  ToDo
//
//  Created by Shagara F Nasution on 22/06/20.
//  Copyright © 2020 Shagara F Nasution. All rights reserved.
//

import UIKit

protocol TimePickerViewControllerDelegate: class {
    func timePickerViewControllerDidSet(_ timePickerViewConroller: TimePickerViewController, timeContextType: TimeContextType, timeSet: Date)
    func timePickerViewControllerDidCancel(_ timePickerViewController: TimePickerViewController)
}

enum TimeContextType {
    case startTime
    case finishTime
}

class TimePickerViewController: UIViewController {
    
    @IBOutlet weak var dialogBoxView: UIView!
    @IBOutlet weak var selectTimeLabel: UILabel!
    @IBOutlet weak var timePickedLabel: UILabel!
    @IBOutlet weak var setTimeButton: UIButton!
    @IBOutlet weak var timeview: UIView!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    weak var delegate: TimePickerViewControllerDelegate?
    
    var timeContextType: TimeContextType = .startTime
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        if timeContextType == .startTime {
            selectTimeLabel.text = "Select start time"
        } else {
            selectTimeLabel.text = "Select finish time"
        }
        
        let currentDateTime = Date()
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let stringDate = dateFormatter.string(from: currentDateTime)
        
        timePickedLabel.text = stringDate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    @IBAction func timePickerChanged(_ sender: UIDatePicker) {
        dateFormatter.timeStyle = DateFormatter.Style.short
//        dateFormatter.locale = Locale(identifier: "en_GB")
        
        let stringDate = dateFormatter.string(from: timePicker.date)
        
        timePickedLabel.text = stringDate
    }
    
    @IBAction func setTimePressed(_ sender: UIButton) {
        self.delegate?.timePickerViewControllerDidSet(self, timeContextType: timeContextType, timeSet: timePicker.date)
    }
    
    @IBAction func dismissButtonPressed(_ sender: UIButton) {
        self.delegate?.timePickerViewControllerDidCancel(self)
    }
    
    func configureView() {
        // adding an overlay to the view to give focus to the dialog box
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.40)
        
        // customizing the dialog box
        dialogBoxView.layer.cornerRadius = 10.0
        dialogBoxView.layer.borderWidth = 1.0
        dialogBoxView.layer.borderColor = #colorLiteral(red: 0.2549019608, green: 0.2549019608, blue: 0.2549019608, alpha: 1)
        
        // customizing set time button
        setTimeButton.layer.cornerRadius = 10.0

    }
    
}