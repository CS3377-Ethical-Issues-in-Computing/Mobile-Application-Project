//
//  AboutUsPage.swift
//  Tinder-Swipe-Mobile-Application
//
//  Created by Ephraim Sun on 10/10/24.
//

import SwiftUI

struct AboutUsPage: View {
    var body: some View {
        NavigationView {
            ScrollView {
                HStack(spacing: 20) {
                    // Column 1
                    VStack {
                        Image("advika_raj") // Replace with the actual image name
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                            .cornerRadius(10)
                        
                        Text("Advika Raj")
                            .font(.headline)
                        Text("Dallas, TX")
                        Text("Statistics & CS Minor")
                        Text("Senior Student")
                        Text("Interned in DC this summer")
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity) // Take equal space
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)

                    // Column 2
                    VStack {
                        Image("david_jensen") // Replace with the actual image name
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                            .cornerRadius(10)
                        
                        Text("David Jansen")
                            .font(.headline)
                        Text("Dallas, TX")
                        Text("Economics and CS Minor")
                        Text("Senior Student")
                        Text("Study Abroad")
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity) // Take equal space
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)

                    // Column 3
                    VStack {
                        Image("ephraim_sun") // Replace with the actual image name
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                            .cornerRadius(10)
                        
                        Text("Ephraim Sun")
                            .font(.headline)
                        Text("Dallas, TX")
                        Text("CS and Business Analytics")
                        Text("Junior")
                        Text("2x Amazon Intern ")
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity) // Take equal space
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("About Us")
        }
    }
}

struct AboutUsPage_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsPage()
    }
}
