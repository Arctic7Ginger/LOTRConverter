//
//  SelectCurrency.swift
//  LOTRConverter
//
//  Created by Kaiser Hussain on 5/15/25.
//

import SwiftUI

struct SelectCurrency: View {
    @Environment(\.dismiss) var dismiss
    
    @State var leftCurrency: Currency
    @State var rightCurrency: Currency
    
    var body: some View {
    
        ZStack {
            // Parchment background image
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack {
                // Text
                Text("Select the currency you are starting with:")
                    .fontWeight(.bold)
                
                // Currency icons
                IconGrid(currency: leftCurrency)
                                    
                // Text
                Text("Select the currency you would like to convert to:")
                    .fontWeight(.bold)
                    .padding(.top)
                    
                // Currency icons
                IconGrid(currency: rightCurrency)
                
                // Done button
                Button("Done") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown.mix(with: .black, by: 0.2))
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.white)
                
            }
            .padding()
            .multilineTextAlignment(.center)
            .foregroundStyle(.black)
        }
    }
}

#Preview {
    SelectCurrency(leftCurrency: .silverPenny, rightCurrency: .goldPenny)
}
 
