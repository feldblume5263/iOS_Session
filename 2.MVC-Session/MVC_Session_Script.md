# 1. MVC 아키텍처를 공부하는 이유

MVC 아키텍처는 UIKit 에서 기본적으로 쓰이는 아키텍처이고, 가장 쉬운 아키텍처 중에 하나입니다.

제일 유명한 아키텍처 중에 하나인 MVVM 아키텍처도 결국에는 개발자들이 MVC에서 불편한 점들을 해결하기위 해 시작된 것이기 때문에 MVC를 제대로 이해해야 다음으로 넘어갈 수 있죠!

하나의 아키텍처의 내용을 제대로 알고, 이를 통해 아키텍처를 왜 도입하는지 이해하는 것은 매우 중요합니다. 제가 첫 세션에 MVC를 알려드리고, MVC 클론코딩을 과제로 내드린 것도 하나의 아키텍처를 제대로 이해하는 것이 iOS개발의 시작이라고 생각해서입니다!ㅎㅎ

그럼 MVC 아키텍처를 한번 알아볼까요?

<br>

먼저, 제가 MVC의 예시로 간단하게 작성한 코드인 간단한 연락처를 추가하는 프로그램을 보면서 글을 읽어보시면 도움이 훨씬 많이 되실거에요!

<br>

[MVC_PhoneBook](https://github.com/feldblume5263/iOS_Session/tree/main/2.MVC-Session)

<br>

# 2. MVC 아키텍처의 구조

MVC의 구조는 매우 간단합니다.

MVC자체가 Model, View, Controller의 약자인데 이름 그대로 저 세개의 구성요소로 나뉘죠.

<br>

## 1) 모델 (Model)

Model은 데이터와 데이터의 가공을 책임지는 역할을 합니다.

<br>

다음과 같이 데이터에 대해서 설명하기도 하고,

```swift
@objc class PhoneData: NSObject {
    var name: String
    var number: String
    var company: String?

    init(name: String, number: String, _ company: String?) {
        self.name = name
        self.number = number
        self.company = company
    }
}
```

다음과 같이 데이터를 가지고 이를 가공하는 역할을 합니다.

```swift
final class PhoneBook: NSObject {
    @objc dynamic var phoneDatas = Set<PhoneData>()

    func getPhoneDatasOrder(by option: OrderingOption) -> [PhoneData] {
        switch option {
        case .name:
            return phoneDatas.sorted {
                $0.name < $1.name
            }
        case .company:
            return phoneDatas.sorted {
                $0.company ?? "" < $1.company ?? ""
            }
        }
    }

    func setNewPhoneData(name: String, number: String, company: String?) {
        phoneDatas.insert(PhoneData(name: name, number: number, company))
    }
}
```

<br>

Model에서 중요한 점은 View와 Controller의 정보를 가지고 있어서는 안된다는 것입니다.

이게 무슨 말일까요? 예를 들면 `phoneDatas` 가 바뀌었다고 해서 `PhoneBook 클래스`에서 직접 View를 수정하는 일은 없어야 한다는 것입니다. 

**Model은 단순히 데이터를 소유하고 가공하는 역할 그 이상을 수행해서는 안됩니다.**

<br>

## 2) 컨트롤러 (Controller)

원래는 View는 Controller와 독립된 컴포넌트여야 하지만, Swift의 UIkit 프레임워크 내에서는 이를 완벽하게 독립시키기가 여렵습니다.

UIKit에서는 Controller대신 ViewController를 사용합니다.

Controller가 기본적으로 가장 아랫단의 View의 역할을 하고, 해당 Root View의 라이프사이클을 가지고 있기 때문입니다. 또한 Delegate와 DataSource의 처리도 컨트롤러에서 일어납니다.

Swift의 MVC는 그래서 MVVC (Model, View, ViewController)라고 불리우기도 하고 Controller의 역할이 너무 비대해서 Massive Controller라고 불리우기도 합니다.

<br>

**Swift에서 ViewController는 유저의 이벤트를 처리하고, Model과 View들의 통신, Model과 ViewController의 통신을 모두 담당합니다.**

<br>

코드를 다 삭제했지만, 하는 일이 많아서 코드가 여전히 길어지죠?

```swift
final class PhoneBookViewController: UIViewController {
    lazy private var phoneBook = PhoneBook()
     ...
    lazy private var datas: [PhoneData] = [] {
        didSet {
            ...
        }
    }
    private var currentOption: OrderingOption = .name {
        didSet {
            ...
        }
    }

    override func loadView() {
        super.loadView()
        ...
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        ...
    }

    override func viewWillAppear(_ animated: Bool) {
        ...
    }
    ...
}

...

extension PhoneBookViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        ...
        return cell
    }
}
```

<br>

## 3) 뷰 (View)

뷰는 단순히 UI를 의미합니다.

**Model이 가지고 있는 정보를 따로 저장해서는 안되고, 단지 독립된 UI로서 우리가 원하는 화면을 구현하기만 하면 됩니다.**

<br>

```swift
final class MainFloatingButton: UIButton {

    init(title: String) {
        super.init(frame: CGRect(origin: .zero, size: .zero))
        self.layer.cornerRadius = 10.0
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = .black
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
```

<br>

# 3. MVC에서 Data Binding

MVC에서 모델, 컨트롤러, 뷰를 나누는 것은 그렇게 어렵지 않습니다.

하지만 중요한 것은 Model과 View이 서로 각자의 역할만 해야하는 것이고, 이를 위해서 Swift에서는 다양한 Data Biinding 디자인패턴을 제시하지만, 이 중에서 가장 대표적인 몇가지 방법만 알아보려고 합니다. (KVO와 Delegate 패턴)

![image](https://user-images.githubusercontent.com/53016167/189516761-41eb76ad-9b7f-45db-abd4-dc22d3d5b4b0.png)

## 1) Model <-> ViewController

ViewController는 Model을 그대로 가져다가 쓸 수 있습니다.

다음과 같이요!

```swift
final class PhoneBookViewController: UIViewController {
    lazy private var phoneBook = PhoneBook()
    ...
```

<br>

하지만 아까 Model은 View나 ViewController를 변경하면 안된다고 했죠?

다음과 같이 컨트롤러가 Model을 변경했을 때, Controller는 Model이 변경되었다는 것을 알아채고 이를 View에 반영해주어야 합니다.

다음 코드는 예시 프로젝트의 `PhoneBookViewController` 에서 Model의 값을 변경하는 함수입니다.

해당 코드는 `PhoneBook` 객체의 `phoneDatas`를 수정합니다.

```swift
func addDataAtForm(data: PhoneData) {
    phoneBook.setNewPhoneData(name: data.name, number: data.number, company: data.company)
}
```

<br>

그렇다면, Model이 바뀌었다는 것을 ViewController은 어떻게 알 수 있을까요?

가장 자주 쓰이는 방법은 `Notification`과 `KVO` 입니다.

![image](https://user-images.githubusercontent.com/53016167/189516794-18061481-38de-4ce3-a866-8a4aae402fc3.png)

여기서는 KVO 패턴에 대해서만 간단하게 설명을 할게요.

KVO 패턴은 Key Value Observing의 약자로 객체의 프로퍼티의 변경사항을 알리기 위한 디자인 패턴입니다.

마치 라디오처럼 해당 객체의 프로퍼티의  변경사항을 관찰(Observe)하고 있는 객체에 알리는 것이죠.

<br>

코드로 한번 살펴볼까요?

먼저 KVO를 사용하기 위해서는 해당 클래스가 NSObject를 상속해야 합니다.

또 해당 클래스에서 추적하고 싶은 프로퍼티는 `@objc`와 `dyanmic modifier`을 추가해주어야 합니다.  (Object-C의 유물...)

```swift
final class PhoneBook: NSObject {
    @objc dynamic var phoneDatas = Set<PhoneData>()
    ...
}
```

저는 다음과 같이 `PhoneData`의 Collection을 추적하고 싶어요.

그렇게 하기 위해서는 `PhoneData` 도 NSObejct를 상속해야 합니다.

```swift
@objc class PhoneData: NSObject {
    var name: String
    var number: String
    var company: String?

    init(name: String, number: String, _ company: String?) {
        self.name = name
        self.number = number
        self.company = company
    }
}
```

자 이렇게 변화를 추적 당할 준비가 완료되었으면 추적 해주어야겠죠?

```swift
final class PhoneBookViewController: UIViewController {
    private var observer: NSKeyValueObservation!
    lazy private var datas: [PhoneData] = [] {
        didSet {
            dataTableView.reloadData()
        }
    }
    ...

    override func viewDidLoad() {
        super.viewDidLoad()
        ...
        observer = phoneBook.observe(\.phoneDatas) { (data, change) in
            self.datas = self.phoneBook.getPhoneDatasOrder(by: self.currentOption)
        }
    }
}
```

다음과 같이, 저는 `PhoneBook` 객체의 `phoneDatas` 프로퍼티를 추적했고 변경사항이 있을 때마다, viewController의 `datas` 프로퍼티를 새롭게 업데이트 해주었습니다.

또 datas가 업데이트 될 때마다 이를 사용하는 tableView 또한 reload 해주었죠.

이렇게 KVO를 통해서 Model의 property가 변경될 때마다, 이를 추적해서 ViewController에서 특정 동작을 해줄 수 있게 하는 것입니다.

Model은 추적 당하기만 하지 View와 ViewController의 아무것도 알지 못하죠!

## 2) ViewController <-> View

마찬가지로 View는 단순히 UI를 표시할 뿐 ViewController에 대해서는 알지 못합니다. View에는 어떤 Data도 저장하지 않고 단순히 ViewController의 Data를 이용하는 거죠.

<br>

![image](https://user-images.githubusercontent.com/53016167/189517577-84c7138c-d577-44d2-8eae-6d1cc19060a2.png)

<br>

다음 코드처럼 ViewController는 View를 알고 있어서 View의 property에 바로 접근할 수  있습니다.

다음 코드에서는 ViewController가 `MainFloatingButton`의 `title`을 직접 수정하고 있습니다.

```swift
private var currentOption: OrderingOption = .name {
        didSet {
            switch currentOption {
            case .name:
                listOptionButton.setTitle("Name", for: .normal)
                ...
            case .company:
                listOptionButton.setTitle("Company", for: .normal)
                ...
            }
        }
    }
```

<br>

하지만, View는 어떤 Data를 소유하지 못하고, Event처리도 ViewController에서 해주어야 합니다.

(ViewController가 하는게 너무 많죠? 너무 많다고 생각하시는게 맞습니다.. 실제로 많거든요.)

View에서 Data를 이용하기 위해서는 ViewController의 Data를 가져다 사용해야 합니다.

이를 위해 여러가지 방법이 있지만, 가장 대표적으로 사용되는 방법은 Delegate 디자인패턴입니다.

<br>

우리는 이미 delegate pattern을 사용하고 있습니다.

다음처럼 우리는 tableView의 datasource라는 delegate를 ViewController에서 채택해서 tableView에서 ViewController에 요구하는 변경사항을 처리하고 있거든요.

```swift
final class PhoneBookViewController: UIViewController {
    private var dataTableView: UITableView!

    ...

    override func viewDidLoad() {
        super.viewDidLoad()
        dataTableView.datasource = self
        ...
    }



extension PhoneBookViewController: UITableViewDataSource {
     ...

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = datas[indexPath.row]
        let cell = dataTableView.dequeueReusableCell(withIdentifier: "dataCell") as? PhoneDataTableViewCell ?? UITableViewCell()

        (cell as? PhoneDataTableViewCell)?.nameLabel.text = data.name
        (cell as? PhoneDataTableViewCell)?.numberLabel.text = data.number
        (cell as? PhoneDataTableViewCell)?.companyLabel.text = data.company
        return cell
    }
}
```

우리가 직접 view에서 Delegate 패턴을 만들어서 ViewController에서 처리할 수 있습니다.

예제 코드에서는 ViewController간의 통신을 위해 delegate 패턴을 사용했지만, 이는 View와 ViewController간의 통신에도 적용이 되는 것이기 때문에 그대로 이용해볼게요.

<br>

다음 코드는 AddDataViewController에서 Delegate를 생성해서 이를 PhoneBookViewController에서 채택해서 AddDataViewDelegate의 요구사항을 처리하도록 하는 예시입니다.

먼저 Delegate를 만드는 부분이에요.

다음과 같이 delegate를 만들어서 delegate가 어딘가에서 채택됐는지를 확인하고

`if let delegate = delegate` 

delegate를 채택한 Controller에서 구현한 해당 함수를 사용하는거죠!

`delegate.addDataAtForm(data: PhoneData(name: name, number: number, companyTextField.text))`

```swift
protocol AddDataViewDelegate: AnyObject {
    func addDataAtForm(data: PhoneData)
}

final class AddDataViewController: UIViewController {
    ...
    weak var delegate: AddDataViewDelegate?

    ...
    
    @objc func completeButtonPressed(_ sender: UIBarButtonItem) {
        if let delegate = delegate {
            let name = nameTextField.text ?? ""
            let number = numberTextField.text ?? ""
            if name.count > .zero && number.count > .zero {
                delegate.addDataAtForm(data: PhoneData(name: name, number: number, companyTextField.text))
                _ = navigationController?.popViewController(animated: true)
            } else {
                let sheet = UIAlertController(title: "Data Error", message: "you need name and number", preferredStyle: .alert)
                sheet.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in  }))
                present(sheet, animated: true)
            }
        }
    }
}
```

<br>

PhoneBookViewController 다음과 같이 AddDataViewDelegate를 채택해서 해당 요구사항을 구현합니다.

다음처럼 해당 컨트롤러의 delegate를 "내가 처리할게!" 하면서 채택해주고`controller.delegate = self` 

해당 프로토콜을 채택해서 `PhoneBookViewController: AddDataViewDelegate`

요구사항을 구현하죠. `func addDataAtForm(data: PhoneData) { ... }`

```swift
final class PhoneBookViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "addDataView") as? AddDataViewController {
            controller.delegate = self
        }
        ...
    }
}

extension PhoneBookViewController: AddDataViewDelegate {
   ...

    func addDataAtForm(data: PhoneData) {
        phoneBook.setNewPhoneData(name: data.name, number: data.number, company: data.company)
    }
}
```

<br>

지금까지 MVC의 데이터 바인딩에 필수적인 디자인 패턴에 대해서 알아봤어요. (KVO, Delegate)

<br>

# 4. MVC 세션을 끝마치면서

조금 더 쉽게 설명했으면 좋았을 부분들, 특히 data binding과 관련된 부분이 한번에 설명하기에는 조금 많은 부분이라서 간략하게 설명하느라 놓친 부분이 많은 것 같은 아쉬움이 많이 남는데요..

잘 이해가 가지 않는 부분은 언제든지 놔스닥을 찾아서 질문을 해주시면 됩니다! 

Slack의 question 채널에 남겨주셔도 좋고, 혹시 저와 직접 이야기를 나누면서 정리하신게 있다면 question 채널에 올려주시면 모든 팀원이 볼 수 있어서 더 좋은 것 같아요!

짱크로 팀원들 화이팅입니다!
