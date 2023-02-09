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
        changeColorValueLabel()
    }
    
    @IBAction func sliderAction() {
        changeViewColor()
        changeColorValueLabel()
    }
    
    
    private func changeViewColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redColorSlider.value),
            green: CGFloat(greenColorSlider.value),
            blue: CGFloat(blueColorSlider.value),
            alpha: 1
        )
    }
    
    private func changeColorValueLabel() {
        redColorValueLabel.text = String(format: "%.2f", redColorSlider.value)
        greenColorValueLabel.text = String(format: "%.2f", greenColorSlider.value)
        blueColorValueLabel.text = String(format: "%.2f", blueColorSlider.value)
    }
}

