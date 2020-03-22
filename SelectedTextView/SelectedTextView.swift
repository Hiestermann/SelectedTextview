import SwiftUI

struct SelectedTextView: UIViewControllerRepresentable {
    @Binding var keyboardHeight: CGFloat
    var selectedTextViewController = SelectedTextViewController()
    
    func makeCoordinator() -> SelectedTextView.Coordinator {
        let coordinator = Coordinator(self)
        return coordinator
    }
    
    class Coordinator: SelectedTextViewControllerDelegate {
        func keyboardHeightDidChange(height: CGFloat) {
           parent.keyboardHeight = height
        }
        
        var parent: SelectedTextView
        
        init(_ parent: SelectedTextView) {
            self.parent = parent
            parent.selectedTextViewController.delegate = self
        }
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SelectedTextView>) -> SelectedTextViewController {
        return selectedTextViewController
    }
    
    func updateUIViewController(_ uiViewController: SelectedTextViewController, context: UIViewControllerRepresentableContext<SelectedTextView>) {
        
    }
}

