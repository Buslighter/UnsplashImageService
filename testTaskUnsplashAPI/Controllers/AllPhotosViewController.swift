//
//  AllPhotosViewController.swift
//  testTaskUnsplashAPI
//
//  Created by gleba on 30.04.2022.
//

import UIKit

class AllPhotosViewController: UIViewController {
    
    @IBOutlet var searchTextField: UITextField!
    var results: Answer?
    var images = [UIImage]()
    @IBOutlet var collectionView: UICollectionView!
//    @objc func getData(_ notification: Notification){
//        writeData(searchText: "random",numberOfPictures: 30)
//    }
    // MARK: Function to call parse func and write data in results
    public func writeData(searchText: String,numberOfPictures: Int){
        var urls = [String]()
        Parse().getData(searchText: searchText,numberOfPictures: numberOfPictures, completion: {results in
            if self.results != nil {
                self.results?.results = results.results
            }else{self.results = results}
            urls = results.results.map{$0.urls.regular}
            print("data got")
            DispatchQueue.main.async {
                let imagesToApppend:[UIImage] = urls.map{
                    var myImage=UIImage()
                    let url = URL(string: $0 )
                    if let data = try? Data(contentsOf: url!){myImage = UIImage(data: data)! }
                    return myImage
                }
                self.images = imagesToApppend
                self.collectionView?.reloadData()
            }
            
        })
    }
    // MARK: Search elements
    @IBAction func searchButton(_ sender: Any) {
        if searchTextField.text != nil{
            let query = searchTextField.text
        writeData(searchText:  query!, numberOfPictures: 6)
            collectionView.reloadData()
        }
        searchTextField.resignFirstResponder()
    }
    @IBAction func searchTextFieldAction(_ sender: Any) {
        if searchTextField.text != nil{
            let query = searchTextField.text
        writeData(searchText:  query!, numberOfPictures: 6)
            collectionView.reloadData()
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchTextField.resignFirstResponder()
    }
    
    
    override func viewDidLoad() {
        writeData(searchText: "random",numberOfPictures: 10)
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
////        NotificationCenter.default.addObserver(self, selector: #selector(getData(_:)), name: Notification.Name(rawValue: "getData"), object: nil)
//    }
    // MARK: Segue to detailed info VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UICollectionViewCell, let index = collectionView.indexPath(for: cell){
            collectionView.deselectItem(at: index, animated: true)
            let model = results?.results[index.row]
            if let vc = segue.destination as? DetailedInfoViewController, segue.identifier == "segueFromCV"{
                vc.picImage = images[index.row]
                vc.result = model
            }
        }
        
    }
}
extension AllPhotosViewController:UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (results?.results.count ?? 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameCV = collectionView.frame
        let w = frameCV.width/2
        let h = w
        return CGSize(width: w-5, height:  h)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "allPhotosCell", for: indexPath) as! AllPhotosCollectionViewCell
        cell.imageView.image = images[indexPath.row]
        return cell
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        for cell in collectionView.visibleCells{
            let indexPath = collectionView.indexPath(for: cell)
            if indexPath!.row%10==5{
            }
        }
    }
    
}
