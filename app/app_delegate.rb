class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    
    @tasks = Task.deserialize_from_file('tasks.dat')
    @tasks = Task.all
    puts "**** DELEGATE : @tasks: #{@tasks}"
    @todo_controller       = TodoController.alloc.initWithTasks(@tasks)
    @navigation_controller = UINavigationController.alloc.initWithRootViewController(@todo_controller)
    
    @window.rootViewController = @navigation_controller
    @window.makeKeyAndVisible

    true
  end
end
