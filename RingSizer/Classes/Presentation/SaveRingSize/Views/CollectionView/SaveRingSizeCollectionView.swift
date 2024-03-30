//
//  SaveRingSizeCollectionView.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 28.03.2024.
//

import UIKit
import RxCocoa

extension SaveRingSizeCollectionView {
	
	struct Section: Hashable {
		let title: String
		let items: [SectionItem]
	}
	
	enum SectionItem: Hashable {
		case hand(Hand)
		case finger(Finger)
		case expandableHeader(String)
		case field
	}
}

class SaveRingSizeCollectionView: UICollectionView {
	
	let selectedFinger = BehaviorRelay<Finger?>(value: nil)
	let selectedHand = BehaviorRelay<Hand?>(value: nil)
	let ringName = BehaviorRelay<String>(value: "")
	
	lazy var saveRingDataSource = UICollectionViewDiffableDataSource<Section, SectionItem>(collectionView: self) { [weak self] collectionView, indexPath, item in
		switch item {
		case let .expandableHeader(title):
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ExpandableHeaderViewCell.self), for: indexPath) as! ExpandableHeaderViewCell
			cell.setup(title: title)
			return cell
		case let .hand(hand):
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RingSaveRadioButtonViewCell.self), for: indexPath) as! RingSaveRadioButtonViewCell
			let count = collectionView.numberOfItems(inSection: indexPath.section)
			cell.setup(title: hand.name, isLast: count - 1 == indexPath.row)
			return cell
		case let .finger(finger):
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RingSaveRadioButtonViewCell.self), for: indexPath) as! RingSaveRadioButtonViewCell
			let count = collectionView.numberOfItems(inSection: indexPath.section)
			cell.setup(title: finger.name, isLast: count - 1 == indexPath.row)
			return cell
		case .field:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SaveRingFieldViewCell.self), for: indexPath) as! SaveRingFieldViewCell
			cell.setup { [weak self] in self?.ringName.accept($0) }
			return cell
		}
	}
	
	override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
		super.init(frame: frame, collectionViewLayout: layout)
		initialize()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: Public
extension SaveRingSizeCollectionView {
	func setup(elements: [Section]) {
		elements.forEach { section in
			let snapshot = createSnapShot(for: section)
			saveRingDataSource.apply(snapshot, to: section)
		}
	}
	
	func setSelected(item: SectionItem) {
		if let indexPath = saveRingDataSource.indexPath(for: item) {
			selectItem(at: indexPath, animated: false, scrollPosition: .centeredVertically)
			selectModel(item: item)
		}
	}
}

// MARK: UICollectionViewDelegate
extension SaveRingSizeCollectionView: UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
		let item = saveRingDataSource.itemIdentifier(for: indexPath)!
		let section = saveRingDataSource.sectionIdentifier(for: indexPath.section)!
		var snapshot = saveRingDataSource.snapshot(for: section)
		
		switch item {
		case .expandableHeader:
			if snapshot.isExpanded(item) {
				snapshot.collapse([item])
			} else {
				snapshot.expand([item])
			}
			saveRingDataSource.apply(snapshot, to: section)
			
			return false
		case .hand, .finger:
			let selected = collectionView.indexPathsForSelectedItems ?? []
			let current = selected.filter { $0.section == indexPath.section }
			current.forEach { collectionView.deselectItem(at: $0, animated: true) }
			
			return true
		case .field:
			return false
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
		let selected = collectionView.indexPathsForSelectedItems ?? []
		let current = selected.filter { $0.section == indexPath.section }
		return current.isEmpty
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if let item = saveRingDataSource.itemIdentifier(for: indexPath) {
			selectModel(item: item)
		}
	}
}

// MARK: Private
private extension SaveRingSizeCollectionView {
	func initialize() {
		register(ExpandableHeaderViewCell.self, forCellWithReuseIdentifier: String(describing: ExpandableHeaderViewCell.self))
		register(RingSaveRadioButtonViewCell.self, forCellWithReuseIdentifier: String(describing: RingSaveRadioButtonViewCell.self))
		register(SaveRingFieldViewCell.self, forCellWithReuseIdentifier: String(describing: SaveRingFieldViewCell.self))
		register(RingSizeHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier:RingSizeHeaderView.reuseIdentifier)
		
		let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
			var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
			configuration.headerMode = .supplementary
			configuration.showsSeparators = false
			configuration.backgroundColor = Appearance.v4WarmBeige
			
			let section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnvironment)
			
			let headerSize = NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(1.0),
				heightDimension: .estimated(20)
			)
			let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
				layoutSize: headerSize,
				elementKind: UICollectionView.elementKindSectionHeader,
				alignment: .top
			)
			
			section.boundarySupplementaryItems = [sectionHeader]
			return section
		}
		
		collectionViewLayout = layout
		delegate = self
		allowsMultipleSelection = true
		backgroundColor = Appearance.v4WarmBeige
		keyboardDismissMode = .onDrag
		saveRingDataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
			guard kind == UICollectionView.elementKindSectionHeader else { return nil }
			
			let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RingSizeHeaderView.reuseIdentifier, for: indexPath) as? RingSizeHeaderView
			
			let section = self?.saveRingDataSource.sectionIdentifier(for: indexPath.section)
			
			view?.setup(title: section?.title ?? "")
			return view
		}
	}
	
	func createSnapShot(for section: Section) -> NSDiffableDataSourceSectionSnapshot<SectionItem> {
		var snapshot = NSDiffableDataSourceSectionSnapshot<SectionItem>()
		
		let headerItem = section.items.first(where: {
			guard case .expandableHeader = $0 else { return false }
			return true
		})
		
		if let headerItem {
			snapshot.append([headerItem])
			snapshot.expand([headerItem])
			snapshot.append(section.items.filter { $0 != headerItem }, to: headerItem)
		} else {
			snapshot.append(section.items)
		}
		
		return snapshot
	}
	
	func selectModel(item: SectionItem) {
		switch item {
		case let .finger(finger):
			selectedFinger.accept(finger)
		case let .hand(hand):
			selectedHand.accept(hand)
		case .expandableHeader, .field:
			break
		}
	}
}
