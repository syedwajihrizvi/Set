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
                .padding(5)
        addThreeMoreCards
        }
    }
    
    var score: some View {
        return Text("Score: " + String(game.score))
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
            .foregroundColor(.black)
        })
    }
    
    var addThreeMoreCards: some View {
        return Button(action: {
            game.addThreeMoreCards()
        }, label: {
            Text("Deal 3 More Cards").foregroundColor(.black)
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
    var card: SetModel<SetCardContent>.Card
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack(alignment: .center, content:  {
                let shape = RoundedRectangle(cornerRadius: 10)
                    shape.fill().foregroundColor(.white)
                    if card.isMatch {
                        shape.strokeBorder(lineWidth: 8)
                            .foregroundColor(.purple)
                    }
                    else if card.isSelected {
                        shape.strokeBorder(lineWidth: 5)
                            .foregroundColor(.pink)
                    } else {
                        shape.strokeBorder(lineWidth: 3)
                            .foregroundColor(.black)
                    }
                    HStack {
                        Spacer(minLength: spacerDistance(size: geometry.size,
                                                         shape: card.content.shape))
                        VStack {
                            ForEach(0..<card.content.number, id: \.self) {_ in
                                if (card.content.shape == "rectangle") {
                                    let shape = Rectangle(width: CGFloat(geometry.size.width*DrawingConstants.rectangleWidthToCardWidth),
                                                                                              aspectRatio: CGFloat(5/2))
                                    if (card.content.shading == 0) {
                                        shape.stroke(card.content.color)
                                    } else {
                                        shape.fill(card.content.color).opacity(card.content.shading)
                                    }
                                    
                                } else if (card.content.shape == "triangle"){
                                    let shape = Triangle(width: geometry.size.width*DrawingConstants.triangleWidthToCardWidth)
                                    if (card.content.shading == 0) {
                                        shape.stroke(card.content.color)
                                    } else {
                                        shape.fill(card.content.color).opacity(card.content.shading)
                                    }
                                } else {
                                    let shape = Diamond(length: geometry.size.width*DrawingConstants.diamondWidthToCardWidth)
                                    if (card.content.shading == 0) {
                                        shape.stroke(card.content.color)
                                    } else {
                                        shape.fill(card.content.color).opacity(card.content.shading)
                                    }
                                }

                            }
                        }
                        .padding(.vertical)
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
        static let diamondWidthToCardWidth: CGFloat = 0.4
        static let diamondSpacerWidth: CGFloat = 0.3
        static let triangleWidthToCardWidth: CGFloat = 0.35
        static let triangleSpacerWidth: CGFloat = 0.275
    }
}
