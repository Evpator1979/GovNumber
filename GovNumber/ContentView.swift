//
//  ContentView.swift
//  GovNumber
//
//  Created by Dmitry Averin on 26.09.2023.
//

import SwiftUI
import Combine





struct ContentView: View {
    
    
    
    @State private var govnumber = ""
    @State private var firstCharacter: Character = " "
    @State private var secondCharacter: Character = " "
    @State private var thirdCharacter: Character = " "
    @State private var fourthCharacter: Character = " "
    
    @State private var resultText = ""
    
    
    
    
    var body: some View {
        
        VStack {
            Spacer()
            Text("GovNumber 👮")
                .font(.system(size: 45))
                .fontWeight(.bold)
                .foregroundStyle(Color.green)
                .padding()
            Spacer()
            Rectangle()
                .fill(Color.white)
                .frame(width: 280, height: 80)
                .overlay(
                    Rectangle()
                        .stroke(Color.black, lineWidth: 10)
                        .frame(width: 280, height: 80)
                        .padding()
                )
            
            
                .overlay(
                    HStack(spacing: 0){
                        VStack{
                            
                            ZStack(alignment: .topLeading){
                                Image("ukraine_flag")
                                
                                    .resizable()
                                    .frame(width: 20, height: 70)
                                    .padding(.leading, 5 )
                                
                                
                            }
                            
                        }
                        
                        Spacer()
                            .frame(width: 15)
                        Text("AA")
                            .font(.largeTitle)
                        
                        Spacer()
                        Text("\(govnumber)")
                            .font(.largeTitle)
                        
                        
                        Spacer()
                        Text("AA")
                            .font(.largeTitle)
                        
                        Spacer()
                        
                    })
            
            
                .cornerRadius(8)
                .shadow(radius: 10)
            
            
            
            TextField("Enter ONLY 4 digits...", text: $govnumber)
                .padding()
                .font(.largeTitle)
                .border(Color.blue, width: 4)
                .keyboardType(.numberPad)//у пользователя появляется только цифровая клавиатура
                .onReceive(Just(govnumber)) { newValue in //делает ввод не более чем 4 цифры
                    let filtered = newValue.filter { $0.isNumber }
                    if filtered.count > 4 {
                        govnumber = String(filtered.prefix(4))
                    } else {
                        govnumber = filtered
                    }
                    if govnumber.count >= 4 {
                        firstCharacter = govnumber[govnumber.index(govnumber.startIndex, offsetBy: 0)]
                        secondCharacter = govnumber[govnumber.index(govnumber.startIndex, offsetBy: 1)]
                        thirdCharacter = govnumber[govnumber.index(govnumber.startIndex, offsetBy: 2)]
                        fourthCharacter = govnumber[govnumber.index(govnumber.startIndex, offsetBy: 3)]
                    }
                }
            Spacer()
            
            Button(action: {
                if govnumber.count == 4 {
                    if firstCharacter == secondCharacter && secondCharacter == thirdCharacter && firstCharacter == fourthCharacter && fourthCharacter != "0"{
                        print("все четыре цифры равны")
                        resultText = "36 тыс грн"
                        return
                    }
                    if firstCharacter == secondCharacter && secondCharacter == thirdCharacter && firstCharacter == fourthCharacter && fourthCharacter == "0"{
                        print("Такого номерного знака не существует!")
                        resultText = "Такого номерного знака не существует"
                        
                        
                        return
                    }
                    if firstCharacter == "0" && secondCharacter == "0" && thirdCharacter == "0" && fourthCharacter != "0"{
                        print("номер начинается с трех нулей")
                        resultText = "36 тыс грн"
                        return
                    }
                    if firstCharacter == "0" && secondCharacter == "0" && thirdCharacter != "0" && fourthCharacter != "0" && thirdCharacter == fourthCharacter{
                        print("номер начинается с двух нулей,далее цифры одинаковые")
                        resultText = "12 тыс грн"
                        return
                    }
                    if firstCharacter == "0" && secondCharacter == "0" && thirdCharacter != "0" && fourthCharacter != "0" && thirdCharacter != fourthCharacter{
                        print("номер начинается с двух нулей,далее цифры неодинаковые")
                        resultText = "9600 грн"
                        return
                    }
                    if firstCharacter == secondCharacter && secondCharacter == thirdCharacter || secondCharacter == thirdCharacter && thirdCharacter == fourthCharacter {
                        print("одинаковые три цифры подряд")
                        resultText = "12 тыс грн"
                        return
                    }
                    if firstCharacter == secondCharacter && thirdCharacter == fourthCharacter{
                        print("первая и вторая цифры одинаковы и третья и четвертая тоже")
                        resultText = "12 тыс грн"
                        return
                    }
                    if firstCharacter == "0" && secondCharacter == "1" && thirdCharacter == "2" && fourthCharacter == "3" || firstCharacter == "1" && secondCharacter == "2" && thirdCharacter == "3" && fourthCharacter == "4" {
                        print("номера 0123 или 1234")
                        resultText = "12 тыс грн"
                        return
                    }
                    if firstCharacter == fourthCharacter && secondCharacter == thirdCharacter || firstCharacter == thirdCharacter && secondCharacter == fourthCharacter || firstCharacter == thirdCharacter && thirdCharacter == fourthCharacter || firstCharacter == secondCharacter && firstCharacter == fourthCharacter{
                        print("комбинации XYYX,XYXY,XYXX,XXYX")
                        resultText = "4800 грн"
                        return
                        
                        
                    }else{
                        print("Это обычный номерной знак")
                        resultText = "Это обычный номер 🤷‍♂️ "
                        
                        return
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                }
            }) {
                
                Text(resultText)
                    .font(.largeTitle)
                    .padding()
                Spacer()
                
                Text("Cost")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                
                    .padding()
            }
        }
        .padding()
    }
    
    
    
}

#Preview {
    ContentView()
}


