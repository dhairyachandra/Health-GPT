//
//  ContentView.swift
//  HealthGPT
//
//  Created by Dhairya Chandra on 3/15/23.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State var chatMessage: [ChatMessage] = []
    @State var messageText: String = ""
    let openAIService = OpenAIService()
    @State var cancellables = Set <AnyCancellable>()
    var body: some View {
        VStack{
            if chatMessage.isEmpty {
                Text("Welcome to Health GPT!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding()
                Text("HealthGPT is an innovative app that utilizes the power of GPT-3.5 language model to answer health-related questions. This app allows users to ask any health-related question they may have, and the advanced AI system will provide them with accurate and reliable answers. With HealthGPT, users can get instant access to credible health information without the need to consult a doctor or conduct lengthy research.")
                    .font(.body)
                    .foregroundColor(.gray)
                    
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                ScrollView{
                    LazyVStack {
                        ForEach(chatMessage, id: \.id) { message in
                            messageView(message: message)
                        }
                    }
                }
            }
            Spacer()
            HStack{
                Button {
                    clearMessages()
                } label: {
                    Text("Clear")
                        .foregroundColor(.white)
                        .padding()
                        .background(.red)
                        .cornerRadius(12)
                }
                TextField("Ask Health GPT!", text: $messageText){
                    
                }
                    .padding()
                    .background(.gray.opacity(0.1))
                    .cornerRadius(12)
                Button {
                    sendMessage()
                    
                } label: {
                    Text("Send")
                        .foregroundColor(.white)
                        .padding()
                        .background(.black)
                        .cornerRadius(12)
                }
            }
            
        }
        .padding()
        
        
    }

    func clearMessages() {
        chatMessage.removeAll()
    }
    func messageView(message: ChatMessage) -> some View{
        HStack{
            if message.sender == .Me {Spacer()}
            Text(message.content)
                .foregroundColor(message.sender == .Me ? .white : .black)
                .padding()
                .background(message.sender == .Me ? .blue : .gray.opacity(0.1))
                .cornerRadius(16)
            if message.sender == .HealthGPT {Spacer() }
        }
    }
    func sendMessage(){
        let myMessage = ChatMessage(id: UUID().uuidString, content: messageText, dateCreated: Date(), sender: .Me)
        chatMessage.append(myMessage)
        openAIService.sendMessage(message: messageText).sink { completion in
            //
        } receiveValue: { response in
            guard let textResponse = response.choices.first?.text.trimmingCharacters(in: .whitespacesAndNewlines.union(.init(charactersIn: "\""))) else {return}
            let gptMessage = ChatMessage(id: response.id, content: textResponse, dateCreated: Date(), sender: .HealthGPT)
            chatMessage.append(gptMessage)
            
        }
        .store(in: &cancellables)

        messageText = ""
       
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ChatMessage {
    let id: String
    let content: String
    let dateCreated: Date
    let sender: MessageSender
}

enum MessageSender {
    case Me
    case HealthGPT
}

