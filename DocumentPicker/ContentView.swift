//
//  ContentView.swift
//  DocumentPicker
//
//  Created by Michele Manniello on 14/08/21.
//

import SwiftUI
import UniformTypeIdentifiers
import Firebase

struct ContentView: View {
    @State var show = false
    @State var alet = false
    var body: some View {
        Button(action: {
            self.show.toggle()
        }, label: {
               Text("Document Picker")
        })
        .sheet(isPresented: $show, content: {
            DocumentPicker(alert: $alet)
            
        })
        .alert(isPresented: $alet, content: {
            Alert(title: Text("Message"), message: Text("Upload successfully !!!"), dismissButton: .default(Text("OK")))
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
//document picker
struct DocumentPicker : UIViewControllerRepresentable {
    func makeCoordinator() -> DocumentPicker.Coordinator {
        return DocumentPicker.Coordinator(parent1: self)
    }
    @Binding var alert : Bool
   
    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController {
        let supportedTypes: [UTType] = [UTType.pdf]
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
        picker.allowsMultipleSelection = false
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<DocumentPicker>) {
        
    }
    class Coordinator: NSObject,UIDocumentPickerDelegate {
        var parent : DocumentPicker
        init(parent1: DocumentPicker) {
            parent = parent1
        }
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            let bucket = Storage.storage().reference()
            print((urls.first?.deletingPathExtension().lastPathComponent)!)
            bucket.child((urls.first?.deletingPathExtension().lastPathComponent)!).putFile(from: urls.first!, metadata: nil) { _, err in
                if err != nil{
                    print(err!.localizedDescription)
                    return
                }
                print("succes")
                self.parent.alert.toggle()
            }
        }
    }
}
