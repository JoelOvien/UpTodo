//
//  OnboardingView.swift
//  UpTodo
//
//  Created by Joel Ovienloba on 25/08/2025.
//


import SwiftUI


struct OnboardingView: View {
	@Environment(\.modelContext) private var modelContext
	@State private var currentPage = 0
	@Binding var showOnboarding: Bool
	
	let onboardingPages = [
		OnboardingPage(
			image: "OnboardingOne",
			title: "Manage your tasks",
			description: "You can easily manage all of your daily tasks in DoMe for free"
		),
		OnboardingPage(
			image: "OnboardingTwo",
			title: "Create daily routine",
			description: "In Uptodo  you can create your personalized routine to stay productive"
		),
		OnboardingPage(
			image: "OnboardingThree",
			title: "Organize your tasks",
			description: "You can organize your daily tasks by adding your tasks into separate categories"
		)
	]

	var body: some View {
		ZStack{
			Color.black

			VStack{
				Spacer()

				// TabView for swipeable image
						  TabView(selection: $currentPage) {
							  ForEach(0..<onboardingPages.count, id: \.self) { index in
								  Image(onboardingPages[index].image)
								
							  }
						  }
						  .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
						  .animation(.easeInOut, value: currentPage)
				
				
				HStack {
							   ForEach(0..<onboardingPages.count, id: \.self) { index in
								   Circle()
									   .fill(index == currentPage ? Color.blue : Color.gray.opacity(0.3))
									   .frame(width: 8, height: 8)
									   .scaleEffect(index == currentPage ? 1.2 : 1.0)
									   .animation(.easeInOut(duration: 0.3), value: currentPage)
							   }
						   }
						   .padding(.top, 50)
				
				// TabView for swipeable pages
						  TabView(selection: $currentPage) {
							  ForEach(0..<onboardingPages.count, id: \.self) { index in
								  OnboardingPageView(page: onboardingPages[index])
									  .tag(index)
							  }
						  }
						  .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
						  .animation(.easeInOut, value: currentPage)
				
				
				// Bottom buttons
						   HStack(spacing: 20) {
							   if currentPage < onboardingPages.count - 1 {
								   // Next button
								   Button(action: {
									   withAnimation {
										   currentPage += 1
									   }
								   }) {
									   Text("Next")
										   .font(.headline)
										   .foregroundColor(.white)
										   .frame(maxWidth: .infinity)
										   .padding()
										   .background(Color.blue)
										   .cornerRadius(12)
								   }
								   
								   // Skip button
								   Button("Skip") {
									   showOnboarding = false
								   }
								   .foregroundColor(.gray)
							   } else {
								   // Get started button
								   Button(action: {
									   showOnboarding = false
								   }) {
									   Text("Get Started")
										   .font(.headline)
										   .foregroundColor(.white)
										   .frame(maxWidth: .infinity)
										   .padding()
										   .background(Color.blue)
										   .cornerRadius(12)
								   }
							   }
						   }
						   .padding(.horizontal, 30)
						   .padding(.bottom, 50)
			}
		}.ignoresSafeArea()
	}
}


struct OnboardingPageView: View {
	let page: OnboardingPage
	
	var body: some View {
		VStack(spacing: 30) {
			// Title
			Text(page.title)
				.font(.largeTitle)
				.fontWeight(.bold)
				.multilineTextAlignment(.center)
				.padding(.horizontal, 30)
			
			// Description
			Text(page.description)
				.font(.body)
				.foregroundColor(.secondary)
				.multilineTextAlignment(.center)
				.padding(.horizontal, 40)
			
			Spacer()
		}
	}
}


#Preview {
	OnboardingView(showOnboarding: .constant(true))
}


