//
//  TattooGenerationView.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 14/07/2025.
//

import SwiftUI
struct MacTattooGenerationView: View{
    @State var prompt: String = ""
    var tattooStyle: TattooStyle
    @State var showToast = false
    @StateObject var processTattooViewModel: ProcessingTattooViewModel
    
    var body: some View{
        VStack{
            HStack{
                Image(tattooStyle.tattooStyleIcon).resizable()
                    .frame(width: 24, height: 24)
                    .scaledToFit()
                    .cornerRadius(AppRadius.small)
                
                Text(tattooStyle.tattooStyleName)
            }
            .padding()
            
            ZStack{
                TextEditor(text: $prompt)
                    .cornerRadius(AppRadius.small)
                
                    .overlay(
                        RoundedRectangle(cornerRadius: AppRadius.small)
                            .stroke(Colors.primary.opacity(0.1), lineWidth: 1)
                    )
            }
            .frame(width: 300, height: 120)
            
            Button(action: {
                if prompt.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                    showToast = true
                    return
                }
                
                processTattoo()
            }){
                Label("Generate Tattoo", systemImage: "moon.stars.fill")
            }.buttonStyle(PlainButtonStyle())
                .macPrimaryButtonStyle()
            
            Spacer()
        }
        .toast(isPresented: $showToast, message: "Enter your text", alignment: .center)
    }
    
    func processTattoo(){
        task{
            let updateTattooPrompt = """
        \(prompt)
        
        Rules:
        - Style: \(tattooStyle.tattooStyleName)
        - Output: Clear PNG background with transparent background
        - Content: Only the tattoo design itself; no human body parts or skin should be visible
        - Quality: High resolution suitable for tattoo artwork
        """
            
            
            let prompt = Prompt(requestID: UUID().uuidString, promptText: updateTattooPrompt, tattooStyle: tattooStyle.tattooStyleName, tattooDescription: tattooStyle.tattooDescription)
            
            do {
                try await processTattooViewModel.getTattooByPrompt(prompt: prompt)
                
            } catch {
                print("Failed to fetch tattoo: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    let processTattooViewModel = DependencyContainer.shared.makeProcessingTattooModel()
    MacTattooGenerationView(tattooStyle: TattooStyle(tattooStyleIcon: "tribal", tattooStyleName: "Tribal", tattooDescription: ""), processTattooViewModel: processTattooViewModel)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
}
