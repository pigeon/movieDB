import UIKit

final class MoviesListViewController: UIViewController {
    private var collectionView: UICollectionView!
    private let viewModel: MoviesListViewModel
    private var activityView = UIActivityIndicatorView()

    private let columnLayout = MoviesListFlowLayout(
        cellsPerRow: 1,
        minimumInteritemSpacing: 5,
        minimumLineSpacing: 5,
        sectionInset: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    )

    init(viewModel: MoviesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Popular movies", comment: "")
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: columnLayout)
        let cellName = String(describing: MovieCell.self)
        collectionView.register(UINib(nibName: cellName, bundle: .main),
                                forCellWithReuseIdentifier: cellName)
        collectionView.dataSource = self
        collectionView.delegate = self
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadData()
    }

    private func setupUI() {

        activityView.hidesWhenStopped = true
        activityView.color = .white

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        activityView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        view.addSubview(activityView)

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension MoviesListViewController: MoviesListViewDelegate {
    func update(with viewState: MoviesListViewState) {
        switch viewState {
        case .loading:
            activityView.startAnimating()
            break
        case .content:
            activityView.stopAnimating()
            collectionView.reloadData()
            break
        case .error:
            activityView.stopAnimating()
            break
        }
    }
}

extension MoviesListViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return viewModel.numberOfItemsInSection
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCell.self), for: indexPath) as? MovieCell else {
            fatalError("can't dequeue expected cell type")
        }
        cell.configure(viewModel.getMovie(with: indexPath.item))
        return cell
    }
}

extension MoviesListViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath) {
        viewModel.loadDataIfNeeded(with: indexPath.item)
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectItem(with: indexPath.item)
    }
}
