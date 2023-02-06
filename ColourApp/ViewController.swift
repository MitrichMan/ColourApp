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
        
        redColorValueLabel.text = redColorSlider.value.formatted()
        greenColorValueLabel.text = greenColorSlider.value.formatted()
        blueColorValueLabel.text = blueColorSlider.value.formatted()
    }
    
    private func changeViewColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redColorSlider.value),
            green: CGFloat(greenColorSlider.value),
            blue: CGFloat(blueColorSlider.value),
            alpha: 1
        )
    }
    
    @IBAction func redColorSliderAction() {
        redColorValueLabel.text = (round(redColorSlider.value * 100) / 100).formatted()
        changeViewColor()
    }
    
    @IBAction func greenColorSliderAction() {
        greenColorValueLabel.text = (round(greenColorSlider.value * 100) / 100).formatted()
        changeViewColor()
    }
    
    @IBAction func blueColorSliderAction() {
        blueColorValueLabel.text = (round(blueColorSlider.value * 100) / 100).formatted()
        changeViewColor()
    }
    
}

