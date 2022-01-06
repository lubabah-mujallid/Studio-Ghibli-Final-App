
import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewMovieCell: UIImageView!
    
    @IBOutlet weak var labelMovieCell: UILabel!
    
    func setupCell(movie: Movie) {
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        imageViewMovieCell.layer.cornerRadius = 10
        imageViewMovieCell.clipsToBounds = true
        
        labelMovieCell.text = movie.title
        imageViewMovieCell.downloaded(from: movie.image)
    }
    
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleToFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleToFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
