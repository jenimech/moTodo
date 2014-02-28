class TodoController < UIViewController
  attr_accessor :tasks

  def initWithTasks(tasks)
    initWithNibName(nil, bundle: nil)
    self.tasks = tasks
    self
  end

  def viewDidLoad
    super
    puts "******* VIEWDIDLOAD TASKS: #{self.tasks}"
    self.title = "ToDo"
    self.view.backgroundColor = UIColor.whiteColor
    @container = UIView.alloc.initWithFrame [[0,0], [self.view.frame.size.width, 150]]
    @container.backgroundColor = UIColor.lightGrayColor
    self.view.addSubview @container

    #input
    @text_field = UITextField.alloc.initWithFrame [[0,0], [160, 26]]
    @text_field.placeholder = "ToDo"
    @text_field.textAlignment = UITextAlignmentCenter
    @text_field.center = CGPointMake(@container.frame.size.width / 2, @container.frame.size.height / 2 + 20)
    @text_field.borderStyle = UITextBorderStyleRoundedRect
    @container.addSubview @text_field
    #button
    @add = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @add.setTitle("Add", forState: UIControlStateNormal)
    @add.setTitle("Adding...", forState: UIControlStateDisabled)
    @add.sizeToFit
    @add.center = CGPointMake(@container.frame.size.width / 2 + 100, @text_field.center.y)
    @container.addSubview @add

    #table for tasks
    table_frame = [[0, @container.frame.size.height], [self.view.bounds.size.width, self.view.bounds.size.height - @container.frame.size.height - self.navigationController.navigationBar.frame.size.height]]
    @table = UITableView.alloc.initWithFrame(table_frame, style: UITableViewStylePlain)
    self.view.addSubview @table
    
    #event add toDo
    @add.when(UIControlEventTouchUpInside) do
      @add.enabled = false
      @text_field.enabled = false

      new_task   = Task.create(:title => @text_field.text, :done => false)
      self.tasks = Task.deserialize_from_file('tasks.dat')
      @table.reloadData

      @add.enabled = true
      @text_field.enabled = true
      @text_field.text = ""
    end

    @table.dataSource = self
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    @reuseIndentifier = "CELL_IDENTIFIER"
    self.tasks = Task.all
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIndentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end
    cell.textLabel.text = self.tasks[indexPath.row]
    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    # Task.all.count
    puts ">>>> tableView: self.tasks: #{self.tasks}"
    puts ">>>> tableView: @tasks: #{@tasks}"
    self.tasks = Task.all
    self.tasks.count
  end
end