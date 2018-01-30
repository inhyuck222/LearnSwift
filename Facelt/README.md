# 제스쳐 추가하기

### 코드로 추가하기
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

### Strory Board에서 추가하기

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
