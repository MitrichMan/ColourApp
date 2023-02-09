//
//  ViewController.swift
//  ColourApp
//
//  Created by Dmitrii Melnikov on 06.02.2023.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redColorValueLabel: UILabel!
    @IBOutlet var greenColorValueLabel: UILabel!
    @IBOutlet var blueColorValueLabel: UILabel!
    
    @IBOutlet var redColorSlider: UISlider!
    @IBOutlet var greenColorSlider: UISlider!
    @IBOutlet var blueColorSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeViewColor()
        changeColorValueLabel(
            for: redColorValueLabel,
            greenColorValueLabel,
            blueColorValueLabel
        )
        
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        changeViewColor()
        switch sender {
        case redColorSlider:
            redColorValueLabel.text = string(from: sender)
        case greenColorSlider:
            greenColorValueLabel.text = string(from: sender)
        default:
            blueColorValueLabel.text = string(from: sender)
        }
    }

    private func changeViewColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redColorSlider.value),
            green: CGFloat(greenColorSlider.value),
            blue: CGFloat(blueColorSlider.value),
            alpha: 1
        )
    }
    
  
    
    private func changeColorValueLabel(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redColorValueLabel:
                redColorValueLabel.text = string(from: redColorSlider)
            case greenColorValueLabel:
                greenColorValueLabel.text = string(from: greenColorSlider)
            default:
                blueColorValueLabel.text = string(from: blueColorSlider)
                
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        return String(format: "%.2f", slider.value)
    }
}

