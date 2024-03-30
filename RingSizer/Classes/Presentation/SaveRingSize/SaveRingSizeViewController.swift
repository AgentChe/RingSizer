//
//  SaveRingSizeViewController.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 28.03.2024.
//

import UIKit
import RxSwift
import RxCocoa

class SaveRingSizeViewController: UIViewController {
	
	lazy var mainView = SaveRingSizeView()
	private let viewModel: SaveRingSizeViewModel
	private let disposeBag = DisposeBag()
	
	private let initialFinger = Finger.thumb
	private let initialHand: Hand
	
	init(size: RingSize, system: MeasurementSystem, hand: Hand = .left) {
		self.viewModel = SaveRingSizeViewModel(size: size, measureSystem: system)
		self.initialHand = hand
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		view = mainView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		
		let output = viewModel.configure(input: .init(
			selectedFinger: mainView.collectionView.selectedFinger.compactMap { $0 },
			selectedHand: mainView.collectionView.selectedHand.compactMap { $0 }, 
			ringName: mainView.collectionView.ringName.asObservable(),
			didTapPrimary: mainView.primaryButton.rx.tap.asSignal()
		))
		
		output.dataSource
			.drive(with: mainView.collectionView) { $0.setup(elements: $1) }
			.disposed(by: disposeBag)
		
		Signal
			.merge(mainView.closeButton.rx.tap.asSignal(), output.closeSignal)
			.emit(with: self, onNext: { base, _ in base.dismiss(animated: true) })
			.disposed(by: disposeBag)
		
		mainView.collectionView.setSelected(item: .finger(initialFinger))
		mainView.collectionView.setSelected(item: .hand(initialHand))
		
    }
}

extension SaveRingSizeViewController {
	static func make(size: RingSize, system: MeasurementSystem) -> SaveRingSizeViewController {
		let vc = SaveRingSizeViewController(size: size, system: system)
		return vc
	}
}
