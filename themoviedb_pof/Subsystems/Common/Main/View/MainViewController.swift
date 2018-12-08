//
//  MainViewController.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 22.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs
import UIKit

protocol MainPresentableListener: class {
    func logoutUser()
    func changeRibsWithIndex(index: Int)
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class MainViewController: UIViewController, MainPresentable, MainViewControllable {
    
    weak var listener: MainPresentableListener?
    
    @IBOutlet var tabBarButtons: [UIButton]!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var logoutBarButton: UIBarButtonItem!
    
    var centerViewController: UIViewController?
    var selectedIndex: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectControllerWithIndex(index: 0)
    }
    
    // MARK: MainViewControllable
    
    func present(viewController: ViewControllable) {
        let viewController = viewController.uiviewController
        viewController.willMove(toParentViewController: self)
        viewController.view.alpha = 0
        viewController.view.frame = containerView.bounds
        containerView.addSubview(viewController.view)
        
        self.centerViewController?.view.removeFromSuperview()
        self.centerViewController = viewController
        
        viewController.view.alpha = 1
        viewController.didMove(toParentViewController: self)
    }
    
    func presentWithNavController(viewController: ViewControllable) {
        self.navigationController?.pushViewController(viewController.uiviewController, animated: true)
    }
    
    private func selectControllerWithIndex(index: Int) {
        guard selectedIndex != index else { return }
        tabBarButtons[selectedIndex].isSelected = false
        
        selectedIndex = index
        listener?.changeRibsWithIndex(index: selectedIndex)
        tabBarButtons[selectedIndex].isSelected = true
    }
}

extension MainViewController {
    
    @IBAction func tabBarButtonTapped(sender: UIButton) {
        let index = sender.tag
        selectControllerWithIndex(index: index)
    }
    
    @IBAction func logoutBarButtonTapped(sender: UIBarButtonItem) {
        listener?.logoutUser()
    }
}
