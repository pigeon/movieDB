import UIKit

class MovieDetailsViewController: UIViewController {
    private let viewModel: MovieDetailsViewModel
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var overviewTextView: UITextView!
    @IBOutlet private weak var releaseDate: UILabel!
    @IBOutlet private weak var vote: UILabel!
    @IBOutlet private weak var budget: UILabel!

    private lazy var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        formatter.locale = Locale.current
        formatter.currencyCode = "USD"
        return formatter
    }()

    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "MovieDetailsViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        overviewLabel.text = NSLocalizedString("Overview:", comment: "")
        viewModel.fetchMovieData()
    }
}

extension MovieDetailsViewController: MovieDetailsViewDelegate {
    func update(with viewState: MovieDetailsViewState) {
        title = viewState.title
        releaseDate.text = viewState.releaseDate
        vote.text = viewState.rating
        imageView.kf.setImage(with: URL(string: viewState.imageURL))
        overviewTextView.text = viewState.overview
        if let doubleValue = Double(viewState.budget),
           doubleValue > 0,
           let number = currencyFormatter.string(from: NSNumber(value: doubleValue)) {
            budget.text = NSLocalizedString("Budget \(number)", comment: "")
        }
    }
}
