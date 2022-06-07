//
//  FavoritesViewController.swift
//  testTaskUnsplashAPI
//
//  Created by gleba on 30.04.2022.
//

import UIKit
import RealmSwift
class FavoritesViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var realm = try! Realm()
    var realmResults: Results<PictureObject>{
        get{return realm.objects(PictureObject.self)}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm.refresh()
        tableView.reloadData()
       
    }
    //SEGUE TO INFO
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell, let index = tableView.indexPath(for: cell){
            tableView.deselectRow(at: index, animated: true)
            let items = realmResults[index.row]
            if let vc = segue.destination as? DetailedInfoViewController, segue.identifier == "segueFromTV"{
                let result = DeResult()
                result.realmObj = items
                vc.picImage = UIImage(data: items.view!)
                vc.classResult = result
            }
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
               super.viewWillAppear(animated)
               tableView.dataSource = self
               tableView.delegate = self
               tableView.reloadData()
//        NotificationCenter.default.post(name: Notification.Name(rawValue: "getData"), object: nil)
       }
    

}
extension FavoritesViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realmResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell") as! FavoriteTableViewCell
        let items = realmResults
        let item = items[indexPath.row]
        cell.authorNameLabel.text = item.userName
        cell.photoView.image = UIImage(data: item.view!)
        return cell
    }
    

}

