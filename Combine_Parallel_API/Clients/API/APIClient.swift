//
//  APIClient.swift
//  Combine_Parallel_API
//
//  Created by Tsuruta, Hiromu | ECID on 2021/06/09.
//

// MARK: - Protocol
protocol APIClientable {
    func fetch(completion: @escaping (Result<ViewResponse, Error>) -> Void)
}

// MARK: - Client
final class APIClient: APIClientable {
    
    func fetch(completion: @escaping (Result<ViewResponse, Error>) -> Void) {
        // APIを呼び出して結果を返す。Combineの確認のためなので、特に通信はせず成功した前提で結果を返す。
        completion(.success(.init()))
    }
}
