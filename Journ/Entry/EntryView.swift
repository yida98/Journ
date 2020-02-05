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
    @ObservedObject var entryViewModel: EntryViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage = UIImage()
    
    @State var cursorPosition: Int = 0
    
    init(entry: Entry, entryViewModel: EntryViewModel) {
        self.entry = entry
        self.entryViewModel = entryViewModel
    }
    
    var body: some View {
        
        let tapToResign = TapGesture()
            .onEnded({ (value) in
                self.endEditing()
            })
        
        return ZStack {
            VStack(alignment: .leading, spacing: CGFloat(15)) {
                timeView
                .gesture( tapToResign )
                TextView(text: $entry.content, pos: $cursorPosition)
                    .onTapGesture {
                        // TODO: Block too much
                }
            }
                .padding(40)
            addImageButton
        }.onDisappear(perform: {
            self.entryViewModel.addEntry(entry: self.entry)
        })
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
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
        
        return EntryView(entry: Entry(day: Date()), entryViewModel: EntryViewModel())//, text: nsmas)
    }
}

extension EntryView {
    
    var timeView: some View {
        VStack(alignment: .leading) {
            Text(entry.day.weekdayString())
                .font(Font.weekdayFont)
                .foregroundColor(SpecialColor.darkGrey)
            
            Text(entry.day.monthDayString())
                .font(Font.monthDayFont)
                .foregroundColor(SpecialColor.yellow)
        }
    }
    
    var addImageButton: some View {
//        VStack {
//            Button(action:{
//                self.presentationMode.wrappedValue.dismiss()
//            }) {
//                Image(uiImage: UIImage(imageLiteralResourceName: "addImageK"))
//            }
//
//        }
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

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
