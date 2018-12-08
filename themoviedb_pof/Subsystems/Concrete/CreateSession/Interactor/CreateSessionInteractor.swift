//
//  CreateSessionInteractor.swift
//  themoviedb_pof
//
//  Created by Elizabeth Rudenko on 19.04.2018.
//  Copyright © 2018 Roman Ustiantcev. All rights reserved.
//

import RIBs
import RxSwift

protocol CreateSessionRouting: ViewableRouting {
    func ShowAlertError(_ error: String)
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol CreateSessionPresentable: Presentable {
    var listener: CreateSessionPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol CreateSessionListener: class {
    func closeCreateSession()
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class CreateSessionInteractor: PresentableInteractor<CreateSessionPresentable>, CreateSessionInteractable, CreateSessionPresentableListener {
    
    weak var router: CreateSessionRouting?
    weak var listener: CreateSessionListener?
    
    lazy var authNetworkService = AuthNetworkService()
    let idSession = Variable(false)
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: CreateSessionPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
        sessionObserver()
    }
    
    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    // MARK: - CreateSessionPresentableListener
    
    func getURL() -> URL {
        return getURL(withEndpoint: nil)
    }
    
    func checkURL(url: URL) {
        let allowURL = getURL(withEndpoint: ClientConfig.AllowToken)
        let denyURL = getURL(withEndpoint: ClientConfig.DenyToken)
        
        if url == allowURL {
            getSession()
        }
        
        if url == denyURL {
            self.listener?.closeCreateSession()
        }
    }
    
    // MARK: - Private
    
    private func getSession() {
        authNetworkService.createSessionId(completionHandler: { [weak self] session in
            guard let strongSelf = self else { return }
            strongSelf.idSession.value = session!
            strongSelf.getUsername()
            }, errorHandler: { [weak self]  error in
                DispatchQueue.main.async {
                    guard let strongSelf = self else { return }
                    if let errorText = error {
                        strongSelf.router?.ShowAlertError(errorText)
                    }
                }
        })
    }
    
    private func getUsername() {
        authNetworkService.getAccountDetails(errorHandler: { (error) in
                print("error getUsername \(error!)")
        })
    }
    
    private func getURL(withEndpoint enpoint: String?) -> URL! {
        let requestToken = User.getCurrentUser().request_token!
        var stringURL = ClientConfig.AuthorizationURL + requestToken
        if enpoint != nil {
            stringURL += enpoint!
        }
        let url = URL(string: stringURL)!
        return url
    }
    
    private func sessionObserver() {
        DispatchQueue.main.async {
            self.idSession.asObservable()
                .subscribe(onNext: { [weak self] session in
                    guard let strongSelf = self else { return }
                    DispatchQueue.main.async {
                        if session {
                            strongSelf.listener?.closeCreateSession()
                        }
                    }
                }).disposeOnDeactivate(interactor: self)
        }
    }
}
