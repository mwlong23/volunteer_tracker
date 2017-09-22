require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/project")
require("./lib/volunteer")
require("pg")

DB = PG.connect({:dbname => "volunteer_tracker"})


get("/") do
  erb(:index)
end

get("/projects") do
  @projects = Project.all()
  erb(:projects)
end

get("/projects/new") do
  erb(:project_form)
end

get("/projects/:id") do
  @project = Project.find(params.fetch("id").to_i())
  erb(:project)
end

post("/projects") do
  title = params.fetch("title")
  project = Project.new({:title => title, :id => nil})
  project.save()
  erb(:success)
end

post("/volunteers") do
  name = params.fetch("name")
  list_id = params.fetch("project_id").to_i()
  id = params.fetch("id").to_i
  @project = Project.find(project_id)
  @volunteer = Volunteer.new({:name => name, :list_id => list_id, :id => id})
  @volunteer.save()
  erb(:success)
end
