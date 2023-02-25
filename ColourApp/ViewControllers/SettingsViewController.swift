//
//  ViewController.swift
//  ColourApp
//
//  Created by Dmitrii Melnikov on 06.02.2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    @IBOutlet var colorView: UIView!
    @IBOutlet var colorSliders: [UISlider]!
    @IBOutlet var valueLabels: [UILabel]!
    @IBOutlet var valueTextFields: [UITextField]!
    
    var mainBackgroundColor: UIColor!
    
    unowned var delegate: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        valueTextFields.forEach { textField in
            textField.delegate = self
        }
        
        colorView.backgroundColor = mainBackgroundColor
        
        changeColorSlidersValue()
        setupValueLabels(for: valueLabels)
        setupValueTextFields(for: valueTextFields)
        
        setupToolBar(for: valueTextFields)
    }
    
    // MARK: - IBActions
    @IBAction func sliderAction(_ sender: UISlider) {
        
        changeViewColor()
        changeValueLabel(for: valueLabels[sender.tag], from: sender)
        changeValueTextField(for: valueTextFields[sender.tag], from: sender)
    }
    
    @IBAction func doneButtonTapped() {
        delegate.setupColor(
            with: colorView.backgroundColor
            ?? UIColor.systemBackground
        )
        dismiss(animated: true)
    }
    
    // MARK: - changeColorSlidersValue
    private func changeColorSlidersValue() {
        var redValue: CGFloat = 0
        var greenValue: CGFloat = 0
        var blueValue: CGFloat = 0
        
        let color = CIColor(color: colorView.backgroundColor ?? UIColor.systemBackground)
        
        redValue = color.red
        greenValue = color.green
        blueValue = color.blue
        
        let colors = [redValue, greenValue, blueValue]
        
        for index in 0..<colorSliders.count {
            colorSliders[index].value = Float(colors[index])
        }
    }
    
    // MARK: - changeViewColor
    private func changeViewColor() {
        var redValue: CGFloat = 0
        var greenValue: CGFloat = 0
        var blueValue: CGFloat = 0
        
        for colorSlider in colorSliders {
            switch colorSlider.tag {
            case 0:
                redValue = CGFloat(colorSlider.value)
            case 1:
                greenValue = CGFloat(colorSlider.value)
            default:
                blueValue = CGFloat(colorSlider.value)
            }
        }
        
        colorView.backgroundColor = UIColor(
            red: redValue,
            green: greenValue,
            blue: blueValue,
            alpha: 1
        )
    }
    
    // MARK: - changeColorValueLabel
    private func changeValueLabel(for label: UILabel, from slider: UISlider) {
        label.text = string(from: slider)
    }
    
    // MARK: - setupValueLabels
    private func setupValueLabels(for valueLabels: [UILabel]) {
        for index in 0..<valueLabels.count {
            valueLabels[index].text = string(from: colorSliders[index])
        }
    }
    
    // MARK: - changeColorTextField
    private func changeValueTextField(for textField: UITextField, from slider: UISlider) {
        textField.text = string(from: slider)
    }
    
    // MARK: - setupValueTextFields
    private func setupValueTextFields(for textFields: [UITextField]) {
        for index in 0..<valueTextFields.count {
            valueTextFields[index].text = string(from: colorSliders[index])
        }
    }
    
    // MARK: - changeSliderValue
    private func changeSliderValue(for slider: UISlider, from textField: UITextField) {
        slider.setValue(Float(textField.text ?? "0.5") ?? 0.5, animated: true)
    }
    
    // MARK: - string
    private func string(from slider: UISlider) -> String {
        return String(format: "%.2f", slider.value)
    }
}

// MARK: - SettingsViewController extensions
extension SettingsViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
     
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let number = Float(textField.text ?? ""), number >= 0 && number <= 1 else {
            showAlert(
                title: "Wrong input format",
                message: "Please, use only numbers from 0 to 1",
                textField: textField
            )
            return
        }
        changeSliderValue(for: colorSliders[textField.tag], from: textField)
        setupValueLabels(for: valueLabels)
        changeViewColor()
    }
}

extension SettingsViewController {
    func setupToolBar(for textFields: [UITextField]) {
        let toolBar = UIToolbar()
        let doneBarButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(barButtonTapped)
        )
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: self,
            action: nil
        )
        toolBar.items = [flexibleSpace ,doneBarButton]
        toolBar.sizeToFit()
        for valueTextField in textFields{
            valueTextField.inputAccessoryView = toolBar
        }
    }
}

extension SettingsViewController {
    @objc private func barButtonTapped() {
        view.endEditing(true)
    }
}

extension SettingsViewController {
    private func showAlert(
        title: String,
        message: String,
        textField: UITextField? = nil
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            textField?.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
