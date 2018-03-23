//
//  ViewController.swift
//  RxCollectionView
//
//  Created by 奥村晋太郎 on 2018/03/23.
//  Copyright © 2018年 奥村晋太郎. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController {

    @IBOutlet fileprivate weak var collectionView: UICollectionView!

    fileprivate let vm = ViewModel()
    fileprivate let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableViewDelegate()
        configure()
    }

}

extension ViewController {
    func configure() {
        bindCellItems()
        collcetionViewItemsSelected()
        collectionViewRegister()
    }

    func  bindCellItems() {
        vm.items
            .bind(to: collectionView.rx.items(cellIdentifier: "cell", cellType: CollectionViewCell.self)) { _, element, cell in
                cell.textLabel.text = element
            }
            .disposed(by: bag)
    }

    func collcetionViewItemsSelected() {
        collectionView
            .rx
            .itemSelected
            .subscribe(onNext: { [weak self] indexpath in
                guard let wself = self else { return }
                print(indexpath.row)
            })
            .disposed(by: bag)
    }

    func collectionViewRegister() {
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }

    func configureTableViewDelegate() {
        collectionView
            .rx
            .setDelegate(self)
            .disposed(by: bag)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }

    func  collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 194, height: 70)
    }

}

