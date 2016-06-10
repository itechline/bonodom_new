//
//  AddEsateteSceneViewController.swift
//  Bonodom
//
//  Created by Attila Dan on 10/06/16.
//  Copyright © 2016 Itechline. All rights reserved.
//

/*import UIKit

class AddEsateteSceneViewController: UIViewController, UIPageViewControllerDataSource {
    
    
    var pageViewController : UIPageViewController!
    var pageTitles: NSArray!
    var pageImages: NSArray!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.pageTitles = NSArray(object: "Explore", "Today Widget")
        self.pageImages = NSArray(object: "bonodom_icon","main_house")
        
        self.pageViewController = self.storyboard?.instantiateInitialViewController("PageViewController") as UIPageViewController
        
        self.pageViewController.dataSource = self
        
        var startVC = self.viewControllerAtIndex(0) as ContentViewController
        
        var viewControllers = NSArray(object: startVC)
        
        self.pageViewController.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRectMake(0, 30, self.view.frame.width, self.view.frame.size.height - 60)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func NextAction(sender: AnyObject) {
        
        var startVC = self.viewControllerAtIndex(0) as ContentViewController
        var viewControllers = NSArray(object: startVC)
        self.pageViewController.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
    }
    
    func viewControllerAtIndex(index: Int) -> ContentViewController{
        
        if((self.pageTitles.count == 0) || (index >= self.pageTitles.count)){
            return ContentViewController()
        }
        var vc: ContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentViewController") as ContentViewController
        
        vc.imageFile = self.pageImages[index] as String
        vc.titleText = self.pageTitles[index] as String
        vc.pageIndex = index
        
        return vc
    }
    
    
    //MART: -pageviewcontroller DataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var vc = viewController as ContentViewController
        var index = vc.pageIndex as Int
        
        if (index == 0 || index = NSNotfound)
        {
            return nil
        }
        index--
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var vc = viewController as ContentViewController
        var index = vc.pageIndex as Int
        
        if (index == NSNotFound){
            return nil
        }
        index++
        
        if (index == self.pageTitles.count){
            return nil
        }
        
        return self.viewControllerAtIndex(index)

    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.pageTitles.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    
    
}*/
