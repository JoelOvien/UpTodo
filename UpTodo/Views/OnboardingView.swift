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
		VStack{
			Spacer()
			
			HStack {
				Button("Skip") {
				}
				.foregroundColor(.gray).padding(.horizontal, 20)
				
				Spacer() // Pushes the button to the left
			}
			
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
					RoundedRectangle(cornerRadius: 56)
						.fill(
							index == currentPage ? Color.white : Color.white
								.opacity(0.87)
						)
						.frame(width: 26, height: 4)
						.scaleEffect(index == currentPage ? 1.2 : 1.0)
						.animation(.easeInOut(duration: 0.3), value: currentPage)
				}
			}
			.padding(.top, 50).padding(.bottom, 50)
			
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
			HStack() {
				if(currentPage < onboardingPages.count - 1)
				{
					Button("Skip") {
					}
					.foregroundColor(.gray).padding(.horizontal, 20)
				}else{
					Button("Back") {
						withAnimation{
							currentPage -= 1
						}
					}
					.foregroundColor(.gray).padding(.horizontal, 20)
				}
				
				Spacer()
				
				if currentPage < onboardingPages.count - 1 {
					// Next button
					Button(action: {
						withAnimation {
							currentPage += 1
						}
					}) {
						Text("NEXT")
							.font(.headline)
							.foregroundColor(.white)
							.frame(width: 90)
							.padding()
							.background(AppColors.primaryColor)
							.cornerRadius(4)
					}
					
				
				} else {
					// Get started button
					Button(action: {
						showOnboarding = false
			
					}) {
						Text("GET STARTED")
							.font(.headline)
							.foregroundColor(.white)
							.frame(width: 150)
							.padding()
							.background(AppColors.primaryColor)
							.cornerRadius(4)
					}
				}
			}
			.padding(.horizontal, 30)
			.padding(.bottom, 50)
			
		}.frame(maxWidth: .infinity, maxHeight: .infinity)
			.background(Color.black)
		
		
	}
}


struct OnboardingPageView: View {
	let page: OnboardingPage
	
	var body: some View {
		VStack(spacing: 42) {
			
			// Title
			Text(page.title)
				.foregroundColor(Color.white)
				.font(.largeTitle)
				.fontWeight(.bold)
				.multilineTextAlignment(.center)
				.padding(.horizontal, 30)
			
			// Description
			Text(page.description)
				.foregroundColor(Color.white)
				.font(.body)
				.multilineTextAlignment(.center)
				.padding(.horizontal, 40)
			
			Spacer()
		}
	}
}


#Preview {
	OnboardingView(showOnboarding: .constant(true))
}


