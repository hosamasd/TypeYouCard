//
//  CardView.swift
//  TypeYourCard
//
//  Created by Alexej Nenastev on 16.06.2019.
//  Copyright © 2019 Alexej Nenastev. All rights reserved.
//

import SwiftUI

fileprivate extension Animation {
    private static let rotateDuration:Double = 0.3
    
    static var cardHideDelayed: Animation {
        Animation.basic(duration: 0.001, curve: .linear).delay(rotateDuration/2)
    }
    
    static var rotateCard: Animation {
        Animation.basic(duration: rotateDuration, curve: .linear)
    }
}

fileprivate struct Logo: View {
    var body: some View {
        Text("LOGO")
    }
}

fileprivate struct FrontCardSide: View {
    @EnvironmentObject var payCard: PayCard
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Logo()
            }
            Spacer(minLength: 65)
            HStack {
                Text("XXXX")
                Spacer()
                Text("XXXX")
                Spacer()
                Text("XXXX")
                Spacer()
                Text("XXXX")
                }.font(Font.custom("CreditCard", size: 28))
                .foregroundColor(.white)
                .opacity(0.3)
            Spacer()
            HStack {
                VStack(alignment: .leading, spacing: 3) {
                    Text("CARDHOLDER NAME")
                        .font(Font.custom("Lucida Grande", size: 13))
                    Text("NAME SURNAME")
                        .opacity(0.3)
                        .font(Font.custom("CreditCard", size: 17))
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 3) {
                    Text("VALID THRU")
                        .font(Font.custom("Lucida Grande", size: 13))
                    Text("MM/YY")
                        .opacity(0.3)
                        .font(Font.custom("CreditCard", size: 17))
                }
                }
                .foregroundColor(Color.white)
        }.padding(20)
        .animation(.cardHideDelayed)
    }
}

fileprivate struct BackCardSide: View {
    @EnvironmentObject var payCard: PayCard

    var body: some View {
        VStack(spacing: 15) {
            Color.black.frame(height: 60)
                .padding([.leading, .trailing], -20)
                .padding(.top, 15)
            HStack {
                Color.gray.frame(width: 240, height: 40, alignment: .center)
                ZStack {
                    Color.white
                    Text("XXX").foregroundColor(.gray)
                        .font(Font.custom("CreditCard", size: 17))
                        .padding(.bottom, 3)
                }.frame(width: 40, height: 32)
                .cornerRadius(3)
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                Logo()
            }
        }.padding(20)
        .rotation3DEffect(.degrees(-180), axis: (x: 0, y: 1, z: 0))
        .animation(.cardHideDelayed)
    }
}

struct CardView : View {
    @EnvironmentObject var payCard: PayCard
    @State var isFront = true
    
    var body: some View {
        ZStack {
            BackCardSide().opacity(isFront ? 0 : 1)
            FrontCardSide().opacity(isFront ? 1 : 0)
        }
        .background(Color(red: 59/255, green: 58/255, blue: 61/255), cornerRadius: 16)
        .aspectRatio(1.46, contentMode: .fit)
        .shadow(radius: 10)
        .rotation3DEffect(.degrees(isFront ? 0 : -180), axis: (x: 0, y: 1, z: 0))
        .tapAction { withAnimation(.rotateCard) { self.isFront.toggle() } }
    }
}

#if DEBUG
struct CardView_Previews : PreviewProvider {
    static var previews: some View {
        CardView().padding(20).environmentObject(PayCard())
    }
}
#endif
