//
//  SettingsViewModel.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 03.04.2024.
//

import RxSwift
import RxCocoa

final class SettingsViewModel {
	enum Route {
		case savedSizes
		case open(url: URL)
		case back
	}
	
	struct Input {
		let selectedItem: Signal<SettingItemsModel>
		let didTapBack: Signal<Void>
	}
	
	struct Output {
		let elements: Driver<[SettingItemsModel]>
		let route: Signal<Route>
	}
}

extension SettingsViewModel {
	func configure(input: Input) -> Output {
		
		let actionRoute = input.selectedItem
			.map { item -> Route in
				switch item {
				case .savedSizes:
					return .savedSizes
				case .termsOfUse:
					return .open(url: GlobalDefinitions.termsOfServiceUrl)
				case .privacyPolicy:
					return .open(url: GlobalDefinitions.privacyPolicyUrl)
				case .support:
					return .open(url: GlobalDefinitions.contactUsUrl)
				}
			}
		
		let route = Signal
			.merge(
				actionRoute,
				input.didTapBack.map { _ in .back }
			)
		
		return Output(
			elements: .just(SettingItemsModel.allCases),
			route: route
		)
	}
}
