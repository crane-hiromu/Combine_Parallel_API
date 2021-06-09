//
//  SubAPIUseCase.swift
//  Combine_Parallel_API
//
//  Created by Tsuruta, Hiromu | ECID on 2021/06/09.
//

// MARK: Protocol
protocol SubAPIUseCaseProtocol {
    func fetch(completion: @escaping (Result<SubViewEntity, Error>) -> Void)
}

// MARK: - UseCase
final class SubAPIUseCase {
    
    private let client: SubAPIClientable
    
    init(client: SubAPIClientable = SubAPIClient()) {
        self.client = client
    }
}

// MARK: - APIUseCaseProtocol
extension SubAPIUseCase: SubAPIUseCaseProtocol {

    func fetch(completion: @escaping (Result<SubViewEntity, Error>) -> Void) {
        client.fetch() { result in
            switch result {
            case .success(let response):
                completion(.success(.init(response)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
