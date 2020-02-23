import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var titleField: UITextField!
    @IBOutlet var theatreField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var ratingField: UITextField!
    
    var movie: Movie!{
        didSet {
            if(movie.title.isEmpty){
                navigationItem.title = "New Movie"
            }else{
                navigationItem.title = movie.title
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        titleField.text = movie.title
        theatreField.text = movie.theatre
        datePicker.date = movie.viewedDate
        if movie.rating != nil {
            ratingField.text = String(movie.rating!)
        }
    }
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
view.endEditing(true)    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
        // "Save" changes to item
        movie.title = titleField.text ?? ""
        movie.theatre = theatreField.text ?? ""
        movie.viewedDate = datePicker.date
        
        if let ratingText = ratingField.text,let value =  Int(ratingText) {
            movie.rating = value
        } else {
            movie.rating = nil
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
