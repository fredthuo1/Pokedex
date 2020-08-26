import UIKit
import ObjectLibrary
import class Foundation.JSONDecoder

class ListViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private var model: ListModel!
    private var persistence: PokémonPersistence!
    var filteredData: [Pokédex.Entry]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModel()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        filteredData = model.getPokédex().entries
        sortData()
        setUpNavBar()
    }
    
    func setUpNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true

    }
    
    func showAlert() {
        let alertView = UIAlertController(title: "Error Loading Data!!!", message: "Sorry! Try again later!", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alertView, animated: true, completion: nil)
    }
    
    func sortData() {
        filteredData = filteredData.sorted {
            $0.displayText < $1.displayText
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let semaphore = DispatchSemaphore(value: 0)
        if let destination = segue.destination as? DetailViewController {
            self.model.getPokémon(pokédex: filteredData[tableView.indexPathForSelectedRow!.row]) { (results) in
                switch results {
                case .success(let data):
                    destination.pokémon = data
                case .failure(let error):
                    print(error)
                }
                semaphore.signal()
            }
            _ = semaphore.wait(timeout: .distantFuture)
        }
    }
}

extension ListViewController {
    private func configureModel() {
        
        model = ListModel(
            pokédexPersistence: PokédexPersistence(directoryName: "Pokédex"),
            pokémonPersistence: PokémonPersistence(directoryName: "Pokémon"),
            serviceClient: PokéAPIServiceClient.instance,
            delegate: self
        )
        model.loadPokédex()
    }
}

// MARK: - ListModelDelegate

extension ListViewController: ListModelDelegate {
    func willDownload() {
        self.tableView.isUserInteractionEnabled = false
    }
    
    func didDownload(error: ServiceCallError?, reloadData: Bool) {
        self.tableView.isUserInteractionEnabled = false
    }
    
    func show(_ pokémon: Pokémon) {
        self.tableView.isUserInteractionEnabled = true
    }
 
}

// MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard tableView.cellForRow(at: indexPath) != nil else { return }
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var data = model.getPokédex().entries
        data = data.sorted {
            $0.displayText < $1.displayText
        }
        filteredData = []
        if searchText == "" {
            filteredData = data
        } else {
            for entry in model.getPokédex().entries {
                if entry.displayText.lowercased().contains(searchText.lowercased()) {
                filteredData.append(entry)
                }
            }
        }
        
        self.tableView.reloadData()
    }
    
}

extension ListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pokémon = filteredData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "My Cell")!
        cell.textLabel?.text = pokémon.displayText
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
