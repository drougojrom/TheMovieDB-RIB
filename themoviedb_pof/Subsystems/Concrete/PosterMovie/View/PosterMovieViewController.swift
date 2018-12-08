//
//  PosterMovieViewController.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 23.05.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs
import ARKit

protocol PosterMoviePresentableListener: class {
    func closePosterMovie()
    func setImage() -> UIImage
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class PosterMovieViewController: UIViewController, PosterMoviePresentable, PosterMovieViewControllable {

    weak var listener: PosterMoviePresentableListener?
    
    @IBOutlet weak var backBarButton: UIBarButtonItem!
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initScenViewAndARSession()
    }
}

extension PosterMovieViewController {
    
    @IBAction func backBarButtonTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        listener?.closePosterMovie()
    }
}

