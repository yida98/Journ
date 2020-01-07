//
//  EntryView.swift
//  Journ
//
//  Created by Yida Zhang on 11/20/19.
//  Copyright © 2019 Yida Zhang. All rights reserved.
//

import SwiftUI
import Foundation
import UIKit

struct EntryView: View {
    
    @ObservedObject var entry: Entry
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage = UIImage()
    
    @State var cursorPosition: Int = 0
    
    init(entry: Entry) {
        self.entry = entry
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: CGFloat(15)) {
                timeView
                TextView(text: $entry.content, pos: $cursorPosition)
            }
            addImageButton
        }
    }
    
    func loadImage() {
//        let attachment = NSTextAttachment(image: inputImage)
//        let newAttStr = NSAttributedString(attachment: attachment)
//        let currText = entry.content
//        currText.insert(newAttStr, at: cursorPosition)
//        entry.content = currText
//        print(entry.content)
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
//        let nsmas = NSMutableAttributedString (string: "")
        
        return EntryView(entry: Entry(day: Date()))//, text: nsmas)
    }
}

extension EntryView {
    
    var timeView: some View {
        HStack {
            Text(entry.day.weekdayString())
            Text(entry.day.monthDayString())
        }
    }
    
    var addImageButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    self.showingImagePicker.toggle()
                }) {
                   Image(uiImage: UIImage(imageLiteralResourceName: "addImageK"))
                }
                .sheet(isPresented: $showingImagePicker) {
                    ImagePicker(isPresented: self.$showingImagePicker, image: self.$inputImage, closure: self.loadImage)//text: self.$text, pos: self.$cursorPosition)
                }
            }
        }
    }
}

struct TextView: UIViewRepresentable {
    @Binding var text: NSMutableAttributedString
    @Binding var pos: Int

    func makeUIView(context: Context) -> UITextView {
        let tv = UITextView()
        tv.font = NSMutableAttributedString.editorFont
        tv.textColor = SpecialColour.darkGrey
        tv.delegate = context.coordinator
        return tv
    }
    
    func makeCoordinator() -> TextView.Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate, UINavigationControllerDelegate {
        
        let parent: TextView
        
        init(parent: TextView) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = NSMutableAttributedString(attributedString: textView.attributedText)
            print("TEXAS CHAIN GIN")
        }
        
        func textViewDidChangeSelection(_ textView: UITextView) {
            
            if let range = textView.selectedTextRange {
                parent.pos = textView.offset(from: textView.beginningOfDocument, to: range.end)
                print(parent.pos)
            }
        }
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
    }
}

struct ImagePicker: UIViewControllerRepresentable {

    @Binding var isPresented: Bool
    @Binding var image: UIImage
//    @Binding var text: NSMutableAttributedString
//    @Binding var pos: Int
    
    var closure: () -> Void
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> ImagePicker.UIViewControllerType {
        let controller = UIImagePickerController()
        controller.delegate = context.coordinator
        return controller
    }
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                parent.image = selectedImage
//                let attachment = NSTextAttachment(image: selectedImage)
//                let newAttStr = NSAttributedString(attachment: attachment)
//                let currText = self.parent.text
//                currText.insert(newAttStr, at: parent.pos)
//                self.parent.text = currText
            }
            self.parent.isPresented = false
//            self.parent.text =
            self.parent.closure()
        }
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
}
