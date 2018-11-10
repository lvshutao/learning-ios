import UIKit

class ImagePicker: UIViewController {
    
    // 步骤1：创建控制器，并设置代理
    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        imagePickerController.delegate = self
        
        // 步骤2：相要显示哪些数据
        self.imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 50, y: 50, width: 80, height: 30)
        btn.setTitle("图片", for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        self.view.addSubview(btn)
        
        btn.addTarget(self, action: #selector(choosePhotoFromLibrary), for: .touchUpInside)
        
        // 其它功能，比如自定义界面
        // https://www.jianshu.com/p/48ffc684c881
        // google: uiimagepickercontroller custom buttons
        // https://stackoverflow.com/questions/41459983/how-can-i-add-custom-button-in-uiimagepickercontroller-popover
    }
    
    @objc func choosePhotoFromLibrary() {
        self.present(self.imagePickerController, animated: true, completion: nil)
    }
}

// 步骤3：实现代理方法
extension ImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage]  as? UIImage
        if image != nil{
            let imageView = UIImageView(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
            imageView.image = image
            self.view.addSubview(imageView)
        } else {
            print("image nil")
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
