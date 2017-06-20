import Foundation
import UIKit

class PowerLevelView: UIView {
    
    //число полосок уровней
    let countLevels = 8
    //ширина столба
    let levelWidth = 11
    //коэффициент для вычисления лесенки
    let koef: CGFloat = 0.4
    //цвет неактивного уровня
    var levelColor = UIColor(red: 239.0/255.0, green: 238.0/255.0, blue: 239.0/255.0, alpha: 1.0)
    //цвет активного уровняs
    var activeLevelColor = UIColor(red: 98/255.0, green: 204/255.0, blue: 235/255.0, alpha: 1.0)
    
    var levelViews: [UIView]?
    
    var currentLevel = 0
    
    required override public init(frame: CGRect) {
        super.init(frame: frame)
        self.initViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initViews()
    }
    
    func refresh()
    {
        if (self.levelViews == nil) {
            return
        }
        let space = (self.frame.size.width - CGFloat(levelWidth * countLevels)) / CGFloat(countLevels - 1)
        let yStep = self.frame.height * koef / CGFloat(countLevels)
        var x: CGFloat = 0.0
        for i in 0..<countLevels {
            let y = yStep * CGFloat(countLevels - i)
            let r = CGRect(x: x, y: y, width: CGFloat(levelWidth), height: self.frame.size.height - y)
            let v = levelViews?[i] as! UIView
            if(i < currentLevel) {
                v.backgroundColor = activeLevelColor
            }
            else
            {
                v.backgroundColor = levelColor
            }
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        refresh()
    }
    
    fileprivate func initViews()
    {
        if (self.levelViews != nil) {
            return
        }
        //пространство между столбами
        levelViews = []
        let space = (self.frame.size.width - CGFloat(levelWidth * countLevels)) / CGFloat(countLevels - 1)
        let yStep = self.frame.height * koef / CGFloat(countLevels)
        var x: CGFloat = 0.0
        for i in 0..<countLevels {
            let y = yStep * CGFloat(countLevels - i)
            let r = CGRect(x: x, y: y, width: CGFloat(levelWidth), height: self.frame.size.height - y)
            let v = UIView(frame: r)
            v.backgroundColor = levelColor
            levelViews?.append(v)
            self.addSubview(v)
            x = x + CGFloat(levelWidth) + space
        }
    }
    
    func setLevel(_ level : Int) {
        self.currentLevel = level
        refresh()
    }
    
    deinit {
        levelViews = nil
    }
}