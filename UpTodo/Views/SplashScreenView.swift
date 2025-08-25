//
//  SplashScreenView.swift
//  UpTodo
//
//  Created by Joel Ovienloba on 25/08/2025.
//


import SwiftUI
import SwiftData

struct SplashScreenView: View {
	@Environment(\.modelContext) private var modelContext

	var body: some View {
		NavigationStack{
			ZStack{
				Color.black
				
				VStack{
					Image("AppLogo")
					DelayedNavigationLink(delay: .seconds(5)) {
						OnboardingView(showOnboarding: .constant(true))
					}
				}
				
			}.ignoresSafeArea()
		}
		
	}
}


#Preview {
	SplashScreenView()
}
