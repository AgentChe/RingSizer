//
//  MainCoordinatorMediator.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 03.04.2024.
//

import RxSwift
import RxCocoa

class MainCoordinatorMediator {
	static let shared = MainCoordinatorMediator()
	
	var selectedTab: Observable<TabView.Tab> {
		selectedTabRelay.asObservable()
	}
	
	private let selectedTabRelay = PublishRelay<TabView.Tab>()
	
	private init() {}
	
	func updateTab(tab: TabView.Tab) {
		selectedTabRelay.accept(tab)
	}
}
