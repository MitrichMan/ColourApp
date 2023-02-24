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
    
    var backgroundColor = UIColor.systemBackground
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundColor()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else {
            return
        }
        settingsVC.mainBackgroundColor = view.backgroundColor
        settingsVC.delegate = self
    }
    
    @IBAction func settingsButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToSettings", sender: nil)
    }
    
    private func setBackgroundColor() {
        view.backgroundColor = backgroundColor
    }
}

// MARK: - SettingsViewControllerDelegate
extension MainViewController: SettingsViewControllerDelegate {
    func setupColor(with color: UIColor) {
        self.backgroundColor = color
        setBackgroundColor()
    }
}
