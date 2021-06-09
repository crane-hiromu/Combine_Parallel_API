//
//  SubAPIClient.swift
//  Combine_Parallel_API
//
//  Created by Tsuruta, Hiromu | ECID on 2021/06/09.
//

// MARK: - Protocol
protocol SubAPIClientable {
    func fetch(completion: @escaping (Result<SubViewResponse, Error>) -> Void)
}

// MARK: - Client
final class SubAPIClient: SubAPIClientable {
    
    func fetch(completion: @escaping (Result<SubViewResponse, Error>) -> Void) {
        // APIを呼び出して結果を返す。Combineの確認のためなので、特に通信はせず成功した前提で結果を返す。
        completion(.success(.init()))
    }
}
