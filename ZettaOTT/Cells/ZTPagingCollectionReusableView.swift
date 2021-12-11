//
//  ZTPagingCollectionReusableView.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 06/12/21.
//

import UIKit
protocol ZTCollectionPagingDelegate{
    func selectedVideoModel(movieInfo:Movies, indexVal:Int)
}
class ZTPagingCollectionReusableView: UICollectionReusableView, UIScrollViewDelegate {
    var delegate: ZTCollectionPagingDelegate? = nil
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    var frameVal: CGRect = CGRect(x:0, y:0, width:0, height:0)
    var videos : [Movies] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func loadPagingScroll(videosVal:[Movies]? = [], delegateObj:ZTCollectionPagingDelegate){
        self.delegate = delegateObj
        self.videos = videosVal ?? []
        self.configurePageControl()
        self.setupScrollView()
    }
    func setupScrollView(){
        self.mainScrollView.isPagingEnabled = true
        let width = self.mainScrollView.bounds.size.width
        let height = self.mainScrollView.bounds.size.height

        var x:CGFloat = 0
        for index in 0..<self.videos.count {
            if index > 0{
                x = width * CGFloat(index)
            }
            let subView = UIImageView()
            subView.frame = CGRect(x: x, y: 0, width: width, height: height)
            subView.layer.cornerRadius = 5.0
            subView.backgroundColor = .clear
            subView.contentMode = .scaleAspectFill
            Helper.shared.loadImage(url: self.videos[index].webStreamingNow ?? "", imageView: subView)
            
            let btnView = UIButton()
            btnView.frame = subView.frame
            btnView.tag = index
            btnView.addTarget(self, action: #selector(btnTapped(sender:)), for: .touchUpInside)

            self.mainScrollView.addSubview(subView)
            self.mainScrollView.addSubview(btnView)

        }
        self.mainScrollView.contentSize = CGSize(width:self.mainScrollView.bounds.width * CGFloat(self.videos.count) , height: height)
        
        self.pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: .valueChanged)

    }
    @objc func btnTapped(sender: UIButton){
        let movieInfo = self.videos[sender.tag]
        self.delegate?.selectedVideoModel(movieInfo: movieInfo, indexVal: sender.tag)
    }
    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * self.mainScrollView.frame.size.width
        self.mainScrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
       }
    func configurePageControl() {
           
        self.pageControl.numberOfPages = self.videos.count
        self.pageControl.currentPage = 0

    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
            pageControl.currentPage = Int(pageNumber)
    }
}
