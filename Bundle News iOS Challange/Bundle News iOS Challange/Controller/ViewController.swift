//
//  ViewController.swift
//  Bundle News iOS Challange
//
//  Created by MrDark on 15.02.2020.
//  Copyright © 2020 MrDark. All rights reserved.
//

import UIKit
import KFSwiftImageLoader
import PKHUD
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet var bundleTableView: UITableView!

    // MARK: Properties

    private let nibCellName = "BundleProductTableViewCell"
    private let cellIdentifier = "bundleCell"
    private let headerHeight: CGFloat = 150.0
    private let bundleViewModel: BundleProductViewModel = BundleProductViewModel()
    private var bundleHeaderView: BundleHeaderView?
    private let refreshControl = UIRefreshControl()
    private let disposeBag = DisposeBag()


    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: Create TableView 

        initializeTableView()

    }

    func initializeTableView()
    {

        // MARK: Register Cell

        bundleTableView.register(UINib(nibName: nibCellName, bundle: nil), forCellReuseIdentifier: cellIdentifier)

        self.bundleTableView.delegate = self

        // MARK: Create TableView HeaderView

        self.bundleHeaderView = UIView.fromNib()


        // MARK: Bind Data

        bindData()

    }

    func bindData()
    {
        bundleViewModel.getProducts().bind(to: bundleTableView
            .rx
            .items(cellIdentifier: cellIdentifier, cellType: BundleProductTableViewCell.self)) { row, element, cell in
                cell.productNameTextLabel.text = element.name
                cell.priceLabel.text = element.price
                cell.categoryTextLabel.text = element.category
                cell.productImageView.loadImage(url: URL(string: element.image)!)
                cell.productDetailButton.rx.tap
                    .subscribe({ _ in
                        let detailViewController = self.storyboard?.instantiateViewController(identifier: "detailViewController") as! DetailViewController
                        detailViewController.detailCategoryNameString = element.category
                        detailViewController.detailProductNameString = element.name
                        detailViewController.detailPriceString = element.price
                        detailViewController.detailImageUrlString = element.image

                        self.navigationController?.pushViewController(detailViewController, animated: true)




                    }).disposed(by: self.disposeBag)

        }
        .disposed(by: disposeBag)

        // MARK: Selected TableViewCell

        Observable
            .zip(bundleTableView.rx.itemSelected, bundleTableView.rx.modelSelected(BundleProductModel.self))
            .bind { [unowned self] indexPath, model in
                self.bundleTableView.deselectRow(at: indexPath, animated: true)
        }
        .disposed(by: disposeBag)

        HUD.hide()

    }
}


extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.bundleHeaderView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }

}


