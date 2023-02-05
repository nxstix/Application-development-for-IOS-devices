//
//  ContentView.swift
//  PraefixRechner
//
//  Created by Anastasia Hanna Ougolnikova on 21.10.22.
//

import SwiftUI

struct ContentView: View {
    @State var displayNum = 0
    @State var displayProsses = ""
    @State var safeSpaceMC = ""
    @State var firstNum = ""
    @State var secondNum = ""
    @State var firstOrSecondCheck = false
    @State var operatorsCheck = false
    @State var operatorsSave = ""
    @State var minusOrPlus = false
    let buttons = [
        ["C", "MC", "MP", "÷"],
        ["7", "8", "9", "*"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", "↵", "+/-", "="]
    ]
    var body: some View {
        VStack {
            HStack{
            Spacer()
            Text("\(displayNum)")
                .padding()
                .foregroundColor(.white)
                .font(.system(size: 80))
                .lineLimit(1)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            HStack{
                Spacer()
                Text(displayProsses)
                    .padding()
                    .foregroundColor(.white)
                    .font(.system(size: 35))
                    .lineLimit(1)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            ForEach(buttons, id: \.self) { row in
                HStack{
                    ForEach(row, id: \.self) { column in
                        Button(action: {buttonUse(column: column)}, label: {
                            Text(column)
                                .frame(idealWidth: 100, maxWidth: .infinity, idealHeight: 100, maxHeight: .infinity,
                                       alignment: .center)
                                .font(.system(size: 35))
                        })
                        .foregroundColor(buttonColor(column))
                    }
                }
            }
        }
        .background(.black)
    }
    
    func buttonColor(_ column: String) -> Color{
        if column == "÷" || column == "*" || column == "+" || column == "-" {
            return .orange
        }
        if column == "C" || column == "MC" || column == "MP" || column == "↵" || column == "+/-" {
            return .yellow
        }
        if column == "=" {
            return .white
        }
        return .gray
    }
    
    func buttonUse(column: String){
        switch column {
        case "C":
            displayNum = 0
            displayProsses = ""
            firstNum = ""
            secondNum = ""
            firstOrSecondCheck = false
            operatorsCheck = false
            operatorsSave = ""
            minusOrPlus = false
        case "MC":
            safeSpaceMC = "\(displayNum)"
        case "MP":
            displayProsses = safeSpaceMC
            if firstOrSecondCheck == false {
                firstNum = safeSpaceMC
            } else {
                secondNum = safeSpaceMC
            }
        case "↵":
            firstOrSecondCheck = true
            displayProsses = firstNum + " " + operatorsSave + " "
            minusOrPlus = false
        case "+/-":
            if minusOrPlus == false {
                if firstOrSecondCheck == false {
                    firstNum = "-" + firstNum
                    displayProsses = firstNum
                    minusOrPlus = true
                } else {
                    secondNum = "-" + secondNum
                    displayProsses = firstNum + " " + operatorsSave + " " + secondNum
                    minusOrPlus = true
                }
            } else {
                if firstOrSecondCheck == false {
                    firstNum = String(firstNum.dropFirst())
                    displayProsses = firstNum
                    minusOrPlus = false
                } else {
                    secondNum = String(secondNum.dropFirst())
                    displayProsses = firstNum + " " + operatorsSave + " " + secondNum
                    minusOrPlus = false
                }
            }
        case "÷", "*", "+", "-":
            displayNum = 0
            firstNum = ""
            secondNum = ""
            operatorsSave = ""
            if operatorsCheck == false {
                if column == "÷" || column == "*" || column == "+" || column == "-" {
                    displayProsses = column
                    operatorsSave = column
                    operatorsCheck = true
                }
            } else {
                if column == "÷" || column == "*" || column == "+" || column == "-" {
                    displayProsses.removeLast()
                    displayProsses = column
                    operatorsSave = column
                    operatorsCheck = true
                }
            }
        case "=":
            displayProsses = firstNum + " " + operatorsSave + " " + secondNum
            displayNum = calculate()
            firstOrSecondCheck = false
            operatorsCheck = false
            minusOrPlus = false
        default:
            if operatorsCheck == true{
                if displayProsses.last == "÷" || displayProsses.last == "*" || displayProsses.last == "+" || displayProsses.last == "-" {
                    displayProsses.removeLast()
                    if firstOrSecondCheck == false {
                        firstNum += column
                        displayProsses = firstNum
                    } else {
                        secondNum += column
                        displayProsses = firstNum + " " + operatorsSave + " " + secondNum
                    }
                } else {
                    if firstOrSecondCheck == false {
                        firstNum += column
                        displayProsses = firstNum
                    } else {
                        secondNum += column
                        displayProsses = firstNum + " " + operatorsSave + " " + secondNum
                    }
                }
            }
        }
    }
    
    func calculate() -> Int {
        let process = displayProsses.replacingOccurrences(of: "÷", with: "/")
        let expression = NSExpression(format: process)
        let result = expression.expressionValue(with: nil, context: nil) as? Double
        return Int(round(result!))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
