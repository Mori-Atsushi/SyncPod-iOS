//
//  WelcomeViewController.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/05/20.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WelcomeViewConstoller: UIViewController {
    let disposeBag = DisposeBag()
    var viewModel: WelcomeViewModel?

    @IBOutlet weak var signInButton: UIBarButtonItem!
    @IBOutlet weak var signUpButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpDataBinding()
    }

    private func setUpDataBinding() {
        signInButton.rx.tap
            .subscribe({ _ in self.viewModel?.onSignInClicked() })
            .disposed(by: disposeBag)
        signUpButton.rx.tap
            .subscribe({ _ in self.viewModel?.onSignUpClicked() })
            .disposed(by: disposeBag)
    }
}
