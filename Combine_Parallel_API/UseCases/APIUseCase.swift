//
//  APIUseCase.swift
//  Combine_Parallel_API
//
//  Created by Tsuruta, Hiromu | ECID on 2021/06/09.
//

// MARK: Protocol
protocol APIUseCaseProtocol {
    func fetch(completion: @escaping (Result<ViewEntity, Error>) -> Void)
}

// MARK: - UseCase
final class APIUseCase {
    
    private let client: APIClientable
    
    init(client: APIClientable = APIClient()) {
        self.client = client
    }
}

// MARK: - APIUseCaseProtocol
extension APIUseCase: APIUseCaseProtocol {

    func fetch(completion: @escaping (Result<ViewEntity, Error>) -> Void) {
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
