//
//  Home.swift
//  BankingApp
//
//  Created by Justhateulol on 16/04/22.
//

import SwiftUI
import AVFoundation
import SweetCardScanner

struct Home: View {
    @State var GridOfCards: [ServiceCards] = [
        
        ServiceCards(hexValue: "HUMOPay", color: Color("DarkBlue")),
        ServiceCards(hexValue: "VISA Direct", color: Color("DarkBlue")),
        ServiceCards(hexValue: "My home", color: Color("Green")),
        ServiceCards(hexValue: "My cards", color: Color("Green")),
        ServiceCards(hexValue: "Currency exchange", color: Color("Orange")),
        ServiceCards(hexValue: "Deposit", color: Color("Orange")),
        ServiceCards(hexValue: "Loans", color: Color("White")),
        ServiceCards(hexValue: "Wallets", color: Color("Blue")),
        ServiceCards(hexValue: "", color: Color("Black")),

    ]
    
    @State var GridOfColors: [ColorCards] = [
        
        ColorCards(hexValue: "Dark Blue", color: Color("DarkBlue")),
        ColorCards(hexValue: "Blue", color: Color("Blue")),
        ColorCards(hexValue: "Orange", color: Color("Orange")),
        ColorCards(hexValue: "Green", color: Color("Green")),
        ColorCards(hexValue: "Purple", color: Color("Purple")),
        ColorCards(hexValue: "Black", color: Color("Black")),

    ]
    
    @State var selectedColor: Color = Color("Black")
    @State var data = ""
    @State var navigationStatus: NavigationStatus? = .ready
    @State var card: CreditCard?
    
    //Свойства анимации (вместо того чтобы писать для каждой анимации отдельный bool, делаю его массивом чтобы избежать многострочного кода)
    @State var animations: [Bool] = Array(repeating: false, count: 10)
    
    @Namespace var animation
    @State private var selection: String? = nil

    
    var body: some View {
        NavigationView{
        VStack{
            NavigationLink(destination: AddCard(), tag: "A", selection: $selection) { EmptyView() }
            HStack{
                Button {
                } label: {
                    Image("Profile")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                }
                Button { selection = "A"
                } label: {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.white)
                    Text("Add card")
                        .foregroundColor(.white)
                        .font(.title2)
                }
                .hLeading()
                Button {
                    
                } label: {
                    Image(systemName: "calendar")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                Button {
                    
                } label: {
                    Image(systemName: "bell")
                        .font(.title2)
                        .foregroundColor(.white)
                }

            }
            .padding([.horizontal, .top])
            .padding(.bottom, 5)

            //Использовал "Geometry Reader" для стартовой точки появления карты
            GeometryReader{ proxy in
                
                let maxY = proxy.frame(in: .global).maxY
                
                CreditCard()
                
                // Добавляем вращение
                    .rotation3DEffect(.init(degrees: animations[0] ? 0 : -270), axis: (x: 1, y: 0, z: 0), anchor: .center)
                    .offset(y: animations[0] ? 0: -maxY)
            }
            .frame(height: 250)
            
            HStack{
                Text("Services")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .hLeading()
                    .offset(x: animations[1] ? 0 : -200)
                Button{
                    
                } label: {
                    Text("View all")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .underline()
                }
                .offset(x: animations[1] ? 0 : 200)
            }
            .padding()
            
            
            TabView {
                GeometryReader{proxy in
                    
                    ZStack{
                        Color("Black")
                            .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 40))
                            .frame(height: animations[2] ? nil : 0)
                            .vBottom()
                        
                        ZStack{
                            ForEach(GridOfCards){cardsGrid in
                                
                                if !cardsGrid.removeFromView {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(cardsGrid.color)
                                        .frame(width: 150, height: animations[3] ? 150 : 150)
                                        .matchedGeometryEffect(id: cardsGrid.id, in: animation)
                                        .rotationEffect(.init(degrees: cardsGrid.rotateCards ? 180 : 0))
                                }
                            }
                            
                            ScrollView(.vertical, showsIndicators: false){
                                
                                let columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
                                LazyVGrid(columns: columns, spacing: 15){
                                    
                                    ForEach(GridOfCards){cardsGrid in
                                        
                                        GridCardView(cardsGrid: cardsGrid)


                                    }
                                }
                                .padding(.top, 40)
                            }
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                            .fill(Color("BG"))
                            .frame(width: 150, height: animations[3] ? 60 : 150)
                            .opacity(animations[3] ? 0 : 1)
                        )
                        .scaleEffect(animations[3] ? 1 : 2.3)
                    }
                    
                    .hCenter()
                    .VCenter()
                    .cornerRadius(40)
                }
                    .padding(.top)

                
                 .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                  }
                Text(data)
                nfcButton(data: self.$data)
                  .tabItem {
                     Image(systemName: "plus")
                     Text("NFC")
                   }
                GeometryReader{proxy in
                    
                    ZStack{
                        Color("Black")
                            .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 40))
                            .frame(height: animations[2] ? nil : 0)
                            .vBottom()
                        
                        ZStack{
                            ForEach(GridOfColors){colorGrid in
                                
                                if !colorGrid.removeFromView {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(colorGrid.color)
                                        .frame(width: 150, height: animations[3] ? 150 : 150)
                                        .matchedGeometryEffect(id: colorGrid.id, in: animation)
                                        .rotationEffect(.init(degrees: colorGrid.rotateCards ? 180 : 0))
                                }
                            }
                            
                            ScrollView(.vertical, showsIndicators: false){
                                
                                let columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
                                LazyVGrid(columns: columns, spacing: 15){
                                    
                                    ForEach(GridOfColors){colorGrid in
                                        
                                        GridOfColorsView(colorsGrid: colorGrid)


                                    }
                                }
                                .padding(.top, 40)
                            }
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                            .fill(Color("BG"))
                            .frame(width: 150, height: animations[3] ? 60 : 150)
                            .opacity(animations[3] ? 0 : 1)
                        )
                        .scaleEffect(animations[3] ? 1 : 2.3)
                    }
                    .hCenter()
                    .VCenter()
                    .cornerRadius(40)
                }
                    .padding(.top)

                
                  .tabItem {
                     Image(systemName: "paperplane")
                     Text("Cards")
                   }
                Text("Экран тех.поддержки")
                  .tabItem {
                     Image(systemName: "message")
                     Text("Chat")
                   }
                Text("Меню")
                  .tabItem {
                     Image(systemName: "square.grid.2x2")
                     Text("Menu")
                   }
            }
        }
        .vTop()
        .hCenter()
        .background(Color("BG"))
        .preferredColorScheme(.dark)
        .onAppear(perform: animateScreen)
        }
}
    
    // Вьюшка сетки карт
    
    @ViewBuilder
    func GridCardView(cardsGrid: ServiceCards) ->some View{
        VStack{
            if cardsGrid.addToGrid{
                //Если совпадает "Geometry effect"
                RoundedRectangle(cornerRadius: 10)
                    .fill(cardsGrid.color)
                    .frame(width: 150, height: 150)
                    .matchedGeometryEffect(id: cardsGrid.id, in: animation)
                    .onAppear{
                        if let index = GridOfCards.firstIndex(where: {color in
                            return color.id == cardsGrid.id
                        }){
                            withAnimation{
                                GridOfCards[index].showText = true
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.11) {
                                withAnimation{
                                    GridOfCards[index].removeFromView = true
                                }
                            }
                        }
                    }
            }
            else{
                RoundedRectangle(cornerRadius: 10)
                    .fill(.clear)
                    .frame(width: 150, height: 60)
            }
            Text(cardsGrid.hexValue)
                .font(.caption)
                .fontWeight(.light)
                .foregroundColor(.white)
                .hLeading()
                .padding([.horizontal, .top])
                .opacity(cardsGrid.showText ? 1 : 0)
        }
    }
    
    //View of color changing cards
    @ViewBuilder
    func GridOfColorsView(colorsGrid: ColorCards) ->some View{
        VStack{
            if colorsGrid.addToGrid{
                //Если совпадает "Geometry effect"
                RoundedRectangle(cornerRadius: 10)
                    .fill(colorsGrid.color)
                    .frame(width: 150, height: 150)
                    .matchedGeometryEffect(id: colorsGrid.id, in: animation)
                    .onAppear{
                        if let index = GridOfColors.firstIndex(where: {color in
                            return color.id == colorsGrid.id
                        }){
                            withAnimation{
                                GridOfColors[index].showText = true
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.11) {
                                withAnimation{
                                    GridOfColors[index].removeFromView = true
                                }
                            }
                        }
                    }
                    .onTapGesture {
                        withAnimation{
                            selectedColor = colorsGrid.color
                        }
                    }
            }
            else{
                RoundedRectangle(cornerRadius: 10)
                    .fill(.clear)
                    .frame(width: 150, height: 60)
            }
            Text(colorsGrid.hexValue)
                .font(.caption)
                .fontWeight(.light)
                .foregroundColor(.white)
                .hLeading()
                .padding([.horizontal, .top])
                .opacity(colorsGrid.showText ? 1 : 0)
        }
    }
    
    //Анимация экрана
    func animateScreen(){
        //Первая анимация "Появление карты"
        // добавил delay в анимации
        withAnimation(.interactiveSpring(response: 1.3, dampingFraction: 0.7, blendDuration: 0.7).delay(0.2)) {
            animations[0] = true
        }
        //Вторая анимация "Надписей под картой"
        withAnimation(.easeInOut(duration: 0.7).delay(0.7)){
            animations[1] = true
        }
        
        //Третья анимация "Анимация появления нижней панели"
        withAnimation(.interactiveSpring(response: 1.3, dampingFraction: 0.7, blendDuration: 0.7).delay(0.2)) {
            animations[2] = true
        }
        //Четвертая анимация "появление кнопки"
        withAnimation(.easeInOut(duration: 0.8)){
            animations[3] = true
        }
        //Пятая анимация "Появление всех кнопок"
        for index in GridOfCards.indices{
            //Чтобы анимация началась только после того как завершится прошлая анимация
            let delay: Double = (0.9 + (Double(index) * 0.1))
            
            let backIndex = ((GridOfCards.count - 1) - index)
            
            withAnimation(.easeInOut.delay(delay)){
                GridOfCards[backIndex].rotateCards = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay){
                
                withAnimation{
                    GridOfCards[backIndex].addToGrid = true
                }
            }
        }
        
        //6 анимация "Появление кнопок смены цвета карты"
        for index in GridOfColors.indices{
            //Чтобы анимация началась только после того как завершится прошлая анимация
            let delay: Double = (0.9 + (Double(index) * 0.1))
            
            let backIndex = ((GridOfColors.count - 1) - index)
            
            withAnimation(.easeInOut.delay(delay)){
                GridOfColors[backIndex].rotateCards = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay){
                
                withAnimation{
                    GridOfColors[backIndex].addToGrid = true
                }
            }
        }
    }
    
    @ViewBuilder
    func CreditCard()-> some View{
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(selectedColor)
            VStack{
                HStack{
                    ForEach(1...4, id: \.self){_ in
                        Circle()
                            .fill(.white)
                            .frame(width: 6, height: 6)
                    }
                    Text("5463")
                        .font(.callout)
                        .fontWeight(.semibold)
                }
                .hLeading()
                
                HStack (spacing: -12){
                    Text("MUYATDINOV ATABEK")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .hLeading()
                    
                    Circle()
                        .stroke(.white, lineWidth: 1)
                        .frame(width: 30, height: 30)
                    Circle()
                        .stroke(.white, lineWidth: 1)
                        .frame(width: 30, height: 30)
                }
                .vBottom()
            }
            .padding(.vertical, 20)
            .padding(.horizontal)
            .vTop()
            .hLeading()
            
// Дизайн карты
            Circle()
                .stroke(Color.white.opacity(0.5),lineWidth: 18)
                .offset(x: 130, y: -120)
        }
        .clipped()
        .padding()
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
 
extension View {
    
    func hLeading()->some View{
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func hTrailing()->some View{
        self
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    func hCenter()->some View{
        self
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
    func VCenter()->some View{
        self
            .frame(maxHeight: .infinity, alignment: .center)
    }
    
    func vTop()->some View{
        self
            .frame(maxHeight: .infinity, alignment: .top)
    }
    
    func vBottom()->some View{
        self
            .frame(maxHeight: .infinity, alignment: .bottom)
    }
}
