//
//  ViewController.swift
//  UIKit_Combine
//
//  Created by 濱野遥斗 on 2024/06/09.
//

import UIKit
import Combine
import CombineCocoa

class ViewController: UIViewController {
    var subscriptions = Set<AnyCancellable>()
    
    private var viewModel: ViewModel?
    
    private var button: UIButton!
    private var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        let model = Model()
        viewModel = ViewModel(model: model)

        setUpView()
        bind()
    }
    
    private func setUpView() {
        button = UIButton()
        button.setTitle("button", for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        textField = UITextField()
        textField.textColor = .red
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        
        // Add constraints to position the button and textField
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -20),
            textField.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func bind() {
        guard let viewModel = viewModel else { return }

        button.tapPublisher
            .filter({ _ in
                self.textField.text != ""
            })
            .sink { [weak self] _ in
                print("tapped")
                viewModel.showValue()
            }
            .store(in: &subscriptions)
        
        textField.textPublisher
            .compactMap { $0 }
            .sink { [weak self] value in
                print("value:", value)
                self?.viewModel?.updateValue(value)
            }
            .store(in: &subscriptions)
        
        viewModel.$inputText
            .receive(on: DispatchQueue.main)  // UIの更新はメインスレッドで行う
            .sink { [weak self] value in
                print("model value:", value)
                self?.textField.text = value
            }
            .store(in: &subscriptions)
    }
}
