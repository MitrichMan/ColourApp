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
        colorView.backgroundColor = mainBackgroundColor
        
        changeColorSlidersValue()
        changeValueLabel(for: valueLabels)
        changeValueTextField(for: valueTextFields)
        
        setupToolBar(for: valueTextFields)
    }
    
    // MARK: - IBActions
    @IBAction func sliderAction(_ sender: UISlider) {
        
        changeViewColor()
        changeValueLabel(for: valueLabels)
        changeValueTextField(for: valueTextFields)
    }
    
    @IBAction func doneButtonTapped() {
        mainBackgroundColor = colorView.backgroundColor
        delegate.setupColor(with: mainBackgroundColor)
        dismiss(animated: true)
    }
    
    // MARK: - changeColorSlidersValue
    private func changeColorSlidersValue() {
        var redValue: CGFloat = 0
        var greenValue: CGFloat = 0
        var blueValue: CGFloat = 0
        var alpha: CGFloat = 0
        
        mainBackgroundColor.getRed(
            &redValue,
            green: &greenValue,
            blue: &blueValue,
            alpha: &alpha
        )
        
        let colors = [redValue, greenValue, blueValue]
        
        for index in 0..<colorSliders.count {
            colorSliders[index].value = Float(colors[index])
        }
    }
    
    // MARK: - setSliderFromTextField
    private func setSliderFromTextField() {
        for index in 0..<colorSliders.count {
            colorSliders[index].setValue(
                Float(valueTextFields[index].text ?? "0.5") ?? 0.5,
                animated: true
            )
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
    private func changeValueLabel(for labels: [UILabel]) {
        for index in 0..<labels.count {
            labels[index].text = string(from: colorSliders[index])
        }
    }
    
    // MARK: - changeColorTextField
    private func changeValueTextField(for textFields: [UITextField]) {
        for index in 0..<valueTextFields.count {
            valueTextFields[index].text = string(from: colorSliders[index])
        }
    }
    
    // MARK: - string
    private func string(from slider: UISlider) -> String {
        return String(format: "%.2f", slider.value)
    }
}

// MARK: - extension
extension SettingsViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
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
    
    @objc private func barButtonTapped() {
        for index in 0..<colorSliders.count {
            colorSliders[index].setValue(
                Float(valueTextFields[index].text ?? "0") ?? 0,
                animated: true
            )
        }
        changeValueLabel(for: valueLabels)
        changeViewColor()
        changeValueTextField(for: valueTextFields)
        view.endEditing(true)
    }
}
