//
//  FigsGridCell.swift
//  Brickie
//
//  Created by Leo on 29/11/2020.
//  Copyright © 2020 Homework. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
struct FigsGridCell: View {
    @EnvironmentObject private var  store : Store
    
    @ObservedObject var minifig : LegoMinifig
    @Environment(\.dataCache) var cache : DataCache
        
    var body: some View {
        VStack(){
            ZStack(alignment: .bottomTrailing){
                makeImage()
//                VStack(alignment: .trailing){
//                    HStack{
//                        Spacer()
//                        Text(minifig.nameUI).minimumScaleFactor(0.5).font(.headline).lineLimit(3).multilineTextAlignment(.center)
//                        Spacer()
//                    }
//                }.background(Blur(style: .prominent))
                PastilView(owned: minifig.ownedTotal, wanted:  minifig.wanted)


            }//.frame(height: 200)
            .modifier(RoundedShadowMod())
           // Spacer()
            Text(minifig.nameUI).minimumScaleFactor(0.5).font(.headline).lineLimit(3).multilineTextAlignment(.center)
            
//            if minifig.subNames.first != nil {
                Text(" "+minifig.minifigNumber.uppercased()+" ").font(.lego(size: 14))//.foregroundColor(.gray)
//            }
            Spacer()
            
        }
            .contextMenu{
                Button("menu") {
                    print("hello")
                }
            }
    }
    
    func makeImage() -> some View{
        WebImage(url: URL(string:minifig.imageUrl))
            .resizable()
            .renderingMode(.original)
            .indicator(.activity)
            .transition(.fade)
            .aspectRatio(contentMode: .fill)
            .frame(width:150,height: 225)
            .background(Color.white)
        
    }
}

