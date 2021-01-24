import Kingfisher
import UIKit

class MovieCell: UICollectionViewCell {
    @IBOutlet private var image: UIImageView!
    @IBOutlet private var movieTitle: UILabel!
    @IBOutlet private var moviesDescription: UILabel!
    @IBOutlet private var releaseDate: UILabel!
    @IBOutlet private var rating: UILabel!

    func configure(_ movie: Movie) {
        image.kf.indicatorType = .activity
        image.kf.setImage(with: URL(string: movie.imageURL))
        movieTitle.text = movie.movieTitle
        moviesDescription.text = movie.movieDescription
        releaseDate.text = movie.releaseDate
        //rating.attributedText = movie.rating
    }
}
