//
//  MessageView.swift
//  mobile
//
//  Created by Gary Tokman on 5/13/24.
//

import MessageUI
import SwiftUI
import UIKit

public struct MessageItem: Identifiable, Equatable {
    public var id = UUID()
    public var recipients: [String]
    public var body: String
}

@available(iOS 17.0, *)
struct MessageView: UIViewControllerRepresentable {
    typealias Completion = (_ messageSent: Bool) -> Void

    static var canSendText: Bool { MFMessageComposeViewController.canSendText() }
        
    let item: MessageItem
    let completion: Completion?
    
    func makeUIViewController(context: Context) -> UIViewController {
        guard Self.canSendText else {
            let errorView = MessagesUnavailableView()
            return UIHostingController(rootView: errorView)
        }
        
        let controller = MFMessageComposeViewController()
        controller.messageComposeDelegate = context.coordinator
        controller.recipients = item.recipients
        controller.body = item.body
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(completion: self.completion)
    }
    
    class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        private let completion: Completion?

        public init(completion: Completion?) {
            self.completion = completion
        }
        
        public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            controller.dismiss(animated: true, completion: nil)
            completion?(result == .sent)
        }
    }
}

@available(iOS 17.0, *)
struct MessagesUnavailableView: View {
    var body: some View {
        ContentUnavailableView(
            "Messages Not Supported",
            systemImage: "message.fill",
            description: Text("Switch to a device that has messages.")
        )
    }
}

@available(iOS 17.0, *)
public extension View {
    /// Presents a message composer view for sending a text message.
    ///
    /// - Parameters:
    ///   - recipients: An array of phone numbers to which the message should be sent.
    ///   - body: The body of the message to be sent.
    ///   - completion: A closure that is called with a boolean value indicating whether the message was sent successfully.
    @ViewBuilder
    func sheet(message item: Binding<MessageItem?>, completion: @escaping (Bool) -> Void) -> some View {
        if MFMessageComposeViewController.canSendText() {
            sheet(item: item) { item in
                MessageView(item: item, completion: completion)
                    .ignoresSafeArea()
            }
        } else {
            MessagesUnavailableView()
        }
    }
}
