//
//  InputViewController.swift
//  PhotoApp
//
//  Created by 小室　亮太 on 2022/10/29.
//

import UIKit

class InputViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var userNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addButton(_ sender: Any) {
        //        ユーザー名
        UserDefaults.standard.set(userNameTextField.text, forKey: "userName")
        
        //        アイコンも一時的に保存
        //        画像データを10分の1に圧縮
        let date = logoImageView.image?.jpegData(compressionQuality: 0.1)
        UserDefaults.standard.set(date, forKey: "userImage")
        let nextVC = self.storyboard?.instantiateViewController(identifier: "nextViewController")as! NextViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    //    キーボードを下げる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userNameTextField.resignFirstResponder()
    }
    
    @IBAction func tapImageView(_ sender: Any) {
        showAlert()
    }
        
        //    カメラ立ち上げメソッド
        func checkCamera(){
            let sourceType:UIImagePickerController.SourceType = .camera
            
            //        カメラ利用可能かチェック
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                let cameraPicker = UIImagePickerController()
                cameraPicker.allowsEditing = true
                cameraPicker.sourceType = sourceType
                cameraPicker.delegate = self
                self.present(cameraPicker, animated: true,completion: nil)
                
            }
        }
        //    フォトライブラリの使用
        func checkAlbam() {
            let sourceType:UIImagePickerController.SourceType = .photoLibrary
            
            //        フォトライブラリのチェック
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                let cameraPicker = UIImagePickerController()
                cameraPicker.allowsEditing = true
                cameraPicker.sourceType = sourceType
                cameraPicker.delegate = self
                self.present(cameraPicker, animated: true,completion: nil)
            }
        }
        //    カメラとアルバムを受け取るメソッド
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if info[.originalImage] as? UIImage != nil{
                
                let selectesImage = info[.originalImage] as! UIImage
                
                UserDefaults.standard.set(selectesImage.jpegData(compressionQuality: 0.1), forKey: "userImage")
                
                logoImageView.image = selectesImage
                picker.dismiss(animated: true, completion: nil)
                
            }
        }
        
        
        /* 追加 */
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
        
    
    func showAlert(){
        let alertController = UIAlertController(title: "選択", message: "どちらを使用しますか", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "カメラ", style: .default) { (alert) in
            self.checkCamera()
        }
        
        let albamAction = UIAlertAction(title: "アルバム", style: .default) { (alert) in
            self.checkAlbam()
        }
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel)
        
        
        alertController.addAction(cameraAction)
        alertController.addAction(albamAction)
        alertController.addAction(cancelAction)
        self.present(alertController,animated: true,completion: nil)
    }
}



/* ここまで */
/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */



