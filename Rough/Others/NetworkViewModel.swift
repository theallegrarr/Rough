//
//  NetworkViewModel.swift
//  Rough
//
//  Created by nurudeen on 09/07/2021.
//

import Foundation
final class Remote<A>: ObservableObject {
    @Published var result: Result<A, Error>? = nil
    var value: A? { try? result?.get() }
    let url: URL
    let transform: (Data) -> A?
    
    init(url: URL, transform: @escaping(Data) -> A?){
        self.url = url
        self.transform = transform
    }
    
    func load(){
        print("called")
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            DispatchQueue.main.async {
                if let d = data, let v = self.transform(d){
                    self.result = .success(v)
                } else {
                    print("failed")
                    self.result = .failure(PhotoLoadingError())
                }
            }
        }.resume()
    }
}
