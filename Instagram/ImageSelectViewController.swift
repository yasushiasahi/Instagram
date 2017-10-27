import UIKit

class ImageSelectViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	@IBAction func handleLibraryButton(_ sender: Any) {
		// ライブラリ（カメラロール）を指定してピッカーを開く
		if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
			let pickerController = UIImagePickerController()
			pickerController.delegate = self
			pickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
			self.present(pickerController, animated: true, completion: nil)
		}
	}
	
	@IBAction func handleCameraButton(_ sender: Any) {
		// カメラを指定してピッカーを開く
		if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
			let pickerController = UIImagePickerController()
			pickerController.delegate = self
			pickerController.sourceType = UIImagePickerControllerSourceType.camera
			self.present(pickerController, animated: true, completion: nil)
		}
	}
	
	@IBAction func handleCancelButton(_ sender: Any) {
		// 画面を閉じる
		self.dismiss(animated: true, completion: nil)
	}
	
	// 写真を撮影/選択したときに呼ばれるメソッド
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		if info[UIImagePickerControllerOriginalImage] != nil {
			// 撮影/選択された画像を取得する
			let image = info[UIImagePickerControllerOriginalImage] as! UIImage
			
			// あとでAdobeUXImageEditorを起動する
			
		}
		
		// 閉じる
		picker.dismiss(animated: true, completion: nil)
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		// 閉じる
		picker.dismiss(animated: true, completion: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}
