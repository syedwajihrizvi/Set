//
//  ContentView.swift
//  Set
//
//  Created by Wajih Rizvi on 2022-08-27.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var game: SetViewModel
    
    var body: some View {
        VStack {
            HStack {
                score
                Spacer()
                newGame
            }
            AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
                CardView(card: card).padding(4)
                    .onTapGesture {
                    game.choose(card: card)
                }
            })
                .foregroundColor(.red)
                .padding(5)
        addThreeMoreCards
        }
    }
    
    var score: some View {
        return Text("Score: 0")
            .padding(.leading)
    }
    
    var newGame: some View {
        return Button(action: {
            game.newGame()
        }, label: {
            VStack {
                Text("New")
                Text("Game")
            }
            .padding(.trailing)
        })
    }
    
    var addThreeMoreCards: some View {
        return Button(action: {
            game.addThreeMoreCards()
        }, label: {
            Text("Add 3 Cards")
        }).disabled(game.cards.count == 0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetViewModel()
        ContentView(game: game)
.previewInterfaceOrientation(.portrait)
    }
}

struct CardView: View {
    var card: SetModel<String>.Card
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack(alignment: .center, content:  {
                let shape = RoundedRectangle(cornerRadius: 10)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: 3)
                        .foregroundColor(.black)
                    HStack {
                        Spacer(minLength: spacerDistance(size: geometry.size, shape: "triangle"))
                        VStack {
                            ForEach(0...2, id: \.self) {_ in
//                                Rectangle(width: CGFloat(geometry.size.width*DrawingConstants.rectangleWidthToCardWidth), aspectRatio: CGFloat(5/2))
//                                Diamond(length: geometry.size.width*DrawingConstants.diamondWidthToCardWidth)
                                Triangle(width: geometry.size.width*DrawingConstants.triangleWidthToCardWidth)
                            }
                        }
                        .padding(.vertical)
                    }
                } else {
                    shape.fill(.red)
                }
            })
                
        })
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private func spacerDistance(size: CGSize, shape: String) -> CGFloat {
        switch shape {
        case "rectangle":
            return CGFloat(size.width*DrawingConstants.rectangleSpacerWidth)
        case "diamond":
            return CGFloat(size.width*DrawingConstants.diamondSpacerWidth)
        case "triangle":
            return CGFloat(size.width*DrawingConstants.triangleSpacerWidth)
        default:
            return 0.25
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.70
        static let rectangleWidthToCardWidth: CGFloat = 0.65
        static let rectangleSpacerWidth: CGFloat = 0.175
        static let diamondWidthToCardWidth: CGFloat = 0.5
        static let diamondSpacerWidth: CGFloat = 0.25
        static let triangleWidthToCardWidth: CGFloat = 0.4
        static let triangleSpacerWidth: CGFloat = 0.3
    }
}
