////
////  ResumeCell.swift
////  GlobalResume
////
////  Created by Joriah Lasater on 2/1/18.
////  Copyright © 2018 Joriah Lasater. All rights reserved.
////
//
////
////  CustomCell.swift
////  NoMoStowiiBowd
////
////  Created by Joriah Lasater on 2/1/18.
////  Copyright © 2018 Joriah Lasater. All rights reserved.
////
//
//import UIKit
//
//class ResumeCell: UICollectionViewCell {
//    
//    var resume: ResumeData!
//    
//    let imageView: UIImageView = {
//        let imageView = UIImageView(image: UIImage(named: "RESUME NAME"))
//        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//    
//    let circleView: UIView = {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
//        view.backgroundColor = UIColor.myBlue
//        view.layer.cornerRadius = view.frame.height/2
//        view.clipsToBounds = true
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    let textView: UITextView = {
//        let textView = UITextView()
//        let font = UIFont.myFontRegular.withSize(20)
//        textView.textColor = UIColor.myBlue
//        textView.font = font
//        textView.textAlignment = .center
//        textView.isEditable = false
//        textView.isUserInteractionEnabled = false
//        textView.translatesAutoresizingMaskIntoConstraints = false
//        return textView
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        backgroundColor = UIColor.white
//       
//        addSubview(circleView)
//        addSubview(textView)
//        circleView.addSubview(imageView)
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//     func viewUpdate() {
//        
//        circleView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        circleView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -circleView.frame.height/2).isActive = true
//        circleView.widthAnchor.constraint(equalToConstant: 150).isActive = true
//        circleView.heightAnchor.constraint(equalToConstant: 150).isActive = true
//        
//        imageView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor).isActive = true
//        imageView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor).isActive = true
//        imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
//        imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
//
//        if let text = resume.resume_name {
//            textView.text = text
//        }
//        
//        textView.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 20).isActive = true
//        textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
//        textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
//        textView.heightAnchor.constraint(equalToConstant: 60).isActive = true
//    }
//}

