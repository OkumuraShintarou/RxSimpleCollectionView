//
//  ViewModel.swift
//  RxCollectionView
//
//  Created by 奥村晋太郎 on 2018/03/23.
//  Copyright © 2018年 奥村晋太郎. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class ViewModel {
    var items = BehaviorRelay(value: [String]())

    init() {
        items.accept(["iPhoneX","iPhone8Plus", "iPhone8", "iPhone7Plus"])
    }
}
