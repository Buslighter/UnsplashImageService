//
//  DetailedInfoViewController.swift
//  testTaskUnsplashAPI
//
//  Created by gleba on 30.04.2022.
//

import UIKit
import RealmSwift
// MARK: Function to format date to presentation style
public  func getNewFormattedDate(initialDate: String) -> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    let date = dateFormatter.date(from:initialDate)
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let finalDate = dateFormatter.string(from: date!)
    return finalDate
}

class DetailedInfoViewController: UIViewController {
    var likeIdenitifier: Bool?
    var realmSourceToDelete: PictureObject?
    var result: Result?
    var classResult: DeResult?
    var picImage: UIImage?
    var realm = try! Realm()
    var realmResults: Results<PictureObject>{
        get{return realm.objects(PictureObject.self)}
    }
    @IBOutlet var userName: UILabel!
    @IBOutlet var picture: UIImageView!
    @IBOutlet var libraryButton: UIButton!
    // MARK: Like button to like or dislike
    @IBAction func addRemoveFromLibrary(_ sender: Any) {
        if result != nil{
        DispatchQueue.main.async {
            self.checkLiked()
        }
        if likeIdenitifier==false{
            let items = PictureObject()
            try! self.realm.write{
                items.id = result?.id
                items.likes = "\(result?.likes ?? -100)"
                items.location = result?.user.location
                items.date = result?.created_at
                let data = picImage?.jpegData(compressionQuality: 0.9)
                items.view = data
                items.userName = result?.user.name
                self.realm.add(items)
            }
            likeIdenitifier=true
            
        } else{
            try! self.realm.write{
                self.realm.delete(realmSourceToDelete!)
                libraryButton.imageView?.image = UIImage(systemName: "heart")
            }
            likeIdenitifier=false
        }
        
        }else{
            if likeIdenitifier==false{
                libraryButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                let items = PictureObject()
                try! self.realm.write{
                    items.id = classResult?.realmObj?.id
                    items.likes = classResult?.realmObj?.likes
                    items.userName = classResult?.realmObj?.userName
                    items.location = classResult?.realmObj?.location
                    items.date = classResult?.realmObj?.date
                    items.view = classResult?.realmObj?.view
                    self.realm.add(items)
                }
            }
            else{
                let alert = UIAlertController(title: nil, message: "Delete photo from library?", preferredStyle: .actionSheet)
                let okButton = UIAlertAction(title: "Yes", style: .destructive){_ in
                    try! self.realm.write{
                        self.realm.delete((self.classResult?.realmObj)!)
                    }
                    self.navigationController?.popViewController(animated: true)
                }
                let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
                alert.addAction(okButton)
                alert.addAction(cancelButton)
                present(alert, animated: false, completion: nil)
            }
        }
        realm.refresh()
    }
    @IBOutlet var likesMetr: UILabel!
    @IBOutlet var location: UILabel!
    @IBOutlet var dateOfCreation: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: Check where it came from allphoto VC or favorites VC
        if result != nil{
            checkLiked()
            picture.image = picImage
            userName.text = result?.user.name
            likesMetr.text = "\(result?.likes ?? -100)"
            location.text = result?.user.location ?? "Unknown"
            dateOfCreation.text = getNewFormattedDate(initialDate: result?.created_at ?? "-100")
        }else{
            likeIdenitifier=true
            libraryButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            picture.image = picImage
            userName.text = classResult?.realmObj?.userName
            likesMetr.text = classResult?.realmObj?.likes ?? "-100"
            location.text = classResult?.realmObj?.location ?? "Unknown"
            dateOfCreation.text = getNewFormattedDate(initialDate: classResult?.realmObj?.date ?? "-100")
        }
        
    }
    // MARK: Check if this photo from favorite photos
    func checkLiked(){
        likeIdenitifier=false
        for i in realmResults{
            if i.id==result?.id{
                likeIdenitifier = true
                realmSourceToDelete = i
                libraryButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
        }
        if likeIdenitifier==false{
            libraryButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    
    
}


