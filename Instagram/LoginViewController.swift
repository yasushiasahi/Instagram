import UIKit
import Firebase
import FirebaseAuth
import SVProgressHUD

class LoginViewController: UIViewController {
	
	@IBOutlet weak var mailAddressTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var displayNameTextField: UITextField!
	
	
	@IBAction func handleLoginButton(_ sender: Any) {
		if let address = mailAddressTextField.text, let password = passwordTextField.text {
			
			// アドレスとパスワード名のいずれかでも入力されていない時は何もしない
			if address.characters.isEmpty || password.characters.isEmpty {
				SVProgressHUD.showError(withStatus: "必要項目を入力して下さい")
				return
			}
			
			// HUDで処理中を表示
			SVProgressHUD.show()
			
			Auth.auth().signIn(withEmail: address, password: password) { user, error in
				if let error = error {
					print("DEBUG_PRINT: " + error.localizedDescription)
					SVProgressHUD.showError(withStatus: "サインインに失敗しました。")
					return
				} else {
					print("DEBUG_PRINT: ログインに成功しました。")
					
					// HUDを消す
					SVProgressHUD.dismiss()
					
					// 画面を閉じてViewControllerに戻る
					self.dismiss(animated: true, completion: nil)
				}
			}
		}
	}
	
	
	@IBAction func handleCreateAcountButton(_ sender: Any) {
		if let address = mailAddressTextField.text, let password = passwordTextField.text, let displayName = displayNameTextField.text {
			
			// アドレスとパスワードと表示名のいずれかでも入力されていない時は何もしない
			if address.characters.isEmpty || password.characters.isEmpty || displayName.characters.isEmpty {
				print("DEBUG_PRINT: 何かが空文字です。")
				SVProgressHUD.showError(withStatus: "必要項目を入力して下さい")
				return
			}
			
			// HUDで処理中を表示
			SVProgressHUD.show()
			
			// アドレスとパスワードでユーザー作成。ユーザー作成に成功すると、自動的にログインする
			Auth.auth().createUser(withEmail: address, password: password) { user, error in
				if let error = error {
					// エラーがあったら原因をprintして、returnすることで以降の処理を実行せずに処理を終了する
					print("DEBUG_PRINT: " + error.localizedDescription)
					SVProgressHUD.showError(withStatus: "ユーザー作成時にエラーが発生しました。")
					return
				}
				
				print("DEBUG_PRINT: ユーザー作成に成功しました。")
				
				// 表示名を設定する
				let user = Auth.auth().currentUser
				if let user = user {
					let changeRequest = user.createProfileChangeRequest()
					changeRequest.displayName = displayName
					changeRequest.commitChanges { error in
						if let error = error {
							print("DEBUG_PRINT: " + error.localizedDescription)
						}
						print("DEBUG_PRINT: [displayName = \(String(describing: user.displayName))]の設定に成功しました。")
						
						// HUDを消す
						SVProgressHUD.dismiss()
						
						// 画面を閉じてViewControllerに戻る
						self.dismiss(animated: true, completion: nil)
					}
				} else {
					print("DEBUG_PRINT: displayNameの設定に失敗しました。")
				}
			}
		}
	}
	

    override func viewDidLoad() {
        super.viewDidLoad()
    }
	

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	


}
