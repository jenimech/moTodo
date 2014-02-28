class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    
    @tasks = Task.deserialize_from_file('tasks.dat')
    puts ">>>>>>>> DELEGATE TASKS : #{@tasks}"
    @tasks = Task.all
    puts ">>>>>>>> DELEGATE Task.all: #{@tasks}"
    
    @todo_controller       = TodoController.alloc.initWithTasks(@tasks)
    @navigation_controller = UINavigationController.alloc.initWithRootViewController(@todo_controller)
    
    @window.rootViewController = @navigation_controller
    @window.makeKeyAndVisible

    true
  end
end
