//
//  MainViewController.swift
//  ColourApp
//
//  Created by Dmitrii Melnikov on 23.02.2023.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func setupColor(with color: UIColor)
}

class MainViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else {
            return
        }
        settingsVC.mainBackgroundColor = view.backgroundColor
        settingsVC.delegate = self
    }
    
    @IBAction func settingsButtonTapped(_ sender: UIBarButtonItem) {
    }
}

// MARK: - SettingsViewControllerDelegate
extension MainViewController: SettingsViewControllerDelegate {
    func setupColor(with color: UIColor) {
        view.backgroundColor = color
    }
}
