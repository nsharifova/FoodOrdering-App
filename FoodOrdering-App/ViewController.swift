
import UIKit





class ViewController: UITabBarController {
    let tabbarView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpController()
        configureTabBar()
        addShadowToTabBar()
    }
    
    func setUpController(){
        viewControllers = [
            createNavController(for: HomeView(), title: NSLocalizedString("Home", comment: ""), image: UIImage(systemName: "house")!),
            createNavController(for: LikesView(), title: NSLocalizedString("Favorites", comment: ""), image: UIImage(systemName: "heart")!),
            createNavController(for: ProfileView(), title: NSLocalizedString("Profile", comment: ""), image: UIImage(systemName: "person.crop.circle")!),
            createNavController(for: CardView(), title: NSLocalizedString("Shopping Card", comment: ""), image: UIImage(systemName: "basket")!),
        ]
    }
    
   
    
    func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }
    
    func configureTabBar() {
        tabBar.barTintColor = .lightGray
        tabBar.tintColor = .blue
        tabBar.unselectedItemTintColor = .darkGray
        tabBar.backgroundColor = .white
    }
    
    func addShadowToTabBar() {
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.2
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -3)
        tabBar.layer.shadowRadius = 10
        tabBar.layer.masksToBounds = false
    }
    
    
}
