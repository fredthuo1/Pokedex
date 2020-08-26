import struct Foundation.URL
import class Foundation.FileManager
import struct ObjectLibrary.Pokémon
import class Foundation.JSONDecoder
import class Foundation.URLSession
import struct Foundation.URLRequest
import class Foundation.HTTPURLResponse
import class Foundation.JSONSerialization
import struct Foundation.Data
import ObjectLibrary

final class PokémonPersistence: FileStoragePersistence {
    let directoryURL: URL
    let fileType: String = "json"

    public init(directoryName: String) {
        self.directoryURL = FileManager.default.directoryInUserLibrary(named: directoryName)
    }
    
    func save(_ pokémon: Pokémon) {
        let fileManager = FileManager()
        fileManager.save(object: pokémon, to: directoryURL)
    }
    
}
