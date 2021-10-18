//
//  CardView.swift
//  SpacedRepetition
//
//  Created by Jeremy Stein on 10/15/21.
//

import SwiftUI

struct CardView: View {
    var card: Model.Card
    
    @State var answerHidden: Bool = true
    @State private var justLoaded = false
    @State var rotation = 0.0
    @State var contentRotation = 0.0
    
    
    var body: some View {
        ZStack {
            if answerHidden == true {
                questionCard
            } else {
                answerCard
            }
        }
        .onTapGesture {
            flipCard()
        }
        .rotation3DEffect(.degrees(contentRotation), axis: (x: 0, y: 1, z: 0))
        .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
    }
    
    var questionCard: some View {
        VStack {
            Text("Question")
                .multilineTextAlignment(.center)
            ScrollView {
                Text(card.question)
                    .multilineTextAlignment(.leading)
            }
            .modifier(InnerCardTextModifier())

        }
        .id(card.id)
        .modifier(OuterCardTextModifier(color: Color.blue))
    }
    
    var answerCard: some View {
        VStack {
            Text("Answer")
                .multilineTextAlignment(.center)
            ScrollView {
                Text(card.answer)
                    .multilineTextAlignment(.leading)
            }
            .modifier(InnerCardTextModifier())
            
        }
        .id(card.id)
        .modifier(OuterCardTextModifier(color: Color.green))
    }
    
    
    func flipCard() {
        withAnimation(.easeInOut(duration: CONSTANTS.animationTime)) {
            rotation += 180
        }
        withAnimation(Animation.linear(duration: 0.0001).delay(CONSTANTS.animationTime / 2)) {
            contentRotation += 180
            answerHidden.toggle()
        }
    }
    
    
    struct InnerCardTextModifier: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .padding()
                .background(Color.white)
                .cornerRadius(CONSTANTS.cornerRadius)
                
        }
    }
    
    struct OuterCardTextModifier: ViewModifier {
        let color: Color
        
        func body(content: Content) -> some View {
            return content
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .padding()
                .background(color)
                .cornerRadius(CONSTANTS.cornerRadius * 1.5)
                .padding()
        }
    }
    
    struct CONSTANTS {
        static let cornerRadius: CGFloat = 20
        static let animationTime: Double = 0.25
    }
}








//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(card: ViewModel.currentCard)
//    }
//}
