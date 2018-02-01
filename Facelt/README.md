## 제스쳐 추가하기

* #### 코드로 추가하기
<pre><code>
@IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(
                target: faceView, action: #selector(FaceView.changeScale(recognizer:))
            ))
            
            addHappierSwipeGestureRecognizer()
            
            addSadderSwipeGestureRecognizer()
            
            updateUI()
        }
    }
    
    func addHappierSwipeGestureRecognizer(){
        let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(
            target: self,
            action: #selector(FaceViewController.increaseHappiness)
        )
        happierSwipeGestureRecognizer.direction = .up
        faceView.addGestureRecognizer(happierSwipeGestureRecognizer)
    }
    
    func addSadderSwipeGestureRecognizer(){
        let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(
            target: self,
            action: #selector(FaceViewController.decreaseHappiness)
        )
        sadderSwipeGestureRecognizer.direction = .down
        faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)
    }
</code></pre>
1. 제스쳐를 추가할 View(FaceView)를 StoryBoard에 추가한 후 oulet으로 Controller클래스에 연결합니다.

2. GestureRecognizer 객체를 생성합니다.<pre><code>let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(
            target: self,
            action: #selector(FaceViewController.increaseHappiness)
        )
        </code></pre>
3. GestureRecognizer를 설정한 후에 faceView에 제스쳐를 추가합니다.
	<pre><code>
        faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)
        </code></pre>

* #### Strory Board에서 추가하기

<pre><code>
@IBAction func toggleEyes(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            switch expression.eyes{
            case .Open : expression.eyes = .Closed
            case .Closed : expression.eyes = .Open
            case .Squinting : expression.eyes = .Squinting
            }
        }
    }</code></pre>

1. StoryBoard에 있는 View에 버튼 추가하듯이 Gesture를 추가합니다.
2. StoryBoard에 있는 Gesture를 드래그앤 드랍으로 Controller에 action으로 연결합니다.
3. 특정 제스쳐가 인식 됐을때 로직을 설정합니다.

----
### 화면 전환하기

* #### NavigationViewController를 이용한 화면 전환
<pre><code>
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationViewController = segue.destination
        
        if let navigationController = destinationViewController as? UINavigationController{
            destinationViewController = navigationController.visibleViewController ?? destinationViewController
        }
        
        if let faceViewController = destinationViewController as? FaceViewController {
            if let identifier = segue.identifier {
                if let expression = emotinalFaces[identifier]{
                    faceViewController.expression = expression
                    if let sedingButton = sender as? UIButton{
                        faceViewController.navigationItem.title = sedingButton.currentTitle
                    }
                }
            }
        }
    } 
</code></pre>
1. StoryBoard를 이용해서 segue를 연결해줍니다. 앱을 실행 시켜보면 아시겠지만 저는 SplitView에서 NavigationView로 연결했습니다. 이 방법으로하면 아이패드와 아이폰에서 서로 다른 방식으로 보여지게 됩니다. 아이패드에서는 SplitView로 보여지고, 아이폰에서는 NavigationView로 보여지게 됩니다.
2. segue를 연결한 후에 다른 이동할 목적지(destination)를 설정 합니다. 저는 FaceVIewController로 이동 하겠습니다.
3. FaceViewController 객체를 제대로 할당 받았다면 identifier를 확인 합니다. identifier는 StroyBoard에서 segue를 연결할때 할당할 수 있습니다.
4. 그리고 identifier가 제대로 할당 됐다면 필요한 로직을 실행 시켜줄 수 있습니다.

* ##### 주의
	* 만약 NavigationViewController에서 A라는 NavigationItem을 실행 시킨 후에 뒤로 갔다가 다시 A NavigationItem을 실행하면 이전 A의 MVC와 이후에 실행한 A의 MVC는 와전히 다른 객체입니다. 즉, NavigationVIew는 스택처럼 쌓이는 형태인데 새로운 스택이 쌓이면 새로운 MVC를 생성합니다.
