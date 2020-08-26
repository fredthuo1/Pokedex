import UIKit
import class AVFoundation.AVAudioPlayer
import struct ObjectLibrary.Pokémon

final class DetailViewController: UIViewController {
    // MARK: - IBOutlets
    
    @IBOutlet weak var pokémonImage: UIImageView!
    @IBOutlet weak var pokémonHeight: UILabel!
    @IBOutlet weak var pokémonTypes: UILabel!
    @IBOutlet weak var spinner:UIActivityIndicatorView!
    @IBOutlet weak var playButton: UIButton!
    
    // MARK: - Properties
    
    var pokémon: Pokémon!
    private var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        NSDataAsset(name: pokémon.displayName).flatMap {
            audioPlayer = try? AVAudioPlayer(data: $0.data, fileTypeHint: "wav")
            spinner.hidesWhenStopped = true
            spinner.stopAnimating()
        }
        
        print(pokémon.displayName)
        pokémonImage.image = pokémon.image
        pokémonHeight.text = "Height: \(pokémon.height)"
        pokémonTypes.text = "Types: \(pokémon.displayTypes)"
        
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.title = pokémon.displayName
        
        playButton.layer.cornerRadius = 25
    }
    
    // MARK: - IBActions
    
    @IBAction private func playButtonTapped(_ sender: Any) {
        if let audioPlayer = self.audioPlayer {
            audioPlayer.play()
            return
        }
        
        presentSingleActionAlert(alerTitle: "", message: "Audio not available", actionTitle: "OK", completion: {})
    }

}
