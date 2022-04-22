////
////  Home.swift
////  BankingApp
////
////  Created by Justhateulol on 16/04/22.
////
//
//import SwiftUI
//
//struct Home: View {
//    @State var colors: [ColorGrid] = [
//        
//    ColorGrid(hexValue: "HUMOPay", color: Color("White")),
//    ColorGrid(hexValue: "VISA Direct", color: Color("White")),
//    ColorGrid(hexValue: "My home", color: Color("White")),
//    ColorGrid(hexValue: "My cards", color: Color("White")),
//    ColorGrid(hexValue: "Currency exchange", color: Color("White")),
//    ColorGrid(hexValue: "Deposit", color: Color("White")),
//    ColorGrid(hexValue: "Loans", color: Color("White")),
//    ColorGrid(hexValue: "Wallets", color: Color("White")),
//
//    ]
//    
//    //Свойства анимации (вместо того чтобы писать для каждой анимации отдельный bool, делаю его массивом чтобы избежать многострочного кода)
//    @State var animations: [Bool] = Array(repeating: false, count: 10)
//    
//    @Namespace var animation
//
//    
//    var body: some View {
//        VStack{
//            
//            HStack{
//               
//                Button {
//                    
//                } label: {
//                    Image("Profile")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 45, height: 45)
//                        .clipShape(Circle())
//                }
//                .hLeading()
//                Button {
//                    
//                } label: {
//                    Image(systemName: "calendar")
//                        .font(.title2)
//                        .foregroundColor(.white)
//                }
//                Button {
//                    
//                } label: {
//                    Image(systemName: "bell")
//                        .font(.title2)
//                        .foregroundColor(.white)
//                }
//            }
//            .padding([.horizontal, .top])
//            .padding(.bottom, 5)
//
//            //Использовал "Geometry Reader" для стартовой точки появления карты
//            GeometryReader{ proxy in
//                
//                let maxY = proxy.frame(in: .global).maxY
//                
//                CreditCard()
//                
//                // Добавляем вращение
//                    .rotation3DEffect(.init(degrees: animations[0] ? 0 : -270), axis: (x: 1, y: 0, z: 0), anchor: .center)
//                    .offset(y: animations[0] ? 0: -maxY)
//            }
//            
//            HStack{
//                Text("Services")
//                    .font(.title3)
//                    .fontWeight(.semibold)
//                    .hLeading()
//                    .offset(x: animations[1] ? 0 : -200)
//                Button{
//                    
//                } label: {
//                    Text("View all")
//                        .font(.callout)
//                        .fontWeight(.semibold)
//                        .foregroundColor(Color.white)
//                        .underline()
//                }
//                .offset(x: animations[1] ? 0 : 200)
//            }
//            .padding()
//            
//            GeometryReader{proxy in
//                
//                let size = proxy.size
//                
//                ZStack{
//                    
//                    Color("BG")
//                        .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 40))
//                        .frame(height: animations[2] ? nil : 0)
//                        .vBottom()
//                    
//                    ZStack{
//                        ForEach(colors){colorGrid in
//                            
//                            if !colorGrid.removeFromView {
//                                
//                                RoundedRectangle(cornerRadius: 10)
//                                    .fill(colorGrid.color)
//                                    .frame(width: 150, height: animations[3] ? 60 : 150)
//                                    .matchedGeometryEffect(id: colorGrid.id, in: animation)
//                                    .rotationEffect(.init(degrees: colorGrid.rotateCards ? 180 : 0))
//                            }
//                        }
//                    }
//                                        .overlay(
//                                            RoundedRectangle(cornerRadius: 10)
//                                            .fill(Color("BG"))
//                                            .frame(width: 150, height: animations[3] ? 60 : 150)
//                                            .opacity(animations[3] ? 0 : 1)
//                                        )
//                                        .scaleEffect(animations[3] ? 1 : 2.3)
//                                    }
//                                    
//                                    .hCenter()
//                                    .VCenter()
//                                    
//                                    
//                                    ScrollView(.vertical, showsIndicators: false){
//                                        
//                                        let columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
//                                        LazyVGrid(columns: columns, spacing: 15){
//                                            
//                                            ForEach(colors){colorGrid in
//                                                
//                                                GridCardView(colorGrid: colorGrid)
//
//                                            }
//                                        }
//                                        .padding(.top, 40)
//                                    }
//                                    .cornerRadius(40)
//                                }
//                                    .padding(.top)
//                                
//                                TabView {
//                                   Text("")
//                                     .tabItem {
//                                        Image(systemName: "house")
//                                        Text("Home")
//                                      }
//                                    Text("Здесь будет экран с переводами")
//                                      .tabItem {
//                                         Image(systemName: "paperplane")
//                                         Text("Transfer")
//                                       }
//                                    Text("Экран оплаты")
//                                      .tabItem {
//                                         Image(systemName: "plus")
//                                         Text("Payment")
//                                       }
//                                    Text("Экран тех.поддержки")
//                                      .tabItem {
//                                         Image(systemName: "message")
//                                         Text("Chat")
//                                       }
//                                    Text("Меню")
//                                      .tabItem {
//                                         Image(systemName: "square.grid.2x2")
//                                         Text("Menu")
//                                       }
//                                }
//
//                            }
//                            .vTop()
//                            .hCenter()
//                            .background(Color("BG"))
//                            .preferredColorScheme(.dark)
//                            .onAppear(perform: animateScreen)
//                        }
//                        
//                        //вьюшка сетки карт
//                        
//                        @ViewBuilder
//                        func GridCardView(colorGrid: ColorGrid) ->some View{
//                            VStack{
//                                if colorGrid.addToGrid{
//                                    //Если совпадает "Geometrt effect"
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .fill(colorGrid.color)
//                                        .frame(width: 150, height: 60)
//                                        .matchedGeometryEffect(id: colorGrid.id, in: animation)
//                                        .onAppear{
//                                            if let index = colors.firstIndex(where: {color in
//                                                return color.id == colorGrid.id
//                                            }){
//                                                withAnimation{
//                                                    colors[index].showText = true
//                                                }
//                                                
//                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.11) {
//                                                    withAnimation{
//                                                        colors[index].removeFromView = true
//                                                    }
//                                                }
//                                            }
//                                        }
//                                }
//                                else{
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .fill(.clear)
//                                        .frame(width: 150, height: 60)
//                                }
//                                Text(colorGrid.hexValue)
//                                    .font(.caption)
//                                    .fontWeight(.light)
//                                    .foregroundColor(.white)
//                                    .hLeading()
//                                    .padding([.horizontal, .top])
//                                    .opacity(colorGrid.showText ? 1 : 0)
//                            }
//                        }
//                        
//                        //Анимация экрана
//                        func animateScreen(){
//                            //Первая анимация "Появление карты"
//                            // добавил delay в анимации
//                            withAnimation(.interactiveSpring(response: 1.3, dampingFraction: 0.7, blendDuration: 0.7).delay(0.2)) {
//                                animations[0] = true
//                            }
//                            //Вторая анимация "Надписей под картой"
//                            withAnimation(.easeInOut(duration: 0.7).delay(0.7)){
//                                animations[1] = true
//                            }
//                            
//                            //Третья анимация "Анимация появления нижней панели"
//                            withAnimation(.interactiveSpring(response: 1.3, dampingFraction: 0.7, blendDuration: 0.7).delay(0.2)) {
//                                animations[2] = true
//                            }
//                            //Четвертая анимация "появление кнопки"
//                            withAnimation(.easeInOut(duration: 0.8)){
//                                animations[3] = true
//                            }
//                            //Пятая анимация "Появление всех кнопок"
//                            for index in colors.indices{
//                                //Чтобы анимация началась только после того как завершится прошлая анимация
//                                let delay: Double = (0.9 + (Double(index) * 0.1))
//                                
//                                let backIndex = ((colors.count - 1) - index)
//                                
//                                withAnimation(.easeInOut.delay(delay)){
//                                    colors[backIndex].rotateCards = true
//                                }
//                                
//                                DispatchQueue.main.asyncAfter(deadline: .now() + delay){
//                                    
//                                    withAnimation{
//                                        colors[backIndex].addToGrid = true
//                                    }
//                                }
//                            }
//                        }
//                        
//                        @ViewBuilder
//                        func CreditCard()-> some View{
//                            ZStack{
//                                RoundedRectangle(cornerRadius: 20)
//                                    .fill(Color("Black"))
//                                VStack{
//                                    HStack{
//                                        ForEach(1...4, id: \.self){_ in
//                                            Circle()
//                                                .fill(.white)
//                                                .frame(width: 6, height: 6)
//                                        }
//                                        Text("5463")
//                                            .font(.callout)
//                                            .fontWeight(.semibold)
//                                    }
//                                    .hLeading()
//                                    
//                                    HStack (spacing: -12){
//                                        Text("MUYATDINOV ATABEK")
//                                            .font(.title3)
//                                            .fontWeight(.semibold)
//                                            .hLeading()
//                                        
//                                        Circle()
//                                            .stroke(.white, lineWidth: 1)
//                                            .frame(width: 30, height: 30)
//                                        Circle()
//                                            .stroke(.white, lineWidth: 1)
//                                            .frame(width: 30, height: 30)
//                                    }
//                                    .vBottom()
//                                }
//                                .padding(.vertical, 20)
//                                .padding(.horizontal)
//                                .vTop()
//                                .hLeading()
//                                
//                    // Дизайн карты
//                                Circle()
//                                    .stroke(Color.white.opacity(0.5),lineWidth: 18)
//                                    .offset(x: 130, y: -120)
//                            }
//                            .clipped()
//                            .padding()
//                        }
//                    }
//
//                    struct Home_Previews: PreviewProvider {
//                        static var previews: some View {
//                            Home()
//                        }
//                    }
//                     
//                    extension View {
//                        
//                        func hLeading()->some View{
//                            self
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                        }
//                        
//                        func hTrailing()->some View{
//                            self
//                                .frame(maxWidth: .infinity, alignment: .trailing)
//                        }
//                        
//                        func hCenter()->some View{
//                            self
//                                .frame(maxWidth: .infinity, alignment: .center)
//                        }
//                        
//                        func VCenter()->some View{
//                            self
//                                .frame(maxHeight: .infinity, alignment: .center)
//                        }
//                        
//                        func vTop()->some View{
//                            self
//                                .frame(maxHeight: .infinity, alignment: .top)
//                        }
//                        
//                        func vBottom()->some View{
//                            self
//                                .frame(maxHeight: .infinity, alignment: .bottom)
//                        }
//                    }
