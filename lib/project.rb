class Project
  attr_accessor(:title , :id)

  def initialize(attributes)
    @name = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  def ==(another_project)
    self.title().==(another_project.title()).&(self.id().==(another_project.id()))
  end

  def self.all
    returned_projects = DB.exec('SELECT * FROM projects;')
    projects = []
    returned_projects.each() do |project|
      title = project.fetch(:title)
      id = project.fetch(:id).to_i
      # projects.push(project.new({title: title, id: id}))
    end
    projects
  end


end
