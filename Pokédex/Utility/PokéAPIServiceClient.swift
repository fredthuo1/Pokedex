import UIKit
import ObjectLibrary
import class Foundation.JSONDecoder
import struct Foundation.URL
import class Foundation.JSONSerialization

final class PokéAPIServiceClient {
    /// `static` factory attribute for instantiating a new object
    static var instance: PokéAPIServiceClient { .init(baseServiceClient: BaseServiceClient(), urlProvider: URLProvider()) }
    
    /// Convenience property for performing network calls
    private let baseServiceClient: BaseServiceClient
    /// Convenience property for creating `URL` objects
    private let urlProvider: URLProvider
    
    private init(baseServiceClient: BaseServiceClient, urlProvider: URLProvider) {
        self.baseServiceClient = baseServiceClient
        self.urlProvider = urlProvider
    }
    
    func getPokédex(completion: @escaping (PokédexResult) -> ()) {
        let pokéAPIURL = URL(string: "https://pokeapi.co")!
        let pathComponents = ["api", "v2", "pokemon"]
        let parameters = ["offset": "0", "limit": "964"]
        let url = urlProvider.url(forBaseURL: pokéAPIURL, pathComponents: pathComponents, parameters: parameters)
        let decoder = JSONDecoder()
        self.baseServiceClient.get(from: url) { (results) in
            switch results {
            case .success(let data):
                let res = try? decoder.decode(Pokédex.self, from: data)
                completion(.success(res!))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getPokémon(fromUrl url: URL, completion: @escaping (PokémonResult) -> ()) {
        let decoder = JSONDecoder()
        var service: ServicePokémon!
        let semaphore = DispatchSemaphore(value: 0)
        print(url)
        self.baseServiceClient.get(from: url) { (results) in
            switch results {
            case .success(let data):
                print(data)
                service = try? decoder.decode(ServicePokémon.self, from: data)
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
                
            semaphore.signal()
        }
        semaphore.wait(timeout: .distantFuture)

        self.getSprite(for: service!) { (results) in
            switch results {
            case .success(let pokemon):
                completion(.success(pokemon))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
}

extension PokéAPIServiceClient {
    private func getSprite(for servicePokémon: ServicePokémon, completion: @escaping (PokémonResult) -> ()) {
        
        baseServiceClient.get(from: servicePokémon.spriteUrl) { (results) in
            switch results {
            case .success(let data):
                completion(.success(Pokémon.init(servicePokémon: servicePokémon, sprite: data)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
}
