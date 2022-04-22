//
//  ViewController.swift
//  itunes-search
//
//  Created by Halit İnan on 16.04.2022.
//

import UIKit
import SnapKit

class SearchViewController: BaseViewController, UISearchResultsUpdating {
    
    var collectionView: UICollectionView!
    let searchController = UISearchController(searchResultsController: nil)
    
    let viewModel = SearchViewModel()
    var sections: [Section] = [Section(nane: "Small", size: ImageSize.s, images: []),
                               Section(nane: "Medium", size: ImageSize.m, images: []),
                               Section(nane: "Large", size: ImageSize.l, images: []),
                               Section(nane: "XLarge", size: ImageSize.xl, images: [])]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        definesPresentationContext = true
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        settingsSearchBar()
        settingsCollectionView()
    }
    
    private func settingsSearchBar() {
        searchController.searchResultsUpdater = self
        self.navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
    }
    
    private func settingsCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 15,
                                 height: 200)
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
        
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}


extension SearchViewController {
    private func removeAllData() {
        
       /* for var section in self.sections {
            section.images.removeAll()
        }*/
        sections[0].images.removeAll()
        sections[1].images.removeAll()
        sections[2].images.removeAll()
        sections[3].images.removeAll()
    }
    
    func filterContent(for searchText: String) {
        if(searchText.count > 2) {
            removeAllData()
            viewModel.getSearch(with: searchText)
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
        }
    }
}


extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! SectionHeader
            sectionHeader.label.text = sections[indexPath.section].nane
            sectionHeader.isHidden = sections[indexPath.section].images.count == 0
            return sectionHeader
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets.zero
        } else {
            return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 20.0, right: 0.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        return CGSize(width: collectionView.frame.width, height: 30)
    }
    
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return sections[section].images.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with:  sections[indexPath.section].images[indexPath.row])
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = sections[indexPath.section].images[indexPath.row]
        let previewViewController = PreviewViewController()
        previewViewController.image = image
        self.navigationController?.present(previewViewController, animated: true, completion: nil)
    }
}

extension SearchViewController: SearchViewModelDelegate {
    
    func viewModelStateChanged(state: State<SectionImage>) {
        switch state {
        case .show(let sectionImage):
            self.isLoading = false
            createSection(sectionImage)
        case .error(let error):
            self.isLoading = false
            self.alert(message: error.localizedDescription, title: "Hata", actionButtonTitle: "Kapat")
        case .loading:
            self.isLoading = true
        }
    }
    
    private func createSection(_ sectionImage: SectionImage?) {
        if sectionImage == nil {
            removeAllData()
            collectionView.reloadData()
            return
        }
        sections[sectionImage!.size.rawValue].images.append(sectionImage!.image)
        let indexPath = IndexPath(row: sections[sectionImage!.size.rawValue].images.count - 1, section: sectionImage!.size.rawValue)
        collectionView.insertItems(at: [indexPath])
    }
}
