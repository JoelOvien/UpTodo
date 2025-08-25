//
//  DelayedNavigationLink.swift
//  UpTodo
//
//  Created by Joel Ovienloba on 25/08/2025.
//

import SwiftUI
import SwiftData

struct DelayedNavigationLink<Destination: View, Label: View>: View {
	@State private var linkIsActive = false

	private let delay: DispatchTimeInterval
	private var destination: () -> Destination
	private var label: () -> Label

	init(delay: DispatchTimeInterval, destination: @escaping () -> Destination) where Label == EmptyView {
		self.init(delay: delay, destination: destination, label: EmptyView.init)
	}

	init(delay: DispatchTimeInterval, destination: @escaping () -> Destination, label: @escaping () -> Label) {
		self.delay = delay
		self.destination = destination
		self.label = label
	}

	var body: some View {
		NavigationLink(
			isActive: $linkIsActive,
			destination: label,
			label: label
		)
			.onAppear {
				DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
					linkIsActive = true
				}
			}
	}
}
