//
//  ViewModel.swift
//  UIKit_Combine
//
//  Created by 濱野遥斗 on 2024/06/09.
//

import Foundation
import Combine
import CombineCocoa

final class ViewModel {
    private let model: Model
    var subscriptions = Set<AnyCancellable>()
    
    @Published var inputText: String = ""
    
    init(model: Model) {
        self.model = model
        
        model.$value
            .assign(to: &$inputText)
    }
    
    func updateValue(_ value: String) {
        model.setValue(value: value)
    }
    
    func showValue() {
        print(model.value)
    }
}
