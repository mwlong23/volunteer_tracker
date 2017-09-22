class Project
  attr_accessor(:title , :id)

  def initialize(attributes)
    @name = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  def ==(another_project)
    self.title().==(another_project.title()).&(self.id().==(another_project.id()))
  end


end
