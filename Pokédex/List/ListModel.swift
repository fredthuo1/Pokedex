import UIKit
import ObjectLibrary

/// Use these methods to notify the models when to show/ hide various UI components
protocol ListModelDelegate: class {
    func willDownload()
    func didDownload(error: ServiceCallError?, reloadData: Bool)
    func show(_ pokémon: Pokémon)
}

final class ListModel {
    // MARK: - Properties
    
    private let pokédexPersistence: PokédexPersistence
    private let pokémonPersistence: PokémonPersistence
    private let serviceClient: PokéAPIServiceClient
    private weak var delegate: ListModelDelegate?
    
    private var pokédex: Pokédex?
    
    init(pokédexPersistence: PokédexPersistence, pokémonPersistence: PokémonPersistence, serviceClient: PokéAPIServiceClient, delegate: ListModelDelegate) {
        self.pokédexPersistence = pokédexPersistence
        self.pokémonPersistence = pokémonPersistence
        self.serviceClient = serviceClient
        self.delegate = delegate
    }
    
    func loadPokédex() {
        if pokédexPersistence.pokédex != nil {
            pokédex = pokédexPersistence.pokédex
        } else {
            delegate?.willDownload()
            serviceClient.getPokédex { (results) in
                switch results {
                case .success(let data):
                    self.pokédex = data
                    self.pokédexPersistence.save(self.pokédex!)
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
    
    func getPokémon(pokédex: Pokédex.Entry, completion: @escaping (PokémonResult) -> ()) {
        self.loadPokédex()
        let url = pokédex.url
        
        serviceClient.getPokémon(fromUrl: url) { (results) in
            switch results {
            case .success(let data):
                completion(.success(data))
                self.delegate?.show(data)
            case .failure(let error):
                completion(.failure(error))
            }
         }
        
    }
        
    func getPokédex() -> Pokédex {
        self.loadPokédex()
        return pokédex!
    }
    
}
