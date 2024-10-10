//
//  SwipeView.swift
//  Tinder-Swipe-Mobile-Application
//
//  Created by Ephraim Sun on 10/10/24.
//

import SwiftUI

struct SwipeView: View {
    
    @State private var translation: CGSize = .zero
    @State private var questionIndex: Int = 0
    
    
    @State private var currentQuestionIndex = 0
    @State private var isSwipedLeft: Bool? = nil
    @State private var questions: [String] = [
        "Is technology ethically neutral?",
        "Should AI be regulated more strictly?",
        "Do you believe autonomous vehicles are safer than human drivers?",
        "Is data privacy more important than convenience?",
        "Should companies be allowed to collect user data without consent?",
        "Can social media cause more harm than good?",
        "Is the future of work fully remote?",
        "Should governments have more control over cryptocurrency?",
        "Will quantum computing revolutionize cybersecurity?",
        "Are tech companies responsible for preventing misinformation?",
        "Should AI systems be transparent in how they make decisions?",
        "Can automation lead to mass unemployment?",
        "Is the environmental impact of tech growth too high?",
        "Are digital currencies the future of money?",
        "Should ethical guidelines be mandated for tech development?",
        "Can facial recognition technology be used ethically?",
        "Should there be a global framework for AI development?",
        "Is AI art truly creative?",
        "Can AI systems replace human judgment in the legal system?",
        "Is Big Data more beneficial than it is harmful?",
        "Should tech companies be held accountable for the mental health impacts of their platforms?",
        "Are virtual reality experiences as valuable as real-world experiences?",
        "Will AI surpass human intelligence in the near future?",
        "Should users be compensated for their data?",
        "Can technology bridge the wealth gap?",
        "Will smart cities invade individual privacy?",
        "Is open-source software more secure than proprietary software?"
    ]
    @State private var gptResponse: String? = nil // Store GPT's response
    @State private var isLoadingGPT = false // Show a loading state when calling GPT
    
    var gptConnector = GPTConnector()

    var body: some View {
        VStack {
            Text("Swipe left for Disagree, right for Agree")
                .font(.headline)
                .padding()
            
            ZStack {
                if questionIndex < questions.count {
                    Text(questions[questionIndex])
                        .font(.title)
                        .frame(width: 300, height: 200)
                        .background(backgroundColor())
                        .cornerRadius(20)
                        .shadow(radius: 5)
                        .padding()
                        .offset(x: translation.width, y: 0)
                        .rotationEffect(.degrees(Double(translation.width / 10)))
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    translation = value.translation
                                }
                                .onEnded { value in
                                    if value.translation.width > 150 {
                                        // Swiped right (Agree)
                                        questionIndex += 1
                                    } else if value.translation.width < -150 {
                                        // Swiped left (Disagree)
                                        questionIndex += 1
                                    }
                                    // Reset translation
                                    translation = .zero
                                }
                        )
                } else {
                    Text("No more questions.")
                        .font(.title)
                }
            }
            
            // Buttons for Disagree, Agree, Neutral
            HStack {
                Button(action: {
                    // Handle left swipe (disagree)
                    isSwipedLeft = true
                    if questionIndex < questions.count {
                        questionIndex += 1
                    }
                }) {
                    Text("Disagree")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Spacer()
                
                Button(action: {
                    // Handle right swipe (agree)
                    isSwipedLeft = false
                    if questionIndex < questions.count {
                        questionIndex += 1
                    }
                }) {
                    Text("Agree")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Spacer()
                
                Button(action: {
                    // Handle neutral response
                    isSwipedLeft = nil
                    if questionIndex < questions.count {
                        questionIndex += 1
                    }
                }) {
                    Text("Neutral")
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()

            Spacer()

            // Show GPT's response if available
            if let gptResponse = gptResponse {
                Text(gptResponse)
                    .padding()
                    .multilineTextAlignment(.center)
                    .background(Color.yellow.opacity(0.2))
                    .cornerRadius(10)
            } else if isLoadingGPT {
                ProgressView("Asking GPT...")
                    .padding()
            }

            // Ask GPT Button
            Button(action: {
                askGPTQuestion()
            }) {
                Text("Ask GPT")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
        .padding()
    }

    // Function to go to the next question
    func nextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            currentQuestionIndex = 0 // Loop back to the first question
        }
        gptResponse = nil // Clear the GPT response when moving to the next question
    }

    // Call GPT API using the GPTConnector
    func askGPTQuestion() {
        isLoadingGPT = true
        let question = questions[currentQuestionIndex]
        
        gptConnector.askGPT(question: question) { response in
            DispatchQueue.main.async {
                self.isLoadingGPT = false
                self.gptResponse = response ?? "No response from GPT"
            }
        }
    }
    
    // Change the background color based on swipe direction
    func backgroundColor() -> Color {
        if translation.width > 0 {
            return Color.green.opacity(Double(translation.width) / 300)
        } else if translation.width < 0 {
            return Color.red.opacity(Double(-translation.width) / 300)
        } else {
            return Color.white
        }
    }
}

struct SwipeView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeView()
    }
}
