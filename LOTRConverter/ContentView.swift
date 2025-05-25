//
//  ContentView.swift
//  LOTRConverter
//
//  Created by Kaiser Hussain on 5/13/25.
//

import SwiftUI
import TipKit

struct ContentView: View {
    
    // Stored properties
    @State var showExchangeInfo = false
    @State var showSelectCurrency = false
    
    @State var leftAmount = ""
    @State var rightAmount = ""
    
    @FocusState var leftTyping
    @FocusState var rightTyping
    
    @State var leftCurrency  = Currency.silverPiece
    @State var rightCurrency: Currency = .goldPiece
    
    let currencyTip = CurrencyTip()
    
    var body: some View {
        ZStack {
            // Background image
            Image(.background)
                .resizable()
                .ignoresSafeArea()
            VStack {
                // Prancing Pony image
                Image(.prancingpony)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                // Currency Exchange Text
                Text("Currency Exchange")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                // Conversion section
                    // Left converstion section
                HStack{
                    VStack {
                        // Currency
                        HStack {
                            // Currency Image
                            Image(leftCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 33)
                            
                            // Currency Text
                            Text(leftCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                            
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                            currencyTip.invalidate(reason: .actionPerformed)
                        }
                        .popoverTip(currencyTip, arrowEdge: .bottom)
                        
                        // Text field
                        // Bind property to view
                        TextField("Amount", text: $leftAmount)
                            .textFieldStyle(.roundedBorder)
                            .focused($leftTyping)
                    }
                    
                    // Equal sign
                    Image(systemName: "equal")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .symbolEffect(.pulse)
                    
                    // Right converstion section≤
                    VStack {
                        // Currency
                        HStack {
                            // Currency Text
                            Text(rightCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                            
                            // Currency Image
                            Image(rightCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 33)
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                            currencyTip.invalidate(reason: .actionPerformed)
                        }
                        
                        // Text field
                        // Bind property to view
                        TextField("Amount", text: $rightAmount)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.trailing)
                            .focused($rightTyping)
                    }
                }
                .padding()
                .background(.black.opacity(0.5))
                .clipShape(.capsule)
                .keyboardType(.decimalPad)
                
                Spacer()
                
                // Info button
                HStack {
                    Spacer()
                    
                    Button {
                        showExchangeInfo.toggle()
                        // print("showExchangeInfo value: \(showExchangeInfo)")
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                    }
                    .padding(.trailing)
                }
            }
//            .border(.blue)
        }
        
        .task {
            try? Tips.configure()
        }
        
        .onChange(of: leftAmount) {
            if leftTyping {
                rightAmount = leftCurrency.convert(leftAmount, to:
                                                    rightCurrency)
            }
            
        }
        
        .onChange(of: rightAmount) {
            if rightTyping {
                leftAmount = rightCurrency
                    .convert(rightAmount, to:
                                leftCurrency)
            }
        }
        
        .onChange(of: leftCurrency) {
            leftAmount = rightCurrency
                .convert(rightAmount, to:
                            leftCurrency)
        }
        
        .onChange(of: rightCurrency) {
            rightAmount = leftCurrency
                .convert(leftAmount, to:
                            rightCurrency)
        }
        
        .sheet(isPresented: $showExchangeInfo) {
            ExchangeInfo()
        }
        .sheet(isPresented: $showSelectCurrency) {
            SelectCurrency(topCurrency: $leftCurrency,
            bottomCurrency: $rightCurrency)
        }
    }
}

#Preview {
    ContentView()
}
