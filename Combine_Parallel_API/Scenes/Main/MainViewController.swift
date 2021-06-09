//
//  MainViewController.swift
//  Combine_Parallel_API
//
//  Created by Tsuruta, Hiromu | ECID on 2021/06/09.
//

import UIKit
import Combine

// MARK: - Controller
final class MainViewController: UIViewController {
    
    // MARK: Property
    
    private var cancellables: [AnyCancellable] = []
    private let parentAPIUseCase: ParentAPIUseCaseProtocol
    
    // MARK: Initializer
    
    init(parentAPIUseCase: ParentAPIUseCaseProtocol = ParentAPIUseCase()) {
        self.parentAPIUseCase = parentAPIUseCase
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init()
    }
    
    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        parentAPIUseCase
            .fetch()
            .receive(on: DispatchQueue.main)
            .sink { entity in
                debugPrint("main: \(String(describing: entity.main))")
                debugPrint("sub: \(String(describing: entity.sub))")
            }
            .store(in: &cancellables)
    }
}
