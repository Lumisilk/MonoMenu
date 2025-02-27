//
//  UIKitExample.swift
//  Example
//
//  Created by lumisilk on 2025/02/19.
//

import SwiftUI
import MonoMenu

class UIKitExample: UIViewController {
    
    private let button: UIButton = {
        var config = UIButton.Configuration.borderedProminent()
        config.title = "Tap or Drag Me"
        let button = UIButton(configuration: config)
        return button
    }()
    
    private let styleSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Popover", "Dialog"])
        control.selectedSegmentIndex = 0
        return control
    }()
    
    private let collectionView: UICollectionView = {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.titleView = styleSegmentedControl
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(button)
        button.sizeToFit()
        button.center = view.center
        view.bringSubviewToFront(button)
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        button.addGestureRecognizer(panGesture)
    }
    
    private func setupCollectionView() {
        collectionView.register(UICollectionViewListCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.dataSource = self
    }
    
    @objc private func buttonTapped() {
        let monoMenu: MonoMenuProtocol = styleSegmentedControl.selectedSegmentIndex == 0 ? .popover(sourceView: button) : .dialog
        let menuVC = UIHostingController(rootView: menuContent)
        menuVC.monoMenu = monoMenu
        present(menuVC, animated: true)
    }

    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        guard let buttonView = gesture.view else { return }
        buttonView.center = CGPoint(x: buttonView.center.x + translation.x, y: buttonView.center.y + translation.y)
        gesture.setTranslation(.zero, in: view)
    }
    
    private var menuContent: some View {
        List {
            ForEach(0..<5) { index in
                Text("Item \(index)")
            }
        }
    }
}

extension UIKitExample: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! UICollectionViewListCell
        var config = cell.defaultContentConfiguration()
        config.text = "Item \(indexPath.row)"
        cell.contentConfiguration = config
        return cell
    }
}

#Preview {
    UINavigationController(rootViewController: UIKitExample())
}
