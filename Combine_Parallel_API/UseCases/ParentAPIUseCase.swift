//
//  ParentAPIUseCase.swift
//  Combine_Parallel_API
//
//  Created by Tsuruta, Hiromu | ECID on 2021/06/09.
//

import Foundation
import Combine

// MARK: - Protocol
protocol ParentAPIUseCaseProtocol {
    func fetch() -> AnyPublisher<TotalViewEntity, Never>
    func fetchEntity() -> AnyPublisher<ViewEntity?, Never>
    func fetchSubEntity() -> AnyPublisher<SubViewEntity?, Never>
}

// MARK: - UseCase
final class ParentAPIUseCase {
    
    // MARK: Property

    private let client: APIUseCaseProtocol
    private let subClient: SubAPIUseCaseProtocol
    
    // MARK: Initializer
    
    init(client: APIUseCaseProtocol = APIUseCase(),
         subClient: SubAPIUseCaseProtocol = SubAPIUseCase()) {
        
        self.client = client
        self.subClient = subClient
    }
}

extension ParentAPIUseCase: ParentAPIUseCaseProtocol {
    
    func fetch() -> AnyPublisher<TotalViewEntity, Never> {
        Just(TotalViewEntity())
            .subscribe(on: DispatchQueue.global(qos: .utility))
            .zip(
                fetchEntity(),
                fetchSubEntity()
            )
            .timeout(.seconds(10), scheduler: DispatchQueue.global(qos: .utility))
            .map { totalViewEntity, viewEntity, subViewEntity -> TotalViewEntity in
                totalViewEntity.main = viewEntity
                totalViewEntity.sub = subViewEntity
                return totalViewEntity
            }
            .eraseToAnyPublisher()
    }

    func fetchEntity() -> AnyPublisher<ViewEntity?, Never> {
        Future<ViewEntity?, Never> { [weak self] promise in
            self?.client.fetch() { result in
                switch result {
                case .success(let entity): promise(.success(entity))
                case .failure(_):  promise(.success(nil))
                }
            }
        }.eraseToAnyPublisher()
    }

    func fetchSubEntity() -> AnyPublisher<SubViewEntity?, Never> {
        Future<SubViewEntity?, Never> { [weak self] promise in
            self?.subClient.fetch() { result in
                switch result {
                case .success(let entity): promise(.success(entity))
                case .failure(_):  promise(.success(nil))
                }
            }
        }.eraseToAnyPublisher()
    }
}
