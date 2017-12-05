//
//  ViewController.swift
//  SHSeatSelection
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var seatCollectionView: UICollectionView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var screen: UIView!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var seatID: UILabel!
    
    
    var classTitle = ["Platinum","Gold","Silver"]
    var seatLayout = ["Platinum":[1,1,1,1,1,1,1,2,2,1,1,1,],"Gold":[2,1,1,1,1,1,1,2,2,2,2,1,2,2,1,1,1,1,1,2,2,1,1,2,2,1,1,1,1,1,1,2,2,2,2,1],"Silver":[1,1,1,1,1,1,1,2,2,1,1,1,1,1,1,1,1,1,1,2,2,1,1,1,1,1,1,1,1,1,1,2,2,1,1,1,0,1,1,1,2,1,1,1,1,2,2,0,0,1,2,2,2,2,1,1,1,2,1,0,0,2,2,1,1,1,2,2,2,2,2,0]]
    var seatCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        posterImage.layer.cornerRadius = 5
        posterImage.layer.masksToBounds = true
        screen.layer.cornerRadius = 3
        screen.layer.masksToBounds = true
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return classTitle.count
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCell", for: indexPath) as? SHHeader{
            sectionHeader.headerLabel.text = "\(classTitle[indexPath.section])"
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (seatLayout[classTitle[section]]?.count)!
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "seatCell", for: indexPath) as! seatCell
        if seatLayout[classTitle[indexPath.section]]![indexPath.row] == 0 {
            cell.seat.image = nil
        }else if seatLayout[classTitle[indexPath.section]]![indexPath.row] == 1 {
            cell.seat.image = #imageLiteral(resourceName: "filled")
        }else if seatLayout[classTitle[indexPath.section]]![indexPath.row] == 2 {
            cell.seat.image = #imageLiteral(resourceName: "unFilled")
        }else{
            cell.seat.image = #imageLiteral(resourceName: "selected")
        }
        return cell

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if seatLayout[classTitle[indexPath.section]]![indexPath.row] != 0 && seatLayout[classTitle[indexPath.section]]![indexPath.row] != 1 {
            if seatLayout[classTitle[indexPath.section]]![indexPath.row] != 3{
                seatLayout[classTitle[indexPath.section]]![indexPath.row] = 3
                seatCount += 1
                if seatCount == 1{
                    showBottomView()
                }
                setSeatnPrice()
            }else{
                seatLayout[classTitle[indexPath.section]]![indexPath.row] = 2
                seatCount -= 1
                if seatCount == 0{
                    hideBottomView()
                }
                setSeatnPrice()
            }
            seatCollectionView.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let deviceWidth = (view.frame.width/12)-10
        return CGSize(width: deviceWidth, height: deviceWidth)
    }

    func showBottomView(){
        seatCollectionView.scrollsToTop = true
        UIView.animate(withDuration: 0.5, animations: {
            self.bottomViewHeight.constant = 50
            self.view.layoutIfNeeded()
        }) { (success) in
        }
    }
    func hideBottomView(){
        UIView.animate(withDuration: 0.5, animations: {
            self.bottomViewHeight.constant = 0
            self.view.layoutIfNeeded()
        }) { (success) in
        }
    }
    
    func setSeatnPrice(){
        let price = Double(seatCount)*100.00
        if price != 0.0 {
            payButton.setTitle("Pay ₹ \(price)", for: .normal)
        }else{
            payButton.setTitle("", for: .normal)
        }
        seatID.text = "\(seatCount) Seat"
    }
}

