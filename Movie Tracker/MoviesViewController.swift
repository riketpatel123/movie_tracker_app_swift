import UIKit


class MoviesViewController: UITableViewController {

    
    var movieStore: MovieStore!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieStore.movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get a new or recycled cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
        let movie = movieStore.movies[indexPath.row]
        
        // Configure the cell with the Item
        cell.textLabel?.text = movie.title
        // Configure ImageView base on rating
        switch movie.rating {
        case 1,2,3:
            cell.imageView?.image = UIImage(named: "red")
        case 4,5,6:
            cell.imageView?.image = UIImage(named: "yellow")
        case 7,8,9,10:
            cell.imageView?.image = UIImage(named: "green")
        default:
            cell.imageView?.image = UIImage(named: "blank")
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            let movie = movieStore.movies[indexPath.row]
            self.movieStore.removeMovie(movie)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func addNewMovie(_ sender: UIBarButtonItem) {
        // Create a new item and add it to the store
        movieStore.createMovie()
        
        // Determine where that item is in the array
        let indexPath = IndexPath(row: movieStore.movies.count - 1, section: 0)
        
        // Insert this new row into the table
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath) {
        // Update the model
        movieStore.moveMovie(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If the triggered segue is the "showItem" segue
        switch segue.identifier {
        case "showMovie"?:
            // Figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                // Get the item associated with this row and pass it along
                let movie = movieStore.movies[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.movie = movie
            }
        default:
            preconditionFailure("Unexepected segue identifier.")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
}

