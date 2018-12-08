//
//  LoggedOutViewController.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 18.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs
import UIKit

protocol LoggedOutPresentableListener: class {
    func getToken()
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {
    
    weak var listener: LoggedOutPresentableListener?
    
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - ListViewControllable
    
    func present(view: ViewControllable) {
        self.navigationController?.pushViewController(view.uiviewController, animated: true)
    }
    
    func dismiss(view: ViewControllable) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - LoggedOutPresentable
    
    func showTitle(_ title: String) {
        self.title = title
    }
}

extension LoggedOutViewController {
    @IBAction func didTapLoginButton() {
        listener?.getToken()
    }
}
